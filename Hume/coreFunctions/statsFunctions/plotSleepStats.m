function stageStats = plotSleepStats(file, onsetMode, remRules, endSleepMode, importFunction, outdir, outfile)
% stageStats = plotSleepStats(stageData, outname)
%
%   Command-line backend for sleep statistics calculation. Called from Húmë
%   gui's sleepStats and sleepStats_woInput.
%
%   Inputs (required)
%       
%       file
%           The data can be of multiple forms:
%            
%           1. stagedata - a scoring struct from sleepSMG scoring must have the following fields:
%           stages - complete stage vector with the 7's appended to the beginning
%           win - your scoring window size in seconds
%           Notes - any string
%           lightsON - a datevec for lights on
%           lightsOFF - a datevec for lights off
%           recStart - a datevec for the record start
%           srate - sampling rate of the data (used for plotHypnogram)
%           stageTime - The start time in seconds of each epoch in the stages vector (it should start at 0) (used for plotHypnogram)
%
%           markedEvents (optional): An 2d matrix of event counts by epoch.
%           Each row is an epoch and each column is an event as defined by
%           the eventLUT.m file. 
%
%           2. path to stage data (string variable pointing to file name of
%           stageData.mat)
%
%           3. External stage file (REQURIES USE OF IMPORT FUNCTION BELOW)
%
%   Inputs (optional)
%
%       onsetMode ? Scalar 1 through 4. Sleep Latency Definition. 
%           1 = first epoch of 90 seconds sleep [DEFAULT]
%           2 = first epoch of sleep
%           3 = first epoch of Stage 2 sleep
%           4 = first epoch of 10 minutes sleep
%
%       remRules ? [1 x 3] vector containing the follwoing information:
%            combiningRule ? minutes of not REM sleep to allow within a REM period (default ? 25 minutes)
%           REMmin ? minimum time for a REM period (excluding first and
%           alast) (default ? 0 minutes)
%           miniumum stage to end a REM period (default - 0; wakefulness)
%
%       endSleepMode ? [1 vs 2] rules for final awakening
%            1 ? Requiring same definition as sleep onset (DEFAULT, e.g. early morning sleep is considered beyond final awakening if it does not match 90 seconds contiguous)
%            2 ? FINAL epoch of sleep
%
%       importFunction (String) ? Which command to use to read in data (see
%       import functions)
%
%       outdir ? where to palce data
%
%       outfile ? stemName to print out all data
%
%  Outputs:
%   
%       stageStats - a struct with all the statistics calculated
% 
% File outputs:
% 
%   outfile/outfile.mat - the stageStats struct
%   outfile/outfile.csv - a csv file of all the fields in stageStats
%   outfile/outfile.html - web page output of all the stats
%   outfile/outfile.png - hyponogram of data (used by outname.html)
%   outfile/outfile.png - hyponogram of data with SW sleep collapsed (used by outname.html)
%   outfile/outfile_SPdist.jpg - bar graph of sleep percentage distributions (used by outname.html)
% 
%%   Copyright (c) 2015 Jared M. Saletin, PhD and Stephanie M. Greer, PhD
%
%   This file is part of Húmë.
%   
%   Húmë is free software: you can redistribute it and/or modify it
%   under the terms of the GNU General Public License as published by the
%   Free Software Foundation, either version 3 of the License, or (at your
%   option) any later version.
% 
%   Húmë is distributed in the hope that it will be useful, but
%   WITHOUT ANY WARRANTY; without even the implied warranty of
%   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
%   General Public License for more details.
% 
%   You should have received a copy of the GNU General Public License along
%   with Húmë.  If not, see <http://www.gnu.org/licenses/>.
%
%   Húmë is intended for research purposes only. Any commercial or medical
%   use of this software is prohibited. The authors accept no
%   responsibility for its use in this manner.
%%

%% set up


set(0,'DefaultAxesFontName', 'Times New Roman');
if ischar(file)
    [path, fileName, fileExt] = fileparts(file);
    
    if ~isempty(importFunction)
        
        eval(['[scorer id cond outname outfile stageData] = ',importFunction,'(file,200);']);
        stageStats.fileName = outname;
        
    elseif strcmp(fileExt,'.mat')
        load(file);
        cond = '';
        id = '';
        scorer = '';
        if(nargin<6)
            outfile = fileName;
            outname = [path,outfile,'/',outfile];
            mkdir([path,fileName]);
        elseif(nargin<7)
            outname = [path,outfile,'/',stageStats];
            fileName='stageStats';
            outfile = 'stageStats';
        end
    end
else
    
    cond = '';
    id = '';
    scorer = '';
    if(nargin < 6)
        fileName = 'stageStats';
        outname = ['stageStats/stageStats'];
        mkdir(fileName);
    elseif(nargin<7)
        outname = [outdir,'/',outdir];
    else
        mkdir([outdir,'/',outfile]);
        outname = [outdir,'/',outfile,'/',outfile];
    end
    stageData = file;
    
    
end

stageStats.stageData = stageData;

if isempty(endSleepMode)
    endSleepMode = 1;  % 1 = SPT ends with the final epoch of at least 3 contiguous epochs of sleep; % 2 = SPT ends on the final epoch scored sleep;
end

    exportMode = 1; % 1 = EVERYTHING

% REM SPECIFICATION

    if isempty(remRules)
        
            combining = 25; % REM/NREM combining rule in minutes
            REMmin = 0; % Minimum amount of time in REM required for period in minutes
            stStage = 0; % Stage of sleep that can trigger a NREM period.
    else
        
        combining = remRules(1);
        REMmin = remRules(2);
        stStage = remRules(3);
    end
    
        if combining == 25 && REMmin == 0 && stStage == 0
            % CARSKADON RULES
            remDefinitions = ['<b>NREM-REM Cycle definitions per Carskadon and Rechtschaffen (2005).</b><br><br>', ...
                '<b>NREM-REM Cycle:</b> Succession of NREM period of at least 25 minutes duration by a REM period.<br>', ...
                '<b>NREM Period:</b> Time interval between first occurance of not REM and the first epoch of the next REM period, subject to combining rule.<br>', ...
                '<b>REM Period:</b> Time interval between two consecutive NREM periods  or the between the last NREM period and final awakening.<br>', ...
                '<b>NREM/REM Segments:</b> Number of uninterrupted periods of NREM/REM during a NREM/REM period.<br><br>' ];
        
        elseif combining == 15 && REMmin == 5 && stStage == 2
            % WALKER LAB RULES
            remDefinitions = ['<b>NREM-REM Cycle definitions per the modified criterion of Feinberg and Flyod (1979) as in Aeschbach and Borb&eacute;ly (1993).</b><br><br>', ...
                '<b>NREM-REM Cycle:</b> Succession of NREM period of at least 15 minutes duration by a REM period of at least 5 minutes duration.<br>', ...
                '<b>No minimum duration for the first or last REM period.</b><br>', ...
                '<b>NREM Period:</b> Time interval between first occurance of Stage 2 and the first epoch of the next REM period.<br>', ...
                '<b>REM Period:</b> Time interval between two consecutive NREM periods  or the between the last NREM period and final awakening.<br>', ...
                '<b>NREM/REM Segments:</b> Number of uninterrupted periods of NREM/REM during a NREM/REM period.<br><br>' ];
        else 
             remDefinitions = sprintf('<b>NREM-REM Cycle:</b> Succession of NREM period of at least %d minutes duration by a REM period of at least %d minutes (excluding first and last REM periods).<br>',combining,REMmin);
             remDefinitions = [remDefinitions, '<b>NREM Period:</b> Time interval between first occurance of not REM and the first epoch of the next REM period, subject to combining rule.<br>', ...
                '<b>REM Period:</b> Time interval between two consecutive NREM periods  or the between the last NREM period and final awakening.<br>', ...
                '<b>NREM/REM Segments:</b> Number of uninterrupted periods of NREM/REM during a NREM/REM period.<br><br>' ];
        end


stageStats.rules.combiningRule = combining;
stageStats.rules.minREMlength = REMmin;
stageStats.rules.onsetRule = onsetMode;

stages = stageData.stages(min(find(stageData.stages ~= 7)):max(find(stageData.stages ~=7) ));
stageStats.TDTstages = stages;
%onsets = stageData.onsets;
win = stageData.win;

%csvwrite('stages.txt', stages)

stageMap = {'Wake'; 'Stage 1'; 'Stage 2'; 'Stage 3'; 'Stage 4'; 'REM'; 'MT'; 'None'};

report = '<html>';

if ~strcmp(outfile,'stageStats')
    report = [report,   sprintf('<head><title>Sleep Statistics Report %s</title></head>',outfile)];
    report = [report, sprintf('<body><h1 align="center">*** Sleep Statistics Report: %s ***</h1>\n', outfile)];
else
    report = [report,   sprintf('<head><title>Sleep Statistics Report</title></head>')];
    report = [report, sprintf('<body><h1 align="center">*** Sleep Statistics Report***</h1>\n')];
end

report = [report, sprintf('<h3 align="center">Generated on: %s<h3>\n', date)];
    
if size(stageData.Notes,1)>=1
    report = [report, sprintf('<hr><h2>Header Info:</h2>\n')];
    
    for n = 1:size(stageData.Notes, 1)
        report = [report, sprintf('%s<br>', sprintf(stageData.Notes(n, :)))];
    end
end

report = [report, sprintf('<br><hr><h2>File Overview:</h2>\n')];

report = [report, sprintf('<b>Scoring window:</b> %d secs<br>\n', win)];
report = [report, sprintf('<br><b>Lights OUT:</b> %s<br>\n', datestr(stageData.lightsOFF, 'HH:MM:SS.FFF'))];
stageStats.lightsOUT = datestr(stageData.lightsOFF, 'HH:MM:SS.FFF');
report = [report, sprintf('<b>Lights ON:</b> %s<br>\n', datestr(stageData.lightsON, 'HH:MM:SS.FFF'))];
stageStats.lightsON = datestr(stageData.lightsON, 'HH:MM:SS.FFF');

report = [report, sprintf('<br><b>First scored epoch:</b> %d<br>\n', min(find(stageData.stages ~= 7)))];
report = [report, sprintf('<b>Last scored epoch:</b> %d<br>\n', max(find(stageData.stages ~= 7)))];

%% Cal sleep latency

if isempty(onsetMode)
    onsetMode = 1;
end

switch onsetMode
    case 1
        [sleepLat latDef] = calcSleepLat(stages);
    case 2
        [sleepLat latDef] = calcSleepLat1EP(stages);
    case 3
        [sleepLat latDef] = calcSleepLatS2(stages);
    case 4
        [sleepLat latDef] = calcSleepLat10(stages,win);
end

allSleep = find(stages > 0 & stages < 6);

%% Find End of SPT

switch endSleepMode
    
    case 1
        
       stagesREV = flip(stages);
    switch onsetMode
    case 1
        [sleepEnd] = calcSleepLat(stagesREV);
    case 2
        [sleepEnd] = calcSleepLat1EP(stagesREV);
    case 3
        [sleepEnd] = calcSleepLatS2(stagesREV);
    case 4
        [sleepEnd] = calcSleepLat10(stagesREV, win);
    end
    sleepEnd = (length(stages) - sleepEnd) + 1;
    SPTdef = 'Sleep period time (elapsed time from sleep onset through last epoch of unambiguous sleep [see sleep onset]).';
    
   
    case 2
        
    sleepEnd = allSleep(end);
    SPTdef = 'Sleep period time (elapsed time from sleep onset through last epoch of sleep).';
    
end
        
allScored = find(stageData.stages < 7);
timeBeforeScore = allScored(1) - 1;
%%%%%%%%%%%%%

report = [report, sprintf('<br><b>Sleep onset epoch:</b> %d (<b>relative to record start:</b> %d)<br>\n', sleepLat, sleepLat + timeBeforeScore)];
report = [report, sprintf('<b>Final awakening epoch:</b> %d (<b>relative to record start:</b> %d)<br>\n', sleepEnd, sleepEnd + timeBeforeScore)];
report = [report, sprintf('<b>First scored epoch relative to record start:</b> %d<br>\n', timeBeforeScore + 1)];
stageStats.milestones = [sleepLat (sleepLat+timeBeforeScore); sleepEnd, (sleepEnd+timeBeforeScore);(timeBeforeScore+1) NaN];

%% Calc latency to 10 minutes Contiguous 
[sleepLat10 latDef10] = calcSleepLat10(stages, win);

%% calc last stage
tmp = stages(stages > 0);
lastStage = stages(sleepEnd);
report = [report, sprintf('<b>Last stage of sleep:</b> %s<br>\n', stageMap{lastStage + 1})];
stageStats.lastStageSleep = stageMap{lastStage + 1};

onT = floor((etime(datevec(stageData.lightsON), datevec(stageData.recStart)))/win);
%% calc awake at lights on
if(stageData.stages(onT) == 0)
    awakeP = 'Yes';
elseif(stageData.stages(onT) ~=7)
    awakeP = 'No';
else
    awakeP = 'Unscored';
end
report = [report, sprintf('<b>Awake at lights on?</b> %s<br>\n', awakeP)];
stageStats.awakeLightsOn = awakeP;

%% Sleep percentages table %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

report = [report, '<br><hr><td><h2>Sleep Continuity and Architecture:</h2></td>'];
report = [report, '<table><tr><td>'];
report = [report, sprintf('<table cellpadding="5">\n<tr><td></td><td><b>Epochs</b></td><td><b>Minutes</b></td><td><b>%%TDT</b></td><td><b>%%SPT</b></td><td><b>%%TST</b></td></tr>\n')];

%TDTepoch = sum(stages < 7);
TDTepoch = length(stages);
SPTepoch = length((stages(sleepLat:sleepEnd)));
TSTepoch = sum(stages(sleepLat:sleepEnd) > 0 & stages(sleepLat:sleepEnd) < 6);

%TDT
report = [report, sprintf('<tr><td><b>Total dark time:</b></td><td>%d</td><td>%.1f</td><td>%.2f</td><td>%.2f</td><td>%.2f</td></tr>\n', TDTepoch, (TDTepoch*win)/60, TDTepoch/TDTepoch*100, TDTepoch/SPTepoch*100, TDTepoch/TSTepoch*100)];
stageStats.percentSleep(1, :) = [TDTepoch, (TDTepoch*win)/60, TDTepoch/TDTepoch, TDTepoch/SPTepoch, TDTepoch/TSTepoch];

%SPT
report = [report, sprintf('<tr><td><b>Sleep period time:</b></td><td>%d</td><td>%.1f</td><td>%.2f</td><td>%.2f</td><td>%.2f</td></tr>\n', SPTepoch, (SPTepoch*win)/60, SPTepoch/TDTepoch*100, SPTepoch/SPTepoch*100, SPTepoch/TSTepoch*100)];
stageStats.percentSleep(2, :) = [SPTepoch, (SPTepoch*win)/60, SPTepoch/TDTepoch, SPTepoch/SPTepoch, SPTepoch/TSTepoch];

%TST
report = [report, sprintf('<tr><td><b>Total sleep time:</b></td><td>%d</td><td>%.1f<td>%.2f</td><td>%.2f</td><td>%.2f</td></tr>\n', TSTepoch, (TSTepoch*win)/60, TSTepoch/TDTepoch*100, TSTepoch/SPTepoch*100,TSTepoch/TSTepoch*100)];
stageStats.percentSleep(3, :) = [TSTepoch, (TSTepoch*win)/60, TSTepoch/TDTepoch, TSTepoch/SPTepoch, TSTepoch/TSTepoch];

%SBSO
SBSO = sum(stages(1:sleepLat-1) > 0 & stages(1:sleepLat-1) < 7);
report = [report, sprintf('<tr><td><b>Sleep before sleep onset:</b></td><td>%d</td><td>%.1f</td><td>%.2f</td><td>%.2f</td><td>%.2f</td></tr>\n', SBSO, (SBSO*win)/60, SBSO/TDTepoch*100, SBSO/SPTepoch*100, SBSO/TSTepoch*100)];
stageStats.percentSleep(4, :) = [SBSO, (SBSO*win)/60, SBSO/TDTepoch, SBSO/SPTepoch, SBSO/TSTepoch];

%WASO
WASO = sum(stages(sleepLat:sleepEnd) == 0);
report = [report, sprintf('<tr><td><b>Wake after sleep onset:</b></td><td>%d</td><td>%.1f</td><td>%.2f</td><td>%.2f</td><td>%.2f</td></tr>\n', WASO, (WASO*win)/60, WASO/TDTepoch*100, WASO/SPTepoch*100, WASO/TSTepoch*100)];
stageStats.percentSleep(5, :) = [WASO, (WASO*win)/60, WASO/TDTepoch, WASO/SPTepoch, WASO/TSTepoch];

%WAFA
WAFA = sum(stages(sleepEnd+1:end) == 0);
report = [report, sprintf('<tr><td><b>Wake after final awakening:</b></td><td>%d</td><td>%.1f</td><td>%.2f</td><td>%.2f</td><td>%.2f</td></tr>\n', WAFA, (WAFA*win)/60, WAFA/TDTepoch*100, WAFA/SPTepoch*100, WAFA/TSTepoch*100)];
stageStats.percentSleep(6, :) = [WAFA, (WAFA*win)/60, WAFA/TDTepoch, WAFA/SPTepoch, WAFA/TSTepoch];

%SAFA
SAFA = sum(and(stages(sleepEnd+1:end) > 0, stages(sleepEnd+1:end) < 6));
report = [report, sprintf('<tr><td><b>Sleep after final awakening:</b></td><td>%d</td><td>%.1f</td><td>%.2f</td><td>%.2f</td><td>%.2f</td></tr>\n', SAFA, (SAFA*win)/60, SAFA/TDTepoch*100, SAFA/SPTepoch*100, SAFA/TSTepoch*100)];
stageStats.percentSleep(7, :) = [SAFA, (SAFA*win)/60, SAFA/TDTepoch, SAFA/SPTepoch, SAFA/TSTepoch];

%%% Total wake time
cur = sum(stages == 0);
report = [report, sprintf('<tr><td><b>%s</b></td><td>%d</td><td>%.1f</td><td>%.2f</td><td>%.2f</td><td>%.2f</td></tr>\n', 'Total wake time:', cur, (cur*win)/60, cur/TDTepoch*100, cur/SPTepoch*100, cur/TSTepoch*100)];
stageStats.percentSleep(8, :) = [cur, (cur*win)/60, cur/TDTepoch, cur/SPTepoch, cur/TSTepoch];

%%%% Percentages for each stage of sleep
for s = 1:6
    cur = sum(stages(sleepLat:sleepEnd) == s);
    report = [report, sprintf('<tr><td><b>%s</b></td><td>%d</td><td>%.1f</td><td>%.2f</td><td>%.2f</td><td>%.2f</td></tr>\n', [stageMap{s + 1},':'], cur, (cur*win)/60, cur/TDTepoch*100, cur/SPTepoch*100, cur/TSTepoch*100)];
    stageStats.percentSleep(8 + s, :) = [cur, (cur*win)/60, cur/TDTepoch, cur/SPTepoch, cur/TSTepoch];
end

%%% NREM
cur = sum(stages(sleepLat:sleepEnd) > 0 & stages(sleepLat:sleepEnd) < 5);
report = [report, sprintf('<tr><td><b>%s</b></td><td>%d</td><td>%.1f</td><td>%.2f</td><td>%.2f</td><td>%.2f</td></tr>\n', 'NREM:', cur, (cur*win)/60, cur/TDTepoch*100, cur/SPTepoch*100, cur/TSTepoch*100)];
stageStats.percentSleep(15, :) = [cur, (cur*win)/60, cur/TDTepoch, cur/SPTepoch, cur/TSTepoch];

%%% SW
cur = sum(stages(sleepLat:sleepEnd) > 2 & stages(sleepLat:sleepEnd) < 5);
report = [report, sprintf('<tr><td><b>%s</b></td><td>%d</td><td>%.1f</td><td>%.2f</td><td>%.2f</td><td>%.2f</td></tr>\n', 'SW:', cur, (cur*win)/60, cur/TDTepoch*100, cur/SPTepoch*100, cur/TSTepoch*100)];
stageStats.percentSleep(16, :) = [cur, (cur*win)/60, cur/TDTepoch, cur/SPTepoch, cur/TSTepoch];

%Anomalous 
Anom = sum(stages == 7);
report = [report, sprintf('<tr><td><b>Anomalous (Unscored):</b></td><td>%d</td><td>%.1f</td><td>%.2f</td><td>%.2f</td><td>%.2f</td></tr>\n', Anom, (Anom*win)/60, Anom/TDTepoch*100, Anom/SPTepoch*100, Anom/TSTepoch*100)];
stageStats.percentSleep(17, :) = [Anom, (Anom*win)/60, Anom/TDTepoch, Anom/SPTepoch, Anom/TSTepoch];


report = [report, '</table>'];

%% Sleep distributions chart
% 
% plotSleepDist(stageStats.percentSleep);
% set(gcf, 'PaperPositionMode', 'auto');
% saveas(gcf, [outname, '_SPdist.png'], 'png')
% close(gcf);
% report = [report, '</td><td>'];
% report = [report, sprintf('<img src=''%s''>', [outname, '_SPdist.png'])]; 
% report = [report, '</td></table>'];


%%   Latencies Table %%
%%%%%%%%%%%%%%%%%%%%%%%

report = [report, '<br><hr><h2>Sleep Latencies:</h2>'];
report = [report, sprintf('<table cellpadding="5">\n<tr><td></td><td><b>Epochs</b></td><td><b>Minutes</b><td></tr>\n')];

cur = sleepLat - 1;
report = [report, sprintf('<tr><td><b>Lights out to %s:</b></td><td>%d</td><td>%.1f</td></tr>\n', 'sleep onset', cur, (cur*win)/60)];
stageStats.SleepLat(1, :) = [cur, (cur*win)/60];

cur = sleepLat10 - 1;
report = [report, sprintf('<tr><td><b>Lights out to %s:</b></td><td>%d</td><td>%.1f</td></tr>\n', '10 min. continuous sleep', cur, (cur*win)/60)];
stageStats.SleepLat(2, :) = [cur, (cur*win)/60];

%%%% latencies form lights out for each
for s = 1:4
    all = find(stages == s);
    if(~isempty(all))
        cur = all(1) - 1;
    else
        cur = NaN;
    end
    report = [report, sprintf('<tr><td><b>Lights out to %s:</b></td><td>%d</td><td>%.1f</td></tr>\n', stageMap{s + 1}, cur, (cur*win)/60)];
    stageStats.SleepLat(s+ 2, :) = [cur, (cur*win)/60];
end

latSW = min([stageStats.SleepLat(5,1) stageStats.SleepLat(6,1)]);
report = [report, sprintf('<tr><td><b>Lights out to SW:</b></td><td>%d</td><td>%.1f</td></tr>\n', latSW, (latSW*win)/60)];
stageStats.SleepLat(7, :) = [latSW, (latSW*win)/60];

s = 5;
all = find(stages == s);
if(~isempty(all))
    cur = all(1) - 1;
else
    cur = NaN;
end
report = [report, sprintf('<tr><td><b>Lights out to %s:</b></td><td>%d</td><td>%.1f</td></tr>\n', stageMap{s + 1}, cur, (cur*win)/60)];
stageStats.SleepLat(8, :) = [cur, (cur*win)/60];

s = 7;
all = find(stages == s);
if(~isempty(all))
    cur = all(1) - 1;
else
    cur = NaN;
end
report = [report, sprintf('<tr><td><b>Lights out to %s:</b></td><td>%d</td><td>%.1f</td></tr>\n', 'Anomalous (Unscored)', cur, (cur*win)/60)];
stageStats.SleepLat(9, :) = [cur, (cur*win)/60];

%%%% latencies from sleep onset for each
for s = 1:4
    all = find(stages(sleepLat:sleepEnd) == s);
    if(~isempty(all))
        cur = all(1) - 1;
    else
        cur = NaN;
    end
    report = [report, sprintf('<tr><td><b>Sleep onset to %s:</b></td><td>%d</td><td>%.1f</td></tr>\n', stageMap{s + 1}, cur, (cur*win)/60)];
    stageStats.SleepLat(s + 9, :) = [cur, (cur*win)/60];
end

latSW = min([stageStats.SleepLat(12,1) stageStats.SleepLat(13,1)]);
report = [report, sprintf('<tr><td><b>Sleep onset to SW:</b></td><td>%d</td><td>%.1f</td></tr>\n', latSW, (latSW*win)/60)];
stageStats.SleepLat(14, :) = [latSW, (latSW*win)/60];

    s = 5;
    all = find(stages(sleepLat:sleepEnd) == s);
    if(~isempty(all))
        cur = all(1) - 1;
    else
        cur = NaN;
    end
    report = [report, sprintf('<tr><td><b>Sleep onset to %s:</b></td><td>%d</td><td>%.1f</td></tr>\n', stageMap{s + 1}, cur, (cur*win)/60)];
    stageStats.SleepLat(15, :) = [cur, (cur*win)/60];
    
report = [report, '</table>'];

%% Events

if(isfield(stageData, 'MarkedEvents') && ~isfield(stageData, 'EventMat'))
    stageData = smgEventConvert(stageData);
    
end

if(isfield(stageData, 'eventMat'))
    
    report = [report, '<br><hr><h2>Event Counts:</h2>'];
    
    LUT = eventLUT;
    eventSums = nansum(stageData.eventMat,1);
    eventToPlot = find(eventSums>0);
    
    report = [report, sprintf(['<table cellpadding="5">\n', ...
                                '<tr><th></th><th align="center" colspan="5">Within SPT</th><th></th><th align="center" colspan="2">Outside SPT</th></tr>\n', ...
                               '<tr><td></td><td><b>Wake</b></td><td><b>MT</b></td><td><b>NREM</b></td><td><b>REM</b></td><td><b>TST</b></td><td></td><td><b>Sleep</b></td><td><b>Wake</b></td></tr>\n'])];

    for i = 1:length(eventToPlot)
        
        % Set up Table of events by Wake, MT, NREM Sleep, REM Sleep, All
        % Sleep
            
            ev = stageData.eventMat(:,eventToPlot(i));
            
            % TRIM TO TDT
            ev = ev(min(find(stageData.stages ~= 7)):max(find(stageData.stages ~=7) ));
            
            % OUTSIDE SPT
            evPreSleep = ev(1:sleepLat-1);
            if ~isempty(evPreSleep)
                
                evSleepEx1 = nansum(evPreSleep(and(stages(1:sleepLat-1)<6,stages(1:sleepLat-1)>0)));
                evWEx1 = nansum(evPreSleep(stages(1:sleepLat-1)==0));
            else
                evSleepEx1=NaN;
                evWEx1=NaN;
            end
                
            evPostSleep = ev(sleepEnd+1:end);
                if ~isempty(evPostSleep)
                    evSleepEx2 = nansum(evPostSleep(and(stages(sleepEnd+1:end)<6,stages(sleepEnd+1:end)>0)));
                    evWEx2 = nansum(evPostSleep(stages(sleepEnd+1:end)==0));
                else
                    evSleepEx2 = NaN;
                    evWEx2 = NaN;
                end
            evSleepEx = nansum([evSleepEx1;evSleepEx2]);
            evWakeEx = nansum([evWEx1;evWEx2]);

            
                
            % SPT
            evR = nansum(ev((stages(sleepLat:sleepEnd)==5)));
            evN = nansum(ev((and(stages(sleepLat:sleepEnd)>=1 , stages(sleepLat:sleepEnd)<=4))));
            evW = nansum(ev((stages(sleepLat:sleepEnd)==0))); 
            evTST = evR+evN;
            evMT = nansum(ev((stages(sleepLat:sleepEnd)==6)));
            
            eventRow = [evW evMT evN evR evTST evSleepEx evWakeEx];
            
            report = [report, sprintf('<tr><td><b>%s</b></td><td>%d</td><td>%d</td><td>%d</td><td>%d</td><td>%d</td><td></td><td>%d</td><td>%d</td></tr>\n', [LUT{eventToPlot(i),2},':'], eventRow)];
            stageStats.eventData.events{i,1} = LUT{eventToPlot(i),2};
            stageStats.eventData.events{i,2} = eventRow;           
            stageStats.eventData.eventTotals = eventSums;
            stageStats.eventData.LUT = LUT;
    end
    report = [report, '</tr></table>'];

end

%% Sleep splits - Quarters and thirds
report = [report, '<br><hr><h2>Interval Analysis:</h2>'];

report = [report, '<br><table cellpadding="5"><tr>'];
report = [report, '<td><h3>Quarters (min)</h3></td>'];
report = [report, '<td><h3>Thirds (min)</h3></td>'];
report = [report, '<td><h3>Halves (min)</h3></td></tr>'];

%%%%%%%%%%%%%  get Quarters
report = [report, '<tr><td>'];
[report, stageStats, breaks] = sleepSplit(report, stageStats, stages(sleepLat:sleepEnd), stageMap, 4, win);
stageStats.quarterBounds = breaks + sleepLat - 1;
%%%%%%%%%%%%%  get Thirds
report = [report, '</td><td>'];
[report, stageStats, breaks] = sleepSplit(report, stageStats, stages(sleepLat:sleepEnd), stageMap, 3, win);
stageStats.thirdBounds = breaks + sleepLat - 1;
%%%%%%%%%%%%%  get Halves
report = [report, '</td><td>'];
[report, stageStats, breaks] = sleepSplit(report, stageStats, stages(sleepLat:sleepEnd), stageMap, 2, win);
stageStats.halfBounds = breaks + sleepLat - 1;
report = [report, '</td></tr></table>'];

report = [report, '<br><table cellpadding="5"><tr>'];
report = [report, '<td><h3>Hourly Split (min)</h3></td></tr>'];

%%%%%%%%%%%%%  get Hourly Break
splitFactor = SPTepoch / (60 * (60/win));
report = [report, '</td><td>'];
[report, stageStats, breaks] = sleepSplit(report, stageStats, stages(sleepLat:sleepEnd), stageMap, splitFactor, win);
stageStats.hourBounds = breaks + sleepLat - 1;
report = [report, '</td></tr></table><br>'];

%% Cycle stats
report = [report, '<hr><h2>Cycle Analysis:</h2>'];

%% Calculate split of first Cycle according to Jenni 2004 (split first period if no SWA for 12 minutes)
nonSWmin = 12;
[cycleBounds, NREMsegs, REMsegs] = getNREMcyc_splitJenni(stages(sleepLat:sleepEnd), win, combining, REMmin, stStage, nonSWmin);
cycleBounds(cycleBounds > 0) = cycleBounds(cycleBounds > 0) + sleepLat - 1;
stageStats.cycleBoundsJenniSplit = cycleBounds;

%% Normal Split 
[cycleBounds, NREMsegs, REMsegs] = getNREMcyc(stages(sleepLat:sleepEnd), win, combining, REMmin, stStage);
cycleBounds(cycleBounds > 0) = cycleBounds(cycleBounds > 0) + sleepLat - 1;
stageStats.cycleBounds = cycleBounds;

for i = 1:length(NREMsegs)
    stageStats.NREMsegs{i} = NREMsegs{i} + sleepLat - 1;
end
for i = 1:length(REMsegs)
    stageStats.REMsegs{i} = REMsegs{i} + sleepLat - 1;
end
report = [report, '<table cellpadding="5"><tr><td>'];
report = [report, '<h3>NREM-REM Cycle Stats (min)</h3>'];
[report, stageStats, dataOut] = makeSectionStats(report, stageStats, stages, stageMap, cycleBounds(cycleBounds(:, 2) > 0, [1, 3]), win);
report = [report, '</tr></table>'];
report = [report, '</td></table>'];
stageStats.CycleStats = dataOut;

%%%%%%%%%%%%%%%% NREM Period
report = [report, '<h3>NREM Period Stats (min)</h3>'];
endNREMper = cycleBounds(:, 2) - 1;
if(endNREMper(end) == -1)
    endNREMper(end) = cycleBounds(end, 3);
end
[report, stageStats, dataOut] = makeSectionStats(report, stageStats, stages, stageMap, [cycleBounds(:, 1), endNREMper], win);
report = [report, '<tr><td><b>Segments:</b></td>'];
lastRow = length(dataOut) + 1;
for c = 1:length(NREMsegs)
    report = [report, sprintf('<td>%d</td>', size(NREMsegs{c}, 1))];
    dataOut(lastRow, c) = size(NREMsegs{c}, 1);
end
report = [report, '</tr></table>'];
report = [report, '</td></table>'];
stageStats.NREMperiodStats = dataOut;

%%%%%%%%%%%%%%%% REM Period
report = [report, '<h3>REM Period Stats (min)</h3>'];
[report, stageStats, dataOut] = makeSectionStats(report, stageStats, stages, stageMap, cycleBounds(cycleBounds(:, 2) > 0, [2, 3]), win);
report = [report, '<tr><td><b>Segments:</b></td>'];
lastRow = length(dataOut) + 1;
for c = 1:length(REMsegs)
    report = [report, sprintf('<td>%d</td>', size(REMsegs{c}, 1))];
    dataOut(lastRow, c) = size(REMsegs{c}, 1);
end
report = [report, '</tr></table>'];
stageStats.REMperiodStats = dataOut;


% Edited by Jared, 11/5/10, exports: #Cycles, #Periods, Mean #Segments/Cycle, Stdev #Segments/Cycle
if(~isempty(stageStats.REMperiodStats))
    stageStats.CycleSummary = [size(stageStats.CycleStats,2) length(REMsegs) mean(stageStats.REMperiodStats(end, :)) std(stageStats.REMperiodStats(end,:))];
else
    stageStats.CycleSummary = [size(stageStats.CycleStats,2) length(REMsegs) NaN NaN];
end
%% REM summary

allREM = find(stages == 5);
allSleep = find(stages > 0 & stages < 7);
allScored = find(stages < 7);

if(~isempty(allREM))
    REMtoLsleep = ((sleepEnd + timeBeforeScore) - allREM(end))*win/60;
    REMtoLon = (allScored(end) - allREM(end))*win/60;
else
    REMtoLsleep = NaN;
    REMtoLon = NaN;

end

report = [report, sprintf('<br><b>Last REM to final awakening: %.1f</b><br>\n', REMtoLsleep)];
stageStats.REMtoLsleep = REMtoLsleep;

report = [report, sprintf('<b>Last REM to lights on: %.1f</b><br>\n', REMtoLon)];
stageStats.REMtoLon = REMtoLon;

%% Transition table

transTableAllStr = '<table cellpadding="5"><tr><td><b>From\To</b></td><td><b>Wake</b></td><td><b>Stage 1</b></td><td><b><b>Stage 2</b></td><td><b>Stage 3</b></td><td><b>Stage 4</b></td><td><b>REM</b></td><td><b>MT</b></td></tr>';
transTableAll = zeros(7, 7);
stagesOrig = stages(1:(end -1));
stagesLag = stages(2:end);

for t = 0:6
    transTableAllStr = [transTableAllStr, '<tr><td><b>', stageMap{t + 1}, ':</b></td>'];
    for t2 = 0:6
        transTableAll(t+1, t2+1) = sum(stagesOrig == t & stagesLag == t2);
        if(t == t2)
            transTableAllStr = [transTableAllStr, '<td><b>', num2str(transTableAll(t+1, t2+1)), '</b></td>'];
        else
            transTableAllStr = [transTableAllStr, '<td>', num2str(transTableAll(t+1, t2+1)), '</td>'];
        end
    end
    transTableAllStr = [transTableAllStr, '</tr>'];
end
transTableAllStr = [transTableAllStr, '</table>'];
stageStats.transTableAll = transTableAll;

transTableCollapseStr = '<table cellpadding="5"><tr><td><b>From\To</b></td><td><b>Wake</b></td><td><b>Stage 1</b></td><td><b><b>Stage 2</b></td><td><b>SW</b></td><td><b>REM</b></td><td><b>MT</b></td></tr>';
transTableCollapse = zeros(6, 6);
stagesOrig(stagesOrig == 4) = 3;
stagesLag(stagesLag == 4) = 3;

stageNums = [0, 1, 2, 3, 5, 6];
for t = 1:6
    if(t== 4)
        transTableCollapseStr = [transTableCollapseStr, '<tr><td><b>SW:</b></td>'];
    else
        transTableCollapseStr = [transTableCollapseStr, '<tr><td><b>', stageMap{stageNums(t) + 1}, ':</b></td>'];
    end
    for t2 = 1:6
        transTableCollapse(t, t2) = sum(stagesOrig == stageNums(t) & stagesLag == stageNums(t2)); 
        if(t == t2)
            transTableCollapseStr = [transTableCollapseStr, '<td><b>', num2str(transTableCollapse(t, t2)), '</b></td>'];
        else
            transTableCollapseStr = [transTableCollapseStr, '<td>', num2str(transTableCollapse(t, t2)), '</td>'];
        end
    end
    transTableCollapseStr = [transTableCollapseStr, '</tr>'];
end
transTableCollapseStr = [transTableCollapseStr, '</table>'];
stageStats.transTableCollapse = transTableCollapse;


%% write output

%writeStruct(stageStats, [outname, '_stats.csv'])
save([outname, '_stats.mat'], 'stageStats')

if isfield(stageData,'eventMat')
    
    plotHypnogramEVENTS(stageData, stageStats.cycleBounds, 1); % SW SEPARATED - TYPE 1 - JMS 7/30/14
else
    plotHypnogram(stageData, stageStats.cycleBounds, 1); % SW SEPARATED - TYPE 1 - JMS 7/30/14
end

set(gcf, 'PaperPositionMode', 'auto');
saveas(gcf, [outname, '_hyp1.png'], 'png');
close(gcf);

report = [report, '<br><hr><h2>Hypnograms and Transition Tables:</h2>'];

report = [report, sprintf('<h3>Full Hypnogram:</h3><img src=''%s''>', [outname, '_hyp1.png'])]; 
report = [report, '<h3>Full Transition Table:</h3>', transTableAllStr];

% stageDataSW = stageData;
% stageDataSW.stages(stageDataSW.stages == 4) = 3;
if isfield(stageData,'eventMat')
    
    plotHypnogramEVENTS(stageData, stageStats.cycleBounds, 2); % SW SEPARATED - TYPE 1 - JMS 7/30/14
else
    plotHypnogram(stageData, stageStats.cycleBounds, 2); % SW SEPARATED - TYPE 1 - JMS 7/30/14
end
set(gcf, 'PaperPositionMode', 'auto');
saveas(gcf, [outname, '_hyp2.png'], 'png');
close(gcf);
report = [report, sprintf('<h3>SW Collapsed Hypnogram:</h3><img src=''%s''>', [outname, '_hyp2.png'])]; 
report = [report, '<h3>SW Collapsed Transition Table:</h3>', transTableCollapseStr];

%% report definitions

report = [report, sprintf('<hr><h2>Sleep Statistics Definitions and Explanations:</h2><p>')];
report = [report, '<b>TDT:</b> Total dark time (elapsed time from lights out to lights on).<br>'];
report = [report, sprintf('<b>SPT:</b> %s <br>', SPTdef)];
report = [report, '<b>TST:</b> Total sleep time (duration of time spent in Stages 1, 2, 3, 4 and REM during SPT).<br>', ...
'<b>Total Wake Time:</b> Duration of time awake (within TDT).<br>', ...    
'<b>NREM:</b> Duration of time in Stages 1, 2, 3, 4.<br> ', ...
'<b>SW:</b> Slow wave sleep (Stages 3, 4). <br>', ...
'<b>All sleep stage statistics (and TST) tabulated from within SPT. Extraneous sleep outside of SPT is SBSO (see below).</b><br><br>'];
report = [report,sprintf('<b>Sleep Onset:</b> %s<br>\n',latDef)];
report = [report, '<b>Wake After Sleep Onset:</b> Wake time after sleep onset during SPT.<br> ', ...
'<b>Wake After Final Awakening:</b> Elapsed time spent awake between the final epoch of SPT and lights on. <br>', ...
'<b>Sleep Before Sleep Onset:</b> Any transient sleep occurring between lights off and sleep onset.<br> ', ...
'<b>Sleep After Final Onset:</b> Any transient sleep occurring between the final epoch of SPT and lights on.<br> ', ...
'<b>All Stage Latencies:</b> Elapsed time to first epoch of specified stage (from either lights off or sleep onset, as specified).<br>', ...
'<b>All Interval Analyeses:</b> Calculated from SPT. <br><br>' ];

report = [report, remDefinitions];

report = [report, '<b>All other sleep statistics per: <br><br>',...
'Carskadon, MA, Rechtschaffen, A. Monitoring and Staging Human Sleep. In: Principles and Practices of Sleep Medicine 4th Edition, pgs. 1359-1377. Ed: Kryger, MH, Roth, T, Dement, WC.  Philadelphia, PA : Elsevier Saunders, 2005.<br><br>',...
'</p>'];
...

%% PRINT OUT DATA

statistics = reshape(stageStats.percentSleep(:,2:5)',1,numel(stageStats.percentSleep(:,2:5)));
latencies = stageStats.SleepLat(:,2)';
switch exportMode
    
    case 1
        data = [statistics latencies];
        varNames = {'ID' 'COND' 'SCORER' ... % DATA FROM TASCI FILENAME
                    'TDT_min' 'TDT_%TDT' 'TDT_%SPT' 'TDT_%TST' ... % DATA FROM PERCENT SLEEP VARIABLE
                    'SPT_min' 'SPT_%TDT' 'SPT_%SPT' 'SPT_%TST' ...
                    'TST_min' 'TST_%TDT' 'TST_%SPT' 'TST_%TST' ...
                    'SBSO_min' 'SBSO_%TDT' 'SBSO_%SPT' 'SBSO_%TST' ...
                    'WASO_min' 'WASO_%TDT' 'WASO_%SPT' 'WASO_%TST' ...
                    'WAFA_min' 'WAFA_%TDT' 'WAFA_%SPT' 'WAFA_%TST' ...
                    'SAFA_min' 'SAFA_%TDT' 'SAFA_%SPT' 'SAFA_%TST' ...
                    'TWT_min' 'TWT_%TDT' 'TWT_%SPT' 'TWT_%TST' ...
                    'S1_min' 'S1_%TDT' 'S1_%SPT' 'S1_%TST' ...
                    'S2_min' 'S2_%TDT' 'S2_%SPT' 'S2_%TST' ...
                    'S3_min' 'S3_%TDT' 'S3_%SPT' 'S3_%TST' ...
                    'S4_min' 'S4_%TDT' 'S4_%SPT' 'S4_%TST' ...                    
                    'REM_min' 'REM_%TDT' 'REM_%SPT' 'REM_%TST' ...                    
                    'MT_min' 'MT_%TDT' 'MT_%SPT' 'MT_%TST' ...                    
                    'NREM_min' 'NREM_%TDT' 'NREM_%SPT' 'NREM_%TST' ...                                        
                    'SW_min' 'SW_%TDT' 'SW_%SPT' 'SW_%TST' ...                                        
                    'LO_SleepOn' 'LO_10minSl' 'LO_S1' 'LO_S2' 'LO_S3' 'LO_S4' 'LO_SW' ... % LATENCIES
                    'LO_REM' 'SO_S1' 'SO_S2' 'SO_S3' 'SO_S4' 'SO_SW' 'SO_REM'};
 
                    fid = fopen([outname,'.csv'], 'w') ;
                    fprintf(fid, '%s,', varNames{1,1:end-1}) ;
                    fprintf(fid, '%s\n', varNames{1,end}) ;
                    fprintf(fid, '%s,%s,%s,',id, cond, scorer);
                    fclose(fid) ;
                    dlmwrite([outname,'.csv'], data, '-append','delimiter',',') ;
end
                    fid = fopen([outname, '.html'], 'w');
                    fwrite(fid, report);
                    web([outname,'.html']);
end

%% helper functions

function [report, stageStats, breaks] = sleepSplit(report, stageStats, stages, stageMap, splitter, win)

q = round(length(stages)/splitter);

if ceil(splitter) == floor(splitter)
    splitterEnd = splitter;
else
    splitterEnd = splitter + 1;
end


for r = 1:splitterEnd
    
    if(r < splitterEnd)
        breaks(r, :) = [((r-1)*q + 1), min((r*q), length(stages))];
    else
        breaks(r, :) = [((r-1)*q + 1), length(stages)];
    end
end

[report, stageStats, dataOut] = makeSectionStats(report, stageStats, stages, stageMap, breaks, win);
report = [report, '</table>'];

if ceil(splitter)==floor(splitter)
    eval(['stageStats.split', num2str(splitter), '=dataOut;'])
else
    stageStats.splitHour=dataOut;
end

end

function [report, stageStats, dataOut] = makeSectionStats(report, stageStats, stages, stageMap, breaks, win)
dataOut = [];
report = [report, '<table cellpadding="5"><tr><td></td>'];
for r = 1:size(breaks, 1)
    report = [report, sprintf('<td><b>%d</b></td>', r)];
end
report = [report, '</tr>'];

for s = 0:6
    report = [report, '<tr>'];
    for r = 1:size(breaks, 1)
        if(r == 1)
            report = [report, sprintf('<td><b>%s:</b></td>', stageMap{s + 1})];
        end
        curData = find(stages(breaks(r, 1):breaks(r, 2)) == s);
        if(~isempty(curData))
            report = [report, sprintf('<td>%.2f</td>',((length(curData))*win)/60)];
        else
            report = [report, sprintf('<td>-</td>')];
        end
        dataOut(s + 1, r) = ((length(curData))*win)/60;
    end
    report = [report, sprintf('</tr>\n')];
end
for r = 1:size(breaks, 1)
    if(r == 1)
        report = [report, sprintf('<tr><td><b>%s:</b></td>', 'SW')];
    end
    curData = find(stages(breaks(r, 1):breaks(r, 2)) == 3 | stages(breaks(r, 1):breaks(r, 2)) == 4);
    if(~isempty(curData))
        report = [report, sprintf('<td>%.2f</td>',((length(curData))*win)/60)];
    else
        report = [report, sprintf('<td>-</td>')];
    end
    dataOut(s + 2, r) = ((length(curData))*win)/60;
end
report = [report, sprintf('</tr>\n')];

for r = 1:size(breaks, 1)
    if(r == 1)
        report = [report, sprintf('<tr><td><b>%s:</b></td>', 'Total Time')];
    end
    curData = stages(breaks(r, 1):breaks(r, 2));
    if(~isempty(curData))
        report = [report, sprintf('<td>%.2f</td>',((length(curData))*win)/60)];
    else
        report = [report, sprintf('<td>-</td>')];
    end
    dataOut(s + 3, r) = ((length(curData))*win)/60;
end

report = [report, '</tr></body>'];
end