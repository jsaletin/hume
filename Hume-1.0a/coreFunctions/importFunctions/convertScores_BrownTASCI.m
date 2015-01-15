function [scorer id cond outname outfile stageData] = convertScores_BrownTASCI(file,srate)
% [scorer id cond outname outfile stageData] = convertScores_BrownTASCI(file,srate)
%  
%   Function to convert sleep stage data from VITASCORE TASCI to a stageData
%   struct for Húmë processing (e.g. a plotSleepStats call)
%
%   Inputs (Required)
%
%       file (string)   ?  Name of TASCI file
%
%   Inputs (Optional)
%
%       srate ? Sampling rate of the scored data (default: 200 Hz)
%
%   Outputs:
%
%       scorer, id, cond, outname, outfile ? meta-information for saving
%       data.
%
%       stageData ? converted stageData .mat file for Húmë processing
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

%% Check inputs

if nargin == 2
    
    savename = file(1:end-6);
    
elseif nargin==1
    
    srate = 200;

elseif nargin==0
    
    stageData={'Brown *.TASCI','.TASCI','convertScores_BrownTASCI'};
    
    scorer=[];
    id = [];
    cond = [];
    outname = [];
    outfile = [];
    
    return
end

%% META DATA
[path, fileName, fileExt] = fileparts(file);

mkdir([path,'/',fileName]);

if isletter(fileName(3))
        
        scorer = fileName(1:3);
        trimmedName = fileName(4:end);
    else
        scorer = fileName(1:2);
        trimmedName = fileName(3:end);
        
    
end
    
id = trimmedName(1:min(find(isletter(trimmedName)))-2);
cond = trimmedName(min(find(isletter(trimmedName))):end);
    
outname = [path,'/',fileName,'/',fileName];
outfile = fileName;

savename = [outname,'_scores'];

%% PARSE 11 LINE HEADER

fid = fopen(file);
header = textscan(fid,'%s\t%s\t%s\t%s',11,'delimiter','|');

scoringFile = file;
EDFName = header{1,2}{2,1};
recDate = header{1,2}{3,1};
recStart = header{1,2}{4,1};

win = str2num(header{1,4}{11,1});

head = [char(header{1})  char(header{2}) char(header{3}) char(header{4})];
stageData.Notes = head;

%% READ STAGE DATA

data = textscan(fid,'%d\t%d\t%d\t%d\t%s\t%s\t%s\t%s','Delimiter','|','headerlines',6);

%% FIX NEW TASCIS

if strcmp(data{1,7}{2},'')
    stageString = data{1,7}(1:2:end);
    times = data{1,5}(1:2:end);
    eventMarks = data{1,6}(1:2:end);
else
    stageString = data{1,7};
    times = data{1,5};
    eventMarks = data{1,6};
end
    
%% SetUp Events

stageData=eventSetup(stageData,length(stageString));
LUT = eventLUT;
lightsOffFound = 0;
lightsOnFound = 0;

for i = 1:length(eventMarks)
    
    LOffEv =[];
    LOnEv = [];
    BkmkEv = [];
    %Check if empty
    if ~isempty(eventMarks{i})
        
        separated = strsplit(eventMarks{i},', ');

        % FIND LIGHTS OFF
        if sum(ismember(separated,'Lights Off'))>0;
            if lightsOffFound==1
                 warning('Found Duplicate Lights Off. Last is used, Check Scored File to Confirm');
            end
            
           LOffEv = find(ismember(separated,'Lights Off')); 
           lightsOffFound = 1;
            epLightsOff = i;
           
         % FIND LIGHTS ON   
         elseif sum(ismember(separated,'Lights On'))>0;
           if lightsOnFound==1
                 warning('Found Duplicate Lights On. Last Is Used, Check Scored File to Confirm');
           end
            
            LOnEv = find(ismember(separated,'Lights On')); 
            lightsOnFound = 1;
            epLightsOn = i;
            
        end
        
        % FIND OTHER EVENTS
        
        for ev = 1:size(LUT,1);
            if sum(ismember(separated,LUT{ev,1}))>=1
                stageData.eventMat(i,ev)=sum(ismember(separated,LUT{ev,1}));
            end
        end
    end
end


%% SetUp Stage Data

stages = NaN(length(stageString),1);

% Set Stages from Staged Array

for Ep = 1:length(stages)
    
    Str = stageString{Ep};
    
    switch Str
        case 'Undefined'
            stages(Ep)=7;
        case 'Awake'
            stages(Ep)=0;
        case 'Wake'
            stages(Ep)=0;
        case '1'
            stages(Ep)=1;
        case 'N1'
            stages(Ep)=1;
        case '2'
            stages(Ep)=2;
        case 'N2'
            stages(Ep)=2;
        case '3'
            stages(Ep)=3;
        case 'N3'
            stages(Ep)=3;
        case '4' 
            stages(Ep)=4;
        case 'REM'
            stages(Ep)=5;
        case 'MVT'
            stages(Ep)=6;
    end         
end

stageData.stages = stages;

stageData.win = win; % PULL FROM HEADER

stageData.recStart = datenum(recStart,'HH:MM:SS'); % PULL FROM HEADER


%epLightsOff = find(ismember(eventMarks, 'Lights Off')==1);
stageData.lightsOFF = datenum(times(epLightsOff),'HH:MM:SS');
%epLightsOn = find(ismember(eventMarks, 'Lights On')==1);
stageData.lightsON = datenum(times(epLightsOn),'HH:MM:SS');

%Add a day to the time if it looks like lights on happened before the
%record start.
if(~(stageData.recStart < stageData.lightsON))
    stageData.lightsON = stageData.lightsON + 1;
end
%Add a day to the time if it looks like lights off happened before the
%record start.
if(~(stageData.recStart < stageData.lightsOFF))
    stageData.lightsOFF = stageData.lightsOFF + 1;
end

stageData.srate = srate;

stageData.stageTime = (0:(size(stageData.stages, 1) - 1))./(60/stageData.win);

% stageData.onsets

scoredEps = find(stageData.stages ~=7); 
firstScoredEp = scoredEps(1);
lastScoredEp = scoredEps(end);

stageData.onsets = zeros(length(stageData.stages), 1);

for i = firstScoredEp:lastScoredEp
    
    stageData.onsets(i) = ((i-1)*stageData.win*stageData.srate)+1;

end

%% Save

save(savename,'stageData');

end


% %get only the data that is scored
% 
% for i = 1:6
%     inds = find(stages(:, 1) == i);
%     totalTime(i) = sum((onsets(inds)/stageData.srate + stageData.win));
% end
% 
% perTime = totalTime(1:5)./sum(totalTime(1:5));
% 
% figure;
% 
% subplot(1, 2, 1)
% bar(totalTime/60)
% title('Total Time')
% set(gca, 'XTick', 1:6, 'XTickLabel', {'1'; '2'; '3'; '4'; 'REM'; 'Wake'})
% ylabel('Minutes')
% xlim([.5, 6.5])
% 
% subplot(1, 2, 2)
% bar(perTime)
% title('Percentage of Sleep')
% set(gca, 'XTick', 1:5, 'XTickLabel', {'1'; '2'; '3'; '4'; 'REM'})
% ylabel('% of sleep')
% xlim([.5, 5.5])