function [remStats, report] = getREMstats(stageData, stageStats, outname)
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
if(nargin < 3)
    outname = 'stageStats';
end

if(ischar(stageData))
    load(stageData);
end
if(ischar(stageStats))
    load(stageStats);
end
remStats = [];

if(~isfield(stageData, 'events'))
    display('NO EVENTS!!!')
    exit();
else
    if(~isfield(stageData.events, 'REM'))
        display('NO REMS!!!')
        exit();
    end
end

sleepInds = find(stageData.stages ~= 7);
sleepStages = stageData.stages(sleepInds);
REMepochs = stageData.events.REM(:, 2) - sleepInds(1) + 1;


%% whole night

remStats.total = size(stageData.events.REM, 1)/(sum(sleepStages == 5)/(60/stageData.win));

%% quarters

for q = 1:size(stageStats.quarterBounds, 1)
    curREMs = sum((REMepochs >= stageStats.quarterBounds(q, 1)) & (REMepochs <= stageStats.quarterBounds(q, 2)));
    curTime = sum(sleepStages(stageStats.quarterBounds(q, 1):stageStats.quarterBounds(q, 2)) == 5);
    remStats.quarters(q) = curREMs/(curTime/(60/stageData.win));
end

%% thirds

for t = 1:size(stageStats.thirdBounds, 1)
    curREMs = sum((REMepochs >= stageStats.thirdBounds(t, 1)) & (REMepochs <= stageStats.thirdBounds(t, 2)));
    curTime = sum(sleepStages(stageStats.thirdBounds(t, 1):stageStats.thirdBounds(t, 2)) == 5);
    remStats.thirds(t) = curREMs/(curTime/(60/stageData.win));
end

%% cycles

for c = 1:size(stageStats.cycleBounds, 1)
    if(stageStats.cycleBounds(c, 2) > 0)
        curREMs = sum((REMepochs >= stageStats.cycleBounds(c, 2)) & (REMepochs <= stageStats.cycleBounds(c, 3)));
        curTime = sum(sleepStages(stageStats.cycleBounds(c, 2):stageStats.cycleBounds(c, 3)) == 5);
        remStats.cycles(c) = curREMs/(curTime/(60/stageData.win));
    end
end

%% make plots

figure('Position', [560   800   180   140])
bar(remStats.cycles, 'k');
ylabel('REM density')
xlabel('REM cycle')
set(gcf, 'PaperPositionMode', 'auto');
saveas(gcf, [outname, '_remDensity.jpg'], 'jpg')
close(gcf);



%% make report

report = '<h1>REM Density Stats</h1><table cellpadding="10"><tr><td>';

rFields = fieldnames(remStats);
for f = 1:length(rFields)
    report = [report, sprintf('<h3>%s</h3><table cellpadding="5"><tr>', rFields{f})];
    cur = eval(['remStats.', rFields{f}]);
    for c = 1:length(cur)
        report = [report, sprintf('<td>%.3f</td>', cur(c))];
    end
    report = [report, '</tr></table>'];
end
report = [report, sprintf('</td><td><img src=''%s''></td></table>', [outname, '_remDensity.jpg'])]; 




