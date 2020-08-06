function handles = sleep_Montage(handles)
%%    Auto-generated Húmë Scoring Montage
%  Montage Generated from File: 217001_Spindles.edf
%  Montage Generated on Date: 01-Jul-2019

%%    Copyright (c) 2015 Jared M. Saletin, PhD and Stephanie M. Greer, PhD
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
%   Húmë is intended for research purposes only. Any commerical or medical
%   use of this software is prohibited. The authors accept no
%   responsibility for its use in this manner.
%%
% channels to hide
handles.hideChans = {};
%electrode names that should be ploted.
handles.electrodes = flipud({'FZ';'CZ';'PZ';});
% channels to plot negative up
handles.negChans = {'FZ';'CZ';'PZ';};
% channels to plot as second-to-second numeric data (e.g., SpO2) data
handles.o2satChs = {};
%colors for each electrode. The order and length must match the electrode list
handles.colors = flipud({[1  0  0];[1  0  0];[1  0  0];});
%scale for each electrode. The order and length must match the electrode list
handles.scale = flipud({'150';'150';'150';});
% channels to add scale lines to
handles.scaleChans = {};
% voltage to place scales
handles.bigGridMat{1,1} = 'PZ';
handles.bigGridMat{1,2}{1,1} = '-75';
handles.bigGridMat{1,2}{1,2} = [0 5.000000e-01 0];
handles.bigGridMat{1,2}{2,1} = '-37.5';
handles.bigGridMat{1,2}{2,2} = [0 5.000000e-01 0];
handles.bigGridMat{1,2}{3,1} = '0';
handles.bigGridMat{1,2}{3,2} = [0 5.000000e-01 0];
handles.bigGridMat{1,2}{4,1} = '37.5';
handles.bigGridMat{1,2}{4,2} = [0 5.000000e-01 0];
handles.bigGridMat{1,2}{5,1} = '75';
handles.bigGridMat{1,2}{5,2} = [0 5.000000e-01 0];
