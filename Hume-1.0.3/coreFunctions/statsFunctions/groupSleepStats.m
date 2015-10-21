function [stageStatsGroup, stageStatsAll] = groupSleepStats(subjects, outname)
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

if(nargin < 2)
    outname = 'groupStats';
end

stageMap = {'Wake'; 'Stage 1'; 'Stage 2'; 'Stage 3'; 'Stage 4'; 'REM'; 'MT'; 'SW'; 'Total Time'; 'Segments'; 'Subjects'};

report = '<html>';

report = [report, sprintf('<h1>*** Group Sleep Stats %s***</h1><h2>Subjects: ', date)];

%% make average stageStats

stageStatsAll.CycleStats = zeros(9, 8, length(subjects))*NaN;
stageStatsAll.NREMperiodStats = zeros(10, 8, length(subjects))*NaN;
stageStatsAll.REMperiodStats = zeros(10, 8, length(subjects))*NaN;

for s = 1:size(subjects)
    report = [report, subjects{s}, ', '];
    load([subjects{s}, '_stats.mat'])
    
    stageStatsAll.lightsOUT(s) = datenum(stageStats.lightsOUT, 'HH:MM:SS.FFF');
    stageStatsAll.lightsON(s) = datenum(stageStats.lightsON, 'HH:MM:SS.FFF');
    
    stageStatsAll.lastStageSleep(s, :) = strcmp(stageMap, stageStats.lastStageSleep);
    
    stageStatsAll.awakeLightsOn(s) = strcmp(stageStats.awakeLightsOn, 'Yes');
    
    stageStatsAll.percentSleep(:, :, s) = stageStats.percentSleep;
    
    stageStatsAll.SleepLat(:, :, s) = stageStats.SleepLat;
    
    stageStatsAll.split4(:, :, s) = stageStats.split4;
    stageStatsAll.split3(:, :, s) = stageStats.split3;
    
    stageStatsAll.CycleStats(:, 1:size(stageStats.CycleStats, 2), s) = stageStats.CycleStats;
    stageStatsAll.NREMperiodStats(:, 1:size(stageStats.NREMperiodStats, 2), s) = stageStats.NREMperiodStats;
    stageStatsAll.REMperiodStats(:, 1:size(stageStats.REMperiodStats, 2), s) = stageStats.REMperiodStats;
    
    stageStatsAll.CycleSummary(s, :) = stageStats.CycleSummary;
    
    stageStatsAll.REMtoLsleep(s) = stageStats.REMtoLsleep;
    stageStatsAll.REMtoLon(s) = stageStats.REMtoLon;
    
    stageStatsAll.transTableAll(:, :, s) = stageStats.transTableAll;
    stageStatsAll.transTableCollapse(:, :, s) = stageStats.transTableCollapse;

end
report = [report, '</h2>'];


stageStatsGroup.N = length(subjects);
stageStatsGroup.lightsOUT.mean = mean(stageStatsAll.lightsOUT);
stageStatsGroup.lightsON.mean = mean(stageStatsAll.lightsON);

stageStatsGroup.lastStageSleep.counts = sum(stageStatsAll.lastStageSleep);

stageStatsGroup.awakeLightsOn.count = sum(stageStatsAll.awakeLightsOn);
stageStatsGroup.awakeLightsOn.percent = mean(stageStatsAll.awakeLightsOn);

stageStatsGroup.percentSleep.mean = mean(stageStatsAll.percentSleep, 3);
stageStatsGroup.percentSleep.std = std(stageStatsAll.percentSleep, [], 3);

stageStatsGroup.SleepLat.mean = mean(stageStatsAll.SleepLat, 3);
stageStatsGroup.SleepLat.median = median(stageStatsAll.SleepLat, 3);
stageStatsGroup.SleepLat.std = std(stageStatsAll.SleepLat, [], 3);

stageStatsGroup.split4.mean = mean(stageStatsAll.split4, 3);
stageStatsGroup.split4.std = std(stageStatsAll.split4, [], 3);
stageStatsGroup.split3.mean = mean(stageStatsAll.split3, 3);
stageStatsGroup.split3.std = std(stageStatsAll.split3, [], 3);

stageStatsGroup.CycleStats.mean = nanmean(stageStatsAll.CycleStats, 3);
stageStatsGroup.CycleStats.mean = stageStatsGroup.CycleStats.mean(:, ~isnan(stageStatsGroup.CycleStats.mean(1, :)));
stageStatsGroup.CycleStats.std = nanstd(stageStatsAll.CycleStats, [], 3);
stageStatsGroup.CycleStats.std = stageStatsGroup.CycleStats.std(:, ~isnan(stageStatsGroup.CycleStats.std(1, :)));
stageStatsGroup.CycleStats.n = sum(~isnan(stageStatsAll.CycleStats), 3);
stageStatsGroup.CycleStats.n = stageStatsGroup.CycleStats.n(:, (stageStatsGroup.CycleStats.n(1, :) > 0));

stageStatsGroup.NREMperiodStats.mean = nanmean(stageStatsAll.NREMperiodStats, 3);
stageStatsGroup.NREMperiodStats.mean = stageStatsGroup.NREMperiodStats.mean(:, ~isnan(stageStatsGroup.NREMperiodStats.mean(1, :)));
stageStatsGroup.NREMperiodStats.std = nanstd(stageStatsAll.NREMperiodStats, [], 3);
stageStatsGroup.NREMperiodStats.std = stageStatsGroup.NREMperiodStats.std(:, ~isnan(stageStatsGroup.NREMperiodStats.std(1, :)));
stageStatsGroup.NREMperiodStats.n = sum(~isnan(stageStatsAll.NREMperiodStats), 3);
stageStatsGroup.NREMperiodStats.n = stageStatsGroup.NREMperiodStats.n(:, (stageStatsGroup.NREMperiodStats.n(1, :) > 0));

stageStatsGroup.REMperiodStats.mean = nanmean(stageStatsAll.REMperiodStats, 3);
stageStatsGroup.REMperiodStats.mean = stageStatsGroup.REMperiodStats.mean(:, ~isnan(stageStatsGroup.REMperiodStats.mean(1, :)));
stageStatsGroup.REMperiodStats.std = nanstd(stageStatsAll.REMperiodStats, [], 3);
stageStatsGroup.REMperiodStats.std = stageStatsGroup.REMperiodStats.std(:, ~isnan(stageStatsGroup.REMperiodStats.std(1, :)));
stageStatsGroup.REMperiodStats.n = sum(~isnan(stageStatsAll.REMperiodStats), 3);
stageStatsGroup.NREMperiodStats.n = stageStatsGroup.NREMperiodStats.n(:, (stageStatsGroup.NREMperiodStats.n(1, :) > 0));

stageStatsGroup.CycleSummary.mean = mean(stageStatsAll.CycleSummary);

stageStatsGroup.REMtoLsleep.mean = mean(stageStatsAll.REMtoLsleep);
stageStatsGroup.REMtoLsleep.std = std(stageStatsAll.REMtoLsleep);

stageStatsGroup.REMtoLon.mean = mean(stageStatsAll.REMtoLon);
stageStatsGroup.REMtoLon.std = std(stageStatsAll.REMtoLon);

stageStatsGroup.transTableAll.mean = mean(stageStatsAll.transTableAll, 3);
stageStatsGroup.transTableAll.std = std(stageStatsAll.transTableAll, [], 3);

stageStatsGroup.transTableCollapse.mean = mean(stageStatsAll.transTableCollapse, 3);
stageStatsGroup.transTableCollapse.std = std(stageStatsAll.transTableCollapse, [], 3);



%%

report = [report, sprintf('<br><b>Mean Lights OUT: %s Range: (%s-%s)</b><br>\n', datestr(stageStatsGroup.lightsOUT.mean, 'HH:MM:SS'), datestr(min(stageStatsAll.lightsOUT), 'HH:MM:SS'), datestr(max(stageStatsAll.lightsOUT), 'HH:MM:SS'))];
report = [report, sprintf('<b>Mean Lights ON: %s Range: (%s-%s)</b><br>\n', datestr(stageStatsGroup.lightsON.mean, 'HH:MM:SS'), datestr(min(stageStatsAll.lightsON), 'HH:MM:SS'), datestr(max(stageStatsAll.lightsON), 'HH:MM:SS'))];

%% calc last stage

%report = [report, sprintf('<b>Last stage of sleep: %s</b><br>\n', stageMap{lastStage + 1})];


%% calc awake at lights on

report = [report, sprintf('<b>Percentage Awake at lights on: %.3f</b><br>\n', stageStatsGroup.awakeLightsOn.percent)];
%stageStats.awakeLightsOn = awakeP;
% 
%% Sleep percentages table %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

perMean = stageStatsGroup.percentSleep.mean;
perSTD = stageStatsGroup.percentSleep.std;

perMean(:, 3:5) = perMean(:, 3:5)*100;
perSTD(:, 3:5) = perSTD(:, 3:5)*100;

report = [report, '<td><h2>Sleep Percentages</h2></td>'];
report = [report, '<table><tr><td>'];
report = [report, sprintf('<table cellpadding="5">\n<tr><td></td><td>Epochs</td><td>Minutes</td><td>%%TDT</td><td>%%SPT</td><td>%%TST</td></tr>\n')];

c = 1;
report = [report, sprintf('<tr><td><b>Total dark time:</b></td><td>%.2f (%.1f)</td><td>%.2f (%.1f)</td></tr>\n', perMean(c, 1), perSTD(c, 1), perMean(c, 2), perSTD(c, 2))];
c = c + 1;
report = [report, sprintf('<tr><td><b>Sleep period time:</b></td><td>%.2f (%.1f)</td><td>%.2f (%.1f)</td><td>%.2f (%.1f)</td></tr>\n', perMean(c, 1), perSTD(c, 1), perMean(c, 2), perSTD(c, 2), perMean(c, 3), perSTD(c, 3))];
c = c + 1;
report = [report, sprintf('<tr><td><b>Total sleep time:</b></td><td>%.2f (%.1f)</td><td>%.2f (%.1f)</td><td>%.2f (%.1f)</td><td>%.2f (%.1f)</td></tr>\n', perMean(c, 1), perSTD(c, 1), perMean(c, 2), perSTD(c, 2), perMean(c, 3), perSTD(c, 3), perMean(c, 4), perSTD(c, 4))];
c = c + 1;
report = [report, sprintf('<tr><td><b>Sleep before sleep onset:</b></td><td>%.2f (%.1f)</td><td>%.2f (%.1f)</td><td>%.2f (%.1f)</td></tr>\n', perMean(c, 1), perSTD(c, 1), perMean(c, 2), perSTD(c, 2), perMean(c, 3), perSTD(c, 3))];
c = c + 1;
report = [report, sprintf('<tr><td><b>Wake after sleep onset:</b></td><td>%.2f (%.1f)</td><td>%.2f (%.1f)</td><td>%.2f (%.1f)</td><td>%.2f (%.1f)</td><td>%.2f (%.1f)</td></tr>\n', perMean(c, 1), perSTD(c, 1), perMean(c, 2), perSTD(c, 2), perMean(c, 3), perSTD(c, 3), perMean(c, 4), perSTD(c, 4), perMean(c, 5), perSTD(c, 5))];
c = c + 1;
report = [report, sprintf('<tr><td><b>Wake after final awakening:</b></td><td>%.2f (%.1f)</td><td>%.2f (%.1f)</td><td>%.2f (%.1f)</td><td>%.2f (%.1f)</td><td>%.2f (%.1f)</td></tr>\n', perMean(c, 1), perSTD(c, 1), perMean(c, 2), perSTD(c, 2), perMean(c, 3), perSTD(c, 3), perMean(c, 4), perSTD(c, 4), perMean(c, 5), perSTD(c, 5))];
c = c + 1;
%%% Total wake time
report = [report, sprintf('<tr><td><b>Total Wake Time:</b></td><td>%.2f (%.1f)</td><td>%.2f (%.1f)</td><td>%.2f (%.1f)</td><td>%.2f (%.1f)</td><td>%.2f (%.1f)</td></tr>\n', perMean(c, 1), perSTD(c, 1), perMean(c, 2), perSTD(c, 2), perMean(c, 3), perSTD(c, 3), perMean(c, 4), perSTD(c, 4), perMean(c, 5), perSTD(c, 5))];
c = c + 1;
%%%% Percentages for each stage of sleep
for s = 1:6
    report = [report, sprintf('<tr><td><b>%s</b></td><td>%.2f (%.1f)</td><td>%.2f (%.1f)</td><td>%.2f (%.1f)</td><td>%.2f (%.1f)</td><td>%.2f (%.1f)</td></tr>\n', stageMap{s + 1}, perMean(c, 1), perSTD(c, 1), perMean(c, 2), perSTD(c, 2), perMean(c, 3), perSTD(c, 3), perMean(c, 4), perSTD(c, 4), perMean(c, 5), perSTD(c, 5))];
    c = c + 1;
end

%%% NREM
report = [report, sprintf('<tr><td><b>NREM</b></td><td>%.2f (%.1f)</td><td>%.2f (%.1f)</td><td>%.2f (%.1f)</td><td>%.2f (%.1f)</td><td>%.2f (%.1f)</td></tr>\n', perMean(c, 1), perSTD(c, 1), perMean(c, 2), perSTD(c, 2), perMean(c, 3), perSTD(c, 3), perMean(c, 4), perSTD(c, 4), perMean(c, 5), perSTD(c, 5))];
c = c + 1;
%%% SW
report = [report, sprintf('<tr><td><b>SW</b></td><td>%.2f (%.1f)</td><td>%.2f (%.1f)</td><td>%.2f (%.1f)</td><td>%.2f (%.1f)</td><td>%.2f (%.1f)</td></tr>\n', perMean(c, 1), perSTD(c, 1), perMean(c, 2), perSTD(c, 2), perMean(c, 3), perSTD(c, 3), perMean(c, 4), perSTD(c, 4), perMean(c, 5), perSTD(c, 5))];

report = [report, '</table>'];

%% Sleep distributions chart

plotSleepDist(stageStatsGroup.percentSleep.mean, stageStatsGroup.percentSleep.std);
set(gcf, 'PaperPositionMode', 'auto');
saveas(gcf, [outname, '_SPdist.jpg'], 'jpg')
close(gcf);
report = [report, '</td><td>'];
report = [report, sprintf('<img src=''%s''>', [outname, '_SPdist.jpg'])]; 
report = [report, '</td></table>'];


%%   Latencies Table %%
%%%%%%%%%%%%%%%%%%%%%%%

report = [report, '<h2>Sleep Latencies (medians)</h2>'];
report = [report, '<table><tr><td>'];
report = [report, sprintf('<table cellpadding="5">\n<tr><td></td><td>Epochs</td><td>Minutes</td></tr>\n')];

sleepLatMean = stageStatsGroup.SleepLat.median;

c = 1;
report = [report, sprintf('<tr><td><b>lights out to %s</b></td><td>%.2f</td><td>%.2f</td></tr>\n', 'sleep onset', sleepLatMean(c, 1), sleepLatMean(c, 2))];
c = c + 1;
%%%% latencies form lights out for each
for s = 1:5
    report = [report, sprintf('<tr><td><b>lights out to %s</b></td><td>%.2f</td><td>%.2f</td></tr>\n', stageMap{s + 1}, sleepLatMean(c, 1), sleepLatMean(c, 2))];
    c = c + 1;
end

%%%% latencies from sleep onset for each
for s = 1:5
    report = [report, sprintf('<tr><td><b>Sleep onset to %s</b></td><td>%.2f</td><td>%.2f</td></tr>\n', stageMap{s + 1},sleepLatMean(c, 1), sleepLatMean(c, 2))];
    c = c + 1;
end
report = [report, '</table>'];
%% Sleep lat chart

plotSleepLat(sleepLatMean(7:11, 2));
set(gcf, 'PaperPositionMode', 'auto');

saveas(gcf, [outname, '_lats.jpg'], 'jpg')
close(gcf);
report = [report, '</td><td>'];
report = [report, sprintf('<img src=''%s''>', [outname, '_lats.jpg'])]; 
report = [report, '</td></table>'];

%% Sleep splits - Quarters and thirds

report = [report, '<br><table cellpadding="5"><tr>'];
report = [report, '<td><h2>Quarters (min)</h2></td>'];
report = [report, '<td><h2>Thirds (min)</h2></td></tr>'];

%%%%%%%%%%%%%  get Quarters
report = [report, '<tr><td>'];
quartMean = stageStatsGroup.split4.mean;
quartSTD = stageStatsGroup.split4.std;
report = [report, '<table cellpadding="5"><tr><td></td><td>1</td><td>2</td><td>3</td><td>4</td></tr>'];
for s = 1:9
    report = [report, sprintf('<tr><td><b>%s</b></td>', stageMap{s})];
    for q = 1:4
        if(quartMean(s, q) > 0)
            report = [report, sprintf('<td>%.2f (%.2f)</td>', quartMean(s, q), quartSTD(s, q))];
        else
            report = [report, '<td>-</td>'];
        end
    end
    report = [report, '</tr>'];
end
report = [report, '</table>'];

%%%%%%%%%%%%%  get Thirds
report = [report, '</td><td>'];
thirdMean = stageStatsGroup.split3.mean;
thirdSTD = stageStatsGroup.split3.std;
report = [report, '<table cellpadding="5"><tr><td></td><td>1</td><td>2</td><td>3</td></tr>'];
for s = 1:9
    report = [report, sprintf('<tr><td><b>%s</b></td>', stageMap{s})];
    for q = 1:3
        if(quartMean(s, q) > 0)
            report = [report, sprintf('<td>%.2f (%.2f)</td>', thirdMean(s, q), thirdSTD(s, q))];
        else
            report = [report, '<td>-</td>'];
        end
    end
    report = [report, '</tr>'];
end
report = [report, '</table></tr></table>'];

%% quarter plots
curMean = stageStatsGroup.split4.mean;
curSTD = stageStatsGroup.split4.std;

figure('Position', [440, 600, 150*size(curMean, 2), 200])
for c = 1:size(curMean, 2)
    subplot(1, size(curMean, 2), c)
    m = [curMean(1:7, c); curMean(3, c) + curMean(4, c) + curMean(5, c); curMean(8, c)]./curMean(9, c);
    st = [curSTD(1:7, c); curSTD(3, c) + curSTD(4, c) + curSTD(5, c); curSTD(8, c)]./curMean(9, c);
    plotSleepDist(m, st, 0);
    title(['Quarter ', num2str(c)])
end

set(gcf, 'PaperPositionMode', 'auto');
saveas(gcf, [outname, '_quarterSPdist.jpg'], 'jpg')
%close(gcf);

report = [report, sprintf('<img src=''%s''>', [outname, '_quarterSPdist.jpg'])]; 

%% Cycle stats
report = [report, '<br><table cellpadding="5"><tr>'];
report = [report, '<td><h2>NREM-REM Cycle (min)</h2></td>'];
report = [report, '<td><h2>NREM Period (min)</h2></td>'];
report = [report, '<td><h2>REM Period (min)</h2></td></tr>'];

%%%%%%%%%%%%%  NREM-REMcycle
report = [report, '<tr><td>'];
curMean = stageStatsGroup.CycleStats.mean;
curSTD = stageStatsGroup.CycleStats.std;
curN = stageStatsGroup.CycleStats.n;
report = [report, '<table cellpadding="5">'];
for s = 1:12
    if(s > 1)
        report = [report, sprintf('<tr><td><b>%s:</b></td>', stageMap{s - 1})];
    else
        report = [report, '<tr><td></td>'];
    end
    for c = 1:size(curMean, 2)
        if(s == 1)
           report = [report, sprintf('<td><b>%d</b></td>', c)];
        elseif(s == 11)
           report = [report, '<td>-</td>'];
        elseif(s == 12)
           report = [report, sprintf('<td>%d</td>', curN(1, c))];
        else
            if(curMean(s - 1, c) > 0)
                report = [report, sprintf('<td>%.2f (%.2f)</td>', curMean(s - 1, c), curSTD(s - 1, c))];
            else
                report = [report, '<td>-</td>'];
            end
        end
    end
    report = [report, '</tr>'];
end
report = [report, '</table>'];

%%%%%%%%%%%%%  NREM stats
report = [report, '</td><td>'];
curMean = stageStatsGroup.NREMperiodStats.mean;
curSTD = stageStatsGroup.NREMperiodStats.std;
curN = stageStatsGroup.NREMperiodStats.n;
report = [report, '<table cellpadding="5">'];
for s = 1:12
    if(s > 1)
        report = [report, sprintf('<tr><td><b>%s:</b></td>', stageMap{s - 1})];
    else
        report = [report, '<tr><td></td>'];
    end
    for c = 1:size(curMean, 2)
        if(s == 1)
           report = [report, sprintf('<td><b>%d</b></td>', c)];
        elseif(s == 12)
           report = [report, sprintf('<td>%d</td>', curN(1, c))];
        else
            if(curMean(s - 1, c) > 0)
                report = [report, sprintf('<td>%.2f (%.2f)</td>', curMean(s - 1, c), curSTD(s - 1, c))];
            else
                report = [report, '<td>-</td>'];
            end
        end
    end
    report = [report, '</tr>'];
end
report = [report, '</table>'];

%%%%%%%%%%%%%  REM stats
report = [report, '</td><td>'];
curMean = stageStatsGroup.REMperiodStats.mean;
curSTD = stageStatsGroup.REMperiodStats.std;
curN = stageStatsGroup.REMperiodStats.n;
report = [report, '<table cellpadding="5">'];
for s = 1:12
    if(s > 1)
        report = [report, sprintf('<tr><td><b>%s:</b></td>', stageMap{s - 1})];
    else
        report = [report, '<tr><td></td>'];
    end
    for c = 1:size(curMean, 2)
        if(s == 1)
           report = [report, sprintf('<td><b>%d</b></td>', c)];
        elseif(s == 12)
           report = [report, sprintf('<td>%d</td>', curN(1, c))];
        else
            if(curMean(s - 1, c) > 0)
                report = [report, sprintf('<td>%.2f (%.2f)</td>', curMean(s - 1, c), curSTD(s - 1, c))];
            else
                report = [report, '<td>-</td>'];
            end
        end
    end
    report = [report, '</tr>'];
end

report = [report, '</table></td></tr></table>'];

%% cycle plots
curMean = stageStatsGroup.CycleStats.mean;
curSTD = stageStatsGroup.CycleStats.std;

figure('Position', [440, 600, 150*size(curMean, 2), 200])
for c = 1:size(curMean, 2)
    subplot(1, size(curMean, 2), c)
    m = [curMean(1:7, c); curMean(3, c) + curMean(4, c) + curMean(5, c); curMean(8, c)]./curMean(9, c);
    st = [curSTD(1:7, c); curSTD(3, c) + curSTD(4, c) + curSTD(5, c); curSTD(8, c)]./curMean(9, c);
    plotSleepDist(m, st, 0);
    title(['Cycle ', num2str(c)])
end

set(gcf, 'PaperPositionMode', 'auto');
saveas(gcf, [outname, '_cycleSPdist.jpg'], 'jpg')
%close(gcf);

report = [report, sprintf('<img src=''%s''>', [outname, '_cycleSPdist.jpg'])]; 


%% REM summary

report = [report, sprintf('<br><b>Last REM to final awakening: %.2f (%.2f)</b><br>\n', stageStatsGroup.REMtoLsleep.mean, stageStatsGroup.REMtoLsleep.std)];
report = [report, sprintf('<b>Last REM to lights on: %.2f (%.2f)</b><br>\n', stageStatsGroup.REMtoLon.mean, stageStatsGroup.REMtoLon.std)];


%% Transition table

transTableAllStr = '<table cellpadding="5"><tr><td>From\To</td><td><b>Wake</b></td><td><b>Stage 1</b></td><td><b><b>Stage 2</b></td><td><b>Stage 3</b></td><td><b>Stage 4</b></td><td><b>REM</b></td><td><b>MT</b></td></tr>';

for t = 1:7
    transTableAllStr = [transTableAllStr, '<tr><td><b>', stageMap{t}, ':</b></td>'];
    for t2 = 1:7
        if(t == t2)
            transTableAllStr = [transTableAllStr, '<td><b>', num2str(stageStatsGroup.transTableAll.mean(t, t2)), '</b></td>'];
        else
            transTableAllStr = [transTableAllStr, '<td>', num2str(stageStatsGroup.transTableAll.mean(t, t2)), '</td>'];
        end
    end
    transTableAllStr = [transTableAllStr, '</tr>'];
end
transTableAllStr = [transTableAllStr, '</table>'];



%% write output

%writeStruct(stageStats, [outname, '_stats.csv'])
save([outname, '_GroupStats.mat'], 'stageStatsGroup')
save([outname, '_AllStats.mat'], 'stageStatsAll')

% plotHypnogram(stageData, stageStats.cycleBounds);
% set(gcf, 'PaperPositionMode', 'auto');
% saveas(gcf, [outname, '_hyp1.jpg'], 'jpg')
% close(gcf);
% report = [report, sprintf('<h3>Full Hypnogram:</h3><img src=''%s''>', [outname, '_hyp1.jpg'])]; 
report = [report, '<h3>Full Transition Table:</h3>', transTableAllStr];
% 
% stageDataSW = stageData;
% stageDataSW.stages(stageDataSW.stages == 4) = 3;
% plotHypnogram(stageDataSW, stageStats.cycleBounds);
% set(gcf, 'PaperPositionMode', 'auto');
% saveas(gcf, [outname, '_hyp2.jpg'], 'jpg')
% close(gcf);
% report = [report, sprintf('<h3>SW Collapsed Hypnogram:</h3><img src=''%s''>', [outname, '_hyp2.jpg'])]; 
% report = [report, '<h3>SW Collapsed Transition Table:</h3>', transTableCollapseStr];
% 
% %% report definitions
% 
% report = [report, '<br><br><br><b>Sleep Statistics Definitions and Explanations:</b><p>', ...
% '<b>SPT:</b> sleep period time (elapsed time from sleep onset through last epoch of sleep).<br>', ...
% '<b>TDT:</b> Total dark time (elapsed time from lights out to lights on).<br>', ...
% '<b>TST:</b> Total sleep time (duration of time spent in Stages 1, 2, 3, 4 and REM during SPT).<br>', ...
% '<b>NREM:</b> Duration of time in Stages 1, 2, 3, 4.<br> ', ...
% '<b>SW:</b> Slow wave sleep (Stages 3, 4). <br>', ...
% '<b>All sleep tabulated from within SPT.</b><br> '];
% report = [report,sprintf('<b>Sleep Onset:</b> %s<br>\n',latDef)];
% report = [report, '<b>Wake After Sleep Onset:</b> Wake time after sleep onset during SPT.<br> ', ...
% '<b>Wake After Final Awakening:</b> Elapsed time spent awake between the final epoch of sleep and lights on. <br>', ...
% '<b>Sleep Before Sleep Onset:</b> Any transient sleep occurring between lights off and sleep onset.<br> ', ...
% '<b>All Stage Latencies:</b> Elapsed time to first epoch of specified stage (from either lights off or sleep onset, as specified).<br>', ...
% '<b>Quarters and Thirds:</b> Calculated from SPT. <br><br>', ...
% '<b>NREM-REM Cycle definitions per the modified criterion of Feinberg and Flyod (1979) as in Aeschbach and Borb&eacute;ly (1993).</b><br><br>', ...
% '<b>NREM-REM Cycle:</b> Succession of NREM period of at least 15 minutes duration by a REM period of at least 5 minutes duration.<br>', ...
% '<b>No minimum duration for the first or last REM period.</b><br>', ...
% '<b>NREM Period:</b> Time interval between first occurance of Stage 2 and the first epoch of the next REM period.<br>', ...
% '<b>REM Period:</b> Time interval between two consecutive NREM periods  or the between the last NREM period and final awakening.<br>', ...
% '<b>NREM/REM Segments:</b> Number of uninterrupted periods of NREM/REM during a NREM/REM period.<br><br>',...
% '<b>All other sleep statistics per: <br><br>',...
% 'Carskadon, MA, Rechtschaffen, A. Monitoring and Staging Human Sleep. In: Principles and Practices of Sleep Medicine 4th Edition, pgs. 1359-1377. Ed: Kryger, MH, Roth, T, Dement, WC.  Philadelphia, PA : Elsevier Saunders, 2005.<br><br>',...
% '</p>'];
% 
% 

report = [report, '<table>'];


for s = 1:length(subjects)
   report = [report, '<tr><td><h2>', subjects{s}, '</h2></td><td><img src="', subjects{s}, '_hyp1.jpg" width=700></td><td><img src="', subjects{s}, '_SPdist.jpg" width = 200></td></tr>'];
end

report = [report, '</table>'];

fid = fopen([outname, '.html'], 'w');
fwrite(fid, report);



