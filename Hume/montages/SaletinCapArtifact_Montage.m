function CurrMontage = sleep_Montage(handles)
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
CurrMontage.hideChans = {};
if ~isempty(handles.EEG.etc.noiseDetection.interpolatedChannelNumbers)
    CurrMontage.hideChans = {handles.EEG.chanlocs(handles.EEG.etc.noiseDetection.interpolatedChannelNumbers).labels};
end
%electrode names that should be ploted.
CurrMontage.electrodes = flipud({'C3','O2','C4','O1','FP1','Fpz','FP2','AFz','F7','F3','FZ','F4','F8','T3','CZ','T4','CPz','T5','P3','PZ','P4','T6','POz','OZ','FCz'}');
% channels to plot negative up
CurrMontage.negChans = {'C3','O2','C4','O1','FP1','Fpz','FP2','AFz','F7','F3','FZ','F4','F8','T3','CZ','T4','CPz','T5','P3','PZ','P4','T6','POz','OZ','FCz'}';
% channels to plot as second-to-second numeric data (e.g., SpO2) data
CurrMontage.o2satChs = {};
%colors for each electrode. The order and length must match the electrode list
CurrMontage.colors = flipud(repmat({[1 0 0]}, 32, 1));
%scale for each electrode. The order and length must match the electrode list
CurrMontage.scale = flipud(repmat({'150'}, 32 ,1));
% channels to add scale lines to
CurrMontage.scaleChans = {};
% voltage to place scales
CurrMontageCurrMontage.bigGridMat{1,1} = 'C3';
CurrMontage.bigGridMat{1,2}{1,1} = '-75';
CurrMontage.bigGridMat{1,2}{1,2} = [0 5.000000e-01 0];
CurrMontage.bigGridMat{1,2}{2,1} = '-37.5';
CurrMontage.bigGridMat{1,2}{2,2} = [0 5.000000e-01 0];
CurrMontage.bigGridMat{1,2}{3,1} = '0';
CurrMontage.bigGridMat{1,2}{3,2} = [0 5.000000e-01 0];
CurrMontage.bigGridMat{1,2}{4,1} = '37.5';
CurrMontage.bigGridMat{1,2}{4,2} = [0 5.000000e-01 0];
CurrMontage.bigGridMat{1,2}{5,1} = '75';
CurrMontage.bigGridMat{1,2}{5,2} = [0 5.000000e-01 0];
CurrMontage.bigGridMat{2,1} = 'C4';
CurrMontage.bigGridMat{2,2}{1,1} = '-75';
CurrMontage.bigGridMat{2,2}{1,2} = [0 5.000000e-01 0];
CurrMontage.bigGridMat{2,2}{2,1} = '-37.5';
CurrMontage.bigGridMat{2,2}{2,2} = [0 5.000000e-01 0];
CurrMontage.bigGridMat{2,2}{3,1} = '0';
CurrMontage.bigGridMat{2,2}{3,2} = [0 5.000000e-01 0];
CurrMontage.bigGridMat{2,2}{4,1} = '37.5';
CurrMontage.bigGridMat{2,2}{4,2} = [0 5.000000e-01 0];
CurrMontage.bigGridMat{2,2}{5,1} = '75';
CurrMontage.bigGridMat{2,2}{5,2} = [0 5.000000e-01 0];