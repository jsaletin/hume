function [cycleBounds, NREMsegments, REMsegments] = getNREMcyc_splitJenni(sleep, win, REMcombTime, REMmin, startStage, nonSWmin)
% NREM/REM Cycles using definitions of Jenni, et al., 2004
% Applies a splitting rule to the first NREM cycle in the case of a skipped
% REM Period

% Inputs:
% sleep = sleep data starting with the onset of sleep and ending with the
% epoch before the final awakening (i.e. SPT)
% win = the number of seconds in an epoch
%
% Outputs:
% cycleBounds = an nX3 matrix with n bing the number os cycles.  the first
% entry in a row is the start of the NREM cycle the second is the start of
% the REM period and the last is the end of the cycle.
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

%% parameters

if nargin < 3
    REMcombTime = 15;
    REMmin = 5; %this minimum does not apply to the first of last REM period
    startStage = 2; %start with stage 2 or greater (as long as it's not REM)
    nonSWmin = 12;
end


%% get cycles
REMsegments = [];
sleepSt = find((sleep >= startStage) & (sleep < 5));
startCyc = sleepSt(1);

c = 1;
while(startCyc <= length(sleep))
    if(c == 1)
        %no minimum REM length for the first cycle
        [stREM, endCyc] = getStartEndJenni(sleep(startCyc:end), win, 0, REMcombTime, startStage, nonSWmin);
    else
        [stREM, endCyc] = getStartEnd(sleep(startCyc:end), win, REMmin, REMcombTime, startStage);
    end
    cycleBounds(c, 1) = startCyc;
    if(stREM > 0)
        cycleBounds(c, 2) = stREM + startCyc - 1;
    end
    
    
    cycleBounds(c, 3) = endCyc + startCyc - 1;
    
    if((endCyc+startCyc) == length(sleep))
        cycleBounds(c, 3) = endCyc + startCyc;
    end
    
    
    if(cycleBounds(c, 2) == 0)
        NREMsegments{c} = getNREMsegments(sleep(cycleBounds(c, 1):cycleBounds(c, 3))) + cycleBounds(c, 1) - 1;
    else
        REMsegments{c} = getREMsegments(sleep(cycleBounds(c, 2):cycleBounds(c, 3))) + cycleBounds(c, 2) - 1;
        NREMsegments{c} = getNREMsegments(sleep(cycleBounds(c, 1):cycleBounds(c, 2))) + cycleBounds(c, 1) - 1;
    end
    
    startCyc = endCyc + startCyc;
    c = c + 1;
end

% Bugfix 2/6/17 -- when only one cycle...(per email between JMS and BAM).
if size(cycleBounds,1) > 1
    
    if cycleBounds(size(cycleBounds,1),3) == cycleBounds(size(cycleBounds,1)-1,3)
        
        cycleBounds(size(cycleBounds,1)-1,3) = cycleBounds(size(cycleBounds,1)-1,3) - 1;
    end
end



%% helper functinos

function [stREM, endCyc] = getStartEnd(sleep, win, REMmin, REMcombTime, startStage)

i = 0;
c = 0;
lastREM = length(sleep);
stREM = 0;
REMtime = 0;
hitREM = false;

while(i < length(sleep) && c < (REMcombTime*(60/win)))
    i = i + 1;
    if(sleep(i) == 5)
        if(~hitREM)
            %this is the index of the first REM
            stREM = i;
        end
        hitREM = true;
        REMtime = REMtime + 1;
        lastREM = i;
        c = 0;
    elseif(hitREM)
        c = c + 1;
    end
    
    if(REMmin >0)
        
        %checks to make sure the REM period is greater than 5 minutes
        if((c == REMcombTime*(60/win)) && REMtime < REMmin*(60/win))
            c = 0;
            hitREM = false;
            REMtime = 0;
            stREM = 0;
            lastREM = length(sleep);
        end
        
    end
end

findSt = find((sleep(lastREM:end) >= startStage) & (sleep(lastREM:end) ~= 5));

% Jared EDITS = only include non-rem in final rem in the context of
% minumum REM lengths.

if(and(REMmin>0,isempty(findSt) || (length(sleep(lastREM:end)) < REMcombTime*(60/win))))
    endCyc = length(sleep);
elseif (length(sleep(lastREM:end)) < REMcombTime*(60/win))
    endCyc = lastREM;
else
    endCyc = lastREM + findSt(1) - 2;
end


function [stREM, endCyc] = getStartEndJenni(sleep, win, REMmin, REMcombTime, startStage, nonSWmin)

i = 0;
c = 0;
lastREM = length(sleep);
stREM = 0;
REMtime = 0;
hitREM = false;

lastSW = nan;
while(i < length(sleep) && c < (REMcombTime*(60/win)))
    i = i + 1;
    if(sleep(i) == 5)
        if(~hitREM)
            %this is the index of the first REM
            stREM = i;
        end
        hitREM = true;
        REMtime = REMtime + 1;
        lastREM = i;
        c = 0;
    elseif(hitREM)
        c = c + 1;
    end
    
    if(REMmin >0)
        
        %checks to make sure the REM period is greater than 5 minutes
        if((c == REMcombTime*(60/win)) && REMtime < REMmin*(60/win))
            c = 0;
            hitREM = false;
            REMtime = 0;
            stREM = 0;
            lastREM = length(sleep);
        end
        
    end
end

findSt = find((sleep(lastREM:end) >= startStage) & (sleep(lastREM:end) ~= 5));

% Jared EDITS = only include non-rem in final rem in the context of
% minumum REM lengths.

if(and(REMmin>0,isempty(findSt) || (length(sleep(lastREM:end)) < REMcombTime*(60/win))))
    endCyc = length(sleep);
elseif (length(sleep(lastREM:end)) < REMcombTime*(60/win))
    endCyc = lastREM;
else
    endCyc = lastREM + findSt(1) - 2;
end

% Check for split
for i = 1:endCyc
    
    if(sleep(i) == 3 || sleep(i) == 4) %SW
        
        if (i-lastSW) >= nonSWmin*(60/win)
            endCyc = i-1;
            stREM = 0;
            break;
        end
        lastSW = i;        
    end
    
end



%     if(~isnan(endCycNREM))
%         if(endCyc*win >= maxCyc*60)
%             endCyc = endCycNREM;
%             stREM = 0;
%         end
%     end



function segments = getREMsegments(curCycle)
allRem = find(curCycle == 5);

if(isempty(allRem))
    segments = [];
elseif(length(allRem) == 1)
    segments(1, 1) = allRem(1);
    segments(1, 2) = allRem(1);
else
    segments(1, 1) = allRem(1);
    c = 1;
    for i = 2:length(allRem)
        if(abs(allRem(i) - allRem(i - 1)) > 1)
            segments(c, 2) = allRem(i - 1);
            c = c + 1;
            segments(c, 1) = allRem(i);
        end
    end
    segments(c, 2) = allRem(end);
end

function segments = getNREMsegments(curCycle)
allNRem = find(curCycle ~= 5);

if(isempty(allNRem))
    segments = [];
elseif(length(allNRem) == 1)
    segments(1, 1) = allNRem(1);
    segments(1, 2) = allNRem(1);
else
    segments(1, 1) = allNRem(1);
    c = 1;
    for i = 2:length(allNRem)
        if(abs(allNRem(i) - allNRem(i - 1)) > 1)
            segments(c, 2) = allNRem(i - 1);
            c = c + 1;
            segments(c, 1) = allNRem(i);
        end
    end
    segments(c, 2) = allNRem(end);
end

