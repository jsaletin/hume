function handles = sleep_Montage(handles)
%%    Auto-generated Húmë Scoring Montage
%  Montage Generated from File: ADMDUN1A.edf
%  Montage Generated on Date: 15-Jan-2015

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
handles.electrodes = flipud({'C3','O2','ROC','LOC','C4','O1','EMG 1-EMG 2','EMG 2-EMG 3','EMG 1-EMG 3','FP1','Fpz','FP2','AFz','F7','F3','FZ','F4','F8','T3','CZ','T4','CPz','T5','P3','PZ','P4','T6','POz','OZ','A1','A2','FCz'}');
%colors for each electrode. The order and length must match the electrode list
handles.colors = flipud(repmat({[1 0 0]}, 32, 1));
%scale for each electrode. The order and length must match the electrode list
handles.scale = flipud(repmat({'150'}, 32 ,1));

