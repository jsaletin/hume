function output = sleep_Montage(handles)
% Auto-generated Húmë Scoring Montage
% Húmë written by Jared M. Saletin, PhD and Stephanie M. Greer, PhD
% (c) 2011

% Montage Generated from File: 317_scoring128.set
% Montage Generated on Date: 12-Jan-2015

% channels to hide
output.hideChans = {};
%electrode names that should be ploted.
output.electrodes = flipud({'ROC-A1';'LOC-A2';'C3-A2';'O2-A1';'C4-A1';'O1-A2';'EMG1-EMG2';'EMG1-EMG3';'EMG2-EMG3';});
% channels to add scale lines to
handles.negChans = {'ROC-A1';'LOC-A2';'C3-A2';'O2-A1';'C4-A1';'O1-A2';'EMG1-EMG2';'EMG1-EMG3';'EMG2-EMG3';};
% channels to plot as second-to-second numeric data (e.g., SpO2) data
handles.o2satChs = {};
%colors for each electrode. The order and length must match the electrode list
output.colors = flipud({[0  0  0];[0  0  0];[0  0  1];[0  0  1];[0  0  1];[0  0  1];[1  0  0];[1  0  0];[1  0  0];});
%scale for each electrode. The order and length must match the electrode list
output.scale = flipud({'100';'100';'100';'100';'100';'100';'100';'100';'100';});
% channels to add scale lines to
output.scaleChans = {'C3-A2' 'C4-A1' };
% voltage to place scales
output.bigGridMat{1,1} = 'C3-A2';
output.bigGridMat{1,2}{1,1} = '-50';
output.bigGridMat{1,2}{1,2} = [1 0 0];
output.bigGridMat{1,2}{2,1} = '-25';
output.bigGridMat{1,2}{2,2} = [1 0 0];
output.bigGridMat{1,2}{3,1} = '0';
output.bigGridMat{1,2}{3,2} = [1 0 0];
output.bigGridMat{1,2}{4,1} = '25';
output.bigGridMat{1,2}{4,2} = [1 0 0];
output.bigGridMat{1,2}{5,1} = '50';
output.bigGridMat{1,2}{5,2} = [1 0 0];
output.bigGridMat{2,1} = 'C4-A1';
output.bigGridMat{2,2}{1,1} = '-50';
output.bigGridMat{2,2}{1,2} = [1 0 0];
output.bigGridMat{2,2}{2,1} = '-25';
output.bigGridMat{2,2}{2,2} = [1 0 0];
output.bigGridMat{2,2}{3,1} = '0';
output.bigGridMat{2,2}{3,2} = [1 0 0];
output.bigGridMat{2,2}{4,1} = '25';
output.bigGridMat{2,2}{4,2} = [1 0 0];
output.bigGridMat{2,2}{5,1} = '50';
output.bigGridMat{2,2}{5,2} = [1 0 0];
