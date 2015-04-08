function [sleepLat latDef] = calcSleepLat(stages)
%
% Calculates sleep latencey as the first epoch of sleep.
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
sleep = find((stages > 0) & (stages < 6));

foundOnset = 0;
sleepLat = sleep(1);
count = 1;
epCount = 1;
while(~foundOnset && count < length(sleep))
    count = count + 1;
    if((sleep(count) - sleep(count - 1)) == 1)
        epCount = epCount + 1;
    else
        sleepLat = sleep(count);
        epCount = 1;
    end
    if(epCount == 1)
        foundOnset = 1;
    end
end

latDef = 'The time from the epoch of lights out until the first epoch of sleep.';
