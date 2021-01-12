function CurrMontage = sleep_Montage(handles)
%%    Auto-generated Húmë Scoring Montage
%  Montage Generated from File: Test 4 EDF.edf
%  Montage Generated on Date: 01-Dec-2020

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
% channels to plot negative up
CurrMontage.negChans = {'C3-M2';'O1-M2';'E2-M2';'E1-M2';'EMG_L';'EMG_R';'F3-M2';'F4-M1';};
%electrode names that should be plotted.
CurrMontage.electrodes = flipud({'C3-M2';'O1-M2';'E2-M2';'E1-M2';'EMG_L';'EMG_R';'F3-M2';'F4-M1';});
%colors for each electrode. The order and length must match the electrode list
CurrMontage.colors = flipud({[1  0  0];[1  0  0];[1  0  0];[1  0  0];[1  0  0];[1  0  0];[1  0  0];[1  0  0];});
%scale for each electrode. The order and length must match the electrode list
CurrMontage.scale = flipud({'.15';'.15';'.15';'.15';'.15';'.15';'.15';'.15';});
% channels to add scale lines to
CurrMontage.scaleChans = {'C3-M2' };
% channels to plot as second-to-second numeric data (e.g., SpO2) data
CurrMontage.o2satChs = {};
% voltage to place scales
CurrMontage.bigGridMat{1,1} = 'C3-M2';
CurrMontage.bigGridMat{1,2}{1,1} = '-.075';
CurrMontage.bigGridMat{1,2}{1,2} = [0 5.000000e-01 0];
CurrMontage.bigGridMat{1,2}{2,1} = '-.0375';
CurrMontage.bigGridMat{1,2}{2,2} = [0 5.000000e-01 0];
CurrMontage.bigGridMat{1,2}{3,1} = '0';
CurrMontage.bigGridMat{1,2}{3,2} = [0 5.000000e-01 0];
CurrMontage.bigGridMat{1,2}{4,1} = '.0375';
CurrMontage.bigGridMat{1,2}{4,2} = [0 5.000000e-01 0];
CurrMontage.bigGridMat{1,2}{5,1} = '.075';
CurrMontage.bigGridMat{1,2}{5,2} = [0 5.000000e-01 0];
