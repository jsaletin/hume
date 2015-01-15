function plotSleepLat(sleepLat)
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

figure('Position', [475   800   350   150]);

barh(repmat(sleepLat', 2, 1));

stageColors = [102 255 255; 0 158 225; 102 102 255; 128 0 255; 255 0 0]./255;
colormap(stageColors)

ylim([.5, 1.5])
xlim([0, 120])

xlabel('Minutes')
set(gca, 'YTick', .65:.15:1.25, 'YTickLabel', {'1'; '2'; '3'; '4'; 'REM'})



