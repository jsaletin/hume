function CurrMontage = sleep_Montage(handles)
%%    Auto-generated Húmë Scoring Montage
%  Montage Generated from File: 0
%  Montage Generated on Date: 12-Jan-2021

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
%electrode names that should be ploted.
CurrMontage.electrodes = flipud({'C3-M2';'O2-M1';'E2-M2';'E1-M2';'EMG_L';'EMG_R';'C4-M1';'O1-M2';'ECG';'Pres';'Flow';'Thor';'Abdo';'SpO2';});
%colors for each electrode. The order and length must match the electrode list
CurrMontage.colors = flipud({[1  0  0];[1  0  0];[1  0  0];[1  0  0];[1  0  0];[1  0  0];[1  0  0];[1  0  0];[1  0  0];[1  0  0];[1  0  0];[1  0  0];[1  0  0];[1 0 0];});
%scale for each electrode. The order and length must match the electrode list
CurrMontage.scale = flipud({'.15';'.15';'.15';'.15';'.15';'.15';'.15';'.15';'10';'35';'35';'35';'35';'.15';});
% channels to add scale lines to
CurrMontage.scaleChans = {'C3-M2' 'C4-M1'};
% channels to plot as second-to-second numeric data (e.g., SpO2) data
CurrMontage.o2satChs = {'SpO2'};
% channels to plot negative up
CurrMontage.negChans = {'C3-M2' 'O2-M1' 'E2-M2' 'E1-M2' 'EMG_L' 'EMG_R' 'C4-M1' 'O1-M2'};
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
CurrMontage.bigGridMat{2,1} = 'C4-M1';
CurrMontage.bigGridMat{2,2}{1,1} = '-.075';
CurrMontage.bigGridMat{2,2}{1,2} = [0 5.000000e-01 0];
CurrMontage.bigGridMat{2,2}{2,1} = '-.0375';
CurrMontage.bigGridMat{2,2}{2,2} = [0 5.000000e-01 0];
CurrMontage.bigGridMat{2,2}{3,1} = '0';
CurrMontage.bigGridMat{2,2}{3,2} = [0 5.000000e-01 0];
CurrMontage.bigGridMat{2,2}{4,1} = '.0375';
CurrMontage.bigGridMat{2,2}{4,2} = [0 5.000000e-01 0];
CurrMontage.bigGridMat{2,2}{5,1} = '.075';
CurrMontage.bigGridMat{2,2}{5,2} = [0 5.000000e-01 0];
