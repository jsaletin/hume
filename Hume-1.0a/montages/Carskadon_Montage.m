function handles = sleep_Montage(handles)
% Auto-generated Húmë Scoring Montage
% Húmë written by Jared M. Saletin, PhD and Stephanie M. Greer, PhD
% (c) 2011

% Montage Generated from File: 207006_2
% Montage Generated on Date: 14-Jan-2015

% channels to hide
handles.hideChans = {};
%electrode names that should be ploted.
handles.electrodes = flipud({'C3-A2';'O2-A1';'ROC-A1';'LOC-A2';'Chin EMG 1-Chin';'C4-A1';'O1-A2';});
%colors for each electrode. The order and length must match the electrode list
handles.colors = flipud({[1  0  0];[1  0  0];[1  0  0];[1  0  0];[1  0  0];[1  0  0];[1  0  0];});
%scale for each electrode. The order and length must match the electrode list
handles.scale = flipud({'150';'150';'150';'150';'150';'150';'150';});
% channels to add scale lines to
handles.scaleChans = {'C3-A2' 'C4-A1' };
% voltage to place scales
handles.bigGridMat{1,1} = 'C3-A2';
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
handles.bigGridMat{2,1} = 'C4-A1';
handles.bigGridMat{2,2}{1,1} = '-75';
handles.bigGridMat{2,2}{1,2} = [0 5.000000e-01 0];
handles.bigGridMat{2,2}{2,1} = '-37.5';
handles.bigGridMat{2,2}{2,2} = [0 5.000000e-01 0];
handles.bigGridMat{2,2}{3,1} = '0';
handles.bigGridMat{2,2}{3,2} = [0 5.000000e-01 0];
handles.bigGridMat{2,2}{4,1} = '37.5';
handles.bigGridMat{2,2}{4,2} = [0 5.000000e-01 0];
handles.bigGridMat{2,2}{5,1} = '75';
handles.bigGridMat{2,2}{5,2} = [0 5.000000e-01 0];
