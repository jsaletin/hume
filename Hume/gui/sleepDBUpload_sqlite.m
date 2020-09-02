function varargout = sleepDBUpload_sqlite(varargin)
% SLEEPDBUPLOAD_SQLITE MATLAB code for sleepDBUpload_sqlite.fig
%%   Copyright (c) 2016 Jared M. Saletin, PhD and Stephanie M. Greer, PhD
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
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help sleepDBUpload_sqlite

% Last Modified by GUIDE v2.5 09-Jul-2020 13:08:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @sleepDBUpload_sqlite_OpeningFcn, ...
    'gui_OutputFcn',  @sleepDBUpload_sqlite_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before sleepDBUpload_sqlite is made visible.
function sleepDBUpload_sqlite_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to sleepDBUpload_sqlite (see VARARGIN)

% Choose default command line output for sleepDBUpload_sqlite
handles.output = hObject;

guidata(hObject, handles);

% UIWAIT makes sleepDBUpload_sqlite wait for user response (see UIRESUME)
% uiwait(handles.gui);


% --- Outputs from this function are returned to the command line.
function varargout = sleepDBUpload_sqlite_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in uploadData.
function uploadData_Callback(hObject, eventdata, handles)
% hObject    handle to uploadData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% See if Record Exists
if  ~isempty(fetch(handles.conn,['SELECT 1 FROM scoredinfo WHERE record = ''',handles.recordName.String,''';']))
    
    button = questdlg(['Record:''', handles.recordName.String,''' already exists in server. Replace?'],'Duplicate Record Found','Replace','Cancel','Cancel');
    if strmatch(button,'Cancel')
        return;
    elseif strmatch(button,'Replace')
        
        % Confirm Record and EDF Match
        
        % Confirm EDF and ID Match
        IDonRecord=fetch(handles.conn,['SELECT id FROM edfinfo WHERE edfname = ''',handles.edfName.String,''';']);
        if ~strcmpi(handles.id.String,num2str(IDonRecord{1}))
            
            msgbox(['The entered ID: ''',handles.id.String,''' does not match ID on record for ''', handles.edfName.String, ''': ''', num2str(IDonRecord{1}),'.'' Confirm!']);
            return;
        end
        
        % Confirm ID and Study Match
        studyOnRecord=fetch(handles.conn,['SELECT study FROM idStudy WHERE id = ''',handles.id.String,''';']);
        if ~strcmpi(handles.studyName.String{handles.studyName.Value},studyOnRecord{1})
            
            msgbox(['The entered study: ''',handles.studyName.String{handles.studyName.Value},''' does not match study on record for ''', handles.id.String, ''': ''', studyOnRecord{1},'.'' Confirm!']);
            return;
        end
        
        % Check if previous record was final and if you want to overwrite
        % it.
        finalStatus = cell2mat(fetch(handles.conn,['SELECT finalscores FROM scoredinfo WHERE record = ''', handles.recordName.String,''';']));
        if finalStatus == 1
            
            button = questdlg(['The previous record was labeled ''Final Data,'' are you sure you want to replace?'],'Overwrite Final Scores?','Replace','Cancel','Cancel');
            if strmatch(button,'Cancel')
                return;
            end
        end
        
        % Proceed with overwriting:
        update(handles.conn, 'scoredinfo', {'finalscores','uploadedby','datemodified','statsin', 'epochlength','combiningrule','minremlength','latencyrule'}, [{handles.finalData.Value,handles.conn.UserName,datestr(clock,'yyyy-mm-dd HH:MM:SS'), 'Hume'}, num2cell([handles.stageStats.stageData.win, handles.stageStats.rules.combiningRule, handles.stageStats.rules.minREMlength,handles.stageStats.rules.onsetRule])], ['where record =''',handles.recordName.String,'''']);
        
        update(handles.conn, 'endOfNight', {'laststagesleep','awakeatlightson'},[{handles.stageStats.lastStageSleep,handles.stageStats.awakeLightsOn}], ['where record =''',handles.recordName.String,'''']);
        
        update(handles.conn, 'lightsTimeInfo',{'lightsOff','lightsOn'}, [{datestr(handles.stageStats.stageData.lightsOFF,'HH:MM:SS'),datestr(handles.stageStats.stageData.lightsON,'HH:MM:SS')}], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'TDT', {'epochs','Minutes','TDTper','SPTper','TSTper'}, [(handles.stageStats.percentSleep(1,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'SPT', {'epochs','Minutes','TDTper','SPTper','TSTper'}, [(handles.stageStats.percentSleep(2,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'TST', {'epochs','Minutes','TDTper','SPTper','TSTper'}, [(handles.stageStats.percentSleep(3,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'SBSO', {'epochs','Minutes','TDTper','SPTper','TSTper'}, [(handles.stageStats.percentSleep(4,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'WASO', {'epochs','Minutes','TDTper','SPTper','TSTper'}, [(handles.stageStats.percentSleep(5,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'WAFA', {'epochs','Minutes','TDTper','SPTper','TSTper'}, [(handles.stageStats.percentSleep(6,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'SAFA', {'epochs','Minutes','TDTper','SPTper','TSTper'}, [(handles.stageStats.percentSleep(7,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'TWT', {'epochs','Minutes','TDTper','SPTper','TSTper'}, [(handles.stageStats.percentSleep(8,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'Stage1', {'epochs','Minutes','TDTper','SPTper','TSTper'}, [(handles.stageStats.percentSleep(9,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'Stage2', {'epochs','Minutes','TDTper','SPTper','TSTper'}, [(handles.stageStats.percentSleep(10,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'Stage3', {'epochs','Minutes','TDTper','SPTper','TSTper'}, [(handles.stageStats.percentSleep(11,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'Stage4', {'epochs','Minutes','TDTper','SPTper','TSTper'}, [(handles.stageStats.percentSleep(12,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'REM', {'epochs','Minutes','TDTper','SPTper','TSTper'}, [(handles.stageStats.percentSleep(13,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'MT', {'epochs','Minutes','TDTper','SPTper','TSTper'}, [(handles.stageStats.percentSleep(14,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'NREM', {'epochs','Minutes','TDTper','SPTper','TSTper'}, [(handles.stageStats.percentSleep(15,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'SW', {'epochs','Minutes','TDTper','SPTper','TSTper'}, [(handles.stageStats.percentSleep(16,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'ANOM', {'epochs','Minutes','TDTper','SPTper','TSTper'}, [(handles.stageStats.percentSleep(17,:))], ['where record =''',handles.recordName.String,'''']);
        
        update(handles.conn, 'latencySleep', {'epochs','Minutes'}, [(handles.stageStats.SleepLat(1,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'latency10min', {'epochs','Minutes'}, [(handles.stageStats.SleepLat(2,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'latencyLOS1', {'epochs','Minutes'}, [(handles.stageStats.SleepLat(3,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'latencyLOS2', {'epochs','Minutes'}, [(handles.stageStats.SleepLat(4,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'latencyLOS3', {'epochs','Minutes'}, [(handles.stageStats.SleepLat(5,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'latencyLOS4', {'epochs','Minutes'}, [(handles.stageStats.SleepLat(6,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'latencyLOSW', {'epochs','Minutes'}, [(handles.stageStats.SleepLat(7,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'latencyLOREM', {'epochs','Minutes'}, [(handles.stageStats.SleepLat(8,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'latencySOS1', {'epochs','Minutes'}, [(handles.stageStats.SleepLat(10,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'latencySOS2', {'epochs','Minutes'}, [(handles.stageStats.SleepLat(11,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'latencySOS3', {'epochs','Minutes'}, [(handles.stageStats.SleepLat(12,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'latencySOS4', {'epochs','Minutes'}, [(handles.stageStats.SleepLat(13,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'latencySOSW', {'epochs','Minutes'}, [(handles.stageStats.SleepLat(14,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'latencySOREM', {'epochs','Minutes'}, [(handles.stageStats.SleepLat(15,:))], ['where record =''',handles.recordName.String,'''']);
        
        update(handles.conn, 'QuarterWake', {'Q1','Q2','Q3','Q4'}, [(handles.stageStats.split4(1,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'QuarterS1', {'Q1','Q2','Q3','Q4'}, [(handles.stageStats.split4(2,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'QuarterS2', {'Q1','Q2','Q3','Q4'}, [(handles.stageStats.split4(3,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'QuarterS3', {'Q1','Q2','Q3','Q4'}, [(handles.stageStats.split4(4,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'QuarterS4', {'Q1','Q2','Q3','Q4'}, [(handles.stageStats.split4(5,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'QuarterREM', {'Q1','Q2','Q3','Q4'}, [(handles.stageStats.split4(6,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'QuarterMT', {'Q1','Q2','Q3','Q4'}, [(handles.stageStats.split4(7,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'QuarterSW', {'Q1','Q2','Q3','Q4'}, [(handles.stageStats.split4(8,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'QuarterTotal', {'Q1','Q2','Q3','Q4'}, [(handles.stageStats.split4(9,:))], ['where record =''',handles.recordName.String,'''']);
        
        update(handles.conn, 'ThirdWake', {'T1','T2','T3'}, [(handles.stageStats.split3(1,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'ThirdS1', {'T1','T2','T3'}, [(handles.stageStats.split3(2,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'ThirdS2', {'T1','T2','T3'}, [(handles.stageStats.split3(3,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'ThirdS3', {'T1','T2','T3'}, [(handles.stageStats.split3(4,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'ThirdS4', {'T1','T2','T3'}, [(handles.stageStats.split3(5,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'ThirdREM', {'T1','T2','T3'}, [(handles.stageStats.split3(6,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'ThirdMT', {'T1','T2','T3'}, [(handles.stageStats.split3(7,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'ThirdSW', {'T1','T2','T3'}, [(handles.stageStats.split3(8,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'ThirdTotal', {'T1','T2','T3'}, [(handles.stageStats.split3(9,:))], ['where record =''',handles.recordName.String,'''']);
        
        update(handles.conn, 'HalfWake', {'bi1', 'bi2'}, [(handles.stageStats.split2(1,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'HalfS1', {'bi1', 'bi2'}, [(handles.stageStats.split2(2,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'HalfS2', {'bi1', 'bi2'}, [(handles.stageStats.split2(3,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'HalfS3', {'bi1', 'bi2'}, [(handles.stageStats.split2(4,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'HalfS4', {'bi1', 'bi2'}, [(handles.stageStats.split2(5,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'HalfREM', {'bi1', 'bi2'}, [(handles.stageStats.split2(6,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'HalfMT', {'bi1', 'bi2'}, [(handles.stageStats.split2(7,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'HalfSW', {'bi1', 'bi2'}, [(handles.stageStats.split2(8,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'HalfTotal', {'bi1', 'bi2'}, [(handles.stageStats.split2(9,:))], ['where record =''',handles.recordName.String,'''']);
        
        update(handles.conn, 'CycleSummary', { 'numCycles', 'numNREMP', 'numREMP'}, [ num2cell([handles.stageStats.CycleSummary(1,1),size(handles.stageStats.NREMperiodStats,2),handles.stageStats.CycleSummary(1,2)])], ['where record =''',handles.recordName.String,'''']);
        TempCycles = NaN(10,18);
        if ~isempty(handles.StageStats.CycleStats)
            TempCycles(1:10,1:size(handles.stageStats.CycleStats,2)) = [handles.stageStats.CycleStats; handles.stageStats.REMperiodStats(10,:)];
            update(handles.conn, 'CycleWake', {'C1', 'C2', 'C3', 'C4', 'C5', 'C6', 'C7', 'C8', 'C9', 'C10', 'C11', 'C12', 'C13', 'C14', 'C15', 'C16', 'C17', 'C18'}, [(TempCycles(1,:))], ['where record =''',handles.recordName.String,'''']);
            update(handles.conn, 'CycleS1', {'C1', 'C2', 'C3', 'C4', 'C5', 'C6', 'C7', 'C8', 'C9', 'C10', 'C11', 'C12', 'C13', 'C14', 'C15', 'C16', 'C17', 'C18'}, [(TempCycles(2,:))], ['where record =''',handles.recordName.String,'''']);
            update(handles.conn, 'CycleS2', {'C1', 'C2', 'C3', 'C4', 'C5', 'C6', 'C7', 'C8', 'C9', 'C10', 'C11', 'C12', 'C13', 'C14', 'C15', 'C16', 'C17', 'C18'}, [(TempCycles(3,:))], ['where record =''',handles.recordName.String,'''']);
            update(handles.conn, 'CycleS3', {'C1', 'C2', 'C3', 'C4', 'C5', 'C6', 'C7', 'C8', 'C9', 'C10', 'C11', 'C12', 'C13', 'C14', 'C15', 'C16', 'C17', 'C18'}, [(TempCycles(4,:))], ['where record =''',handles.recordName.String,'''']);
            update(handles.conn, 'CycleS4', {'C1', 'C2', 'C3', 'C4', 'C5', 'C6', 'C7', 'C8', 'C9', 'C10', 'C11', 'C12', 'C13', 'C14', 'C15', 'C16', 'C17', 'C18'}, [(TempCycles(5,:))], ['where record =''',handles.recordName.String,'''']);
            update(handles.conn, 'CycleREM', {'C1', 'C2', 'C3', 'C4', 'C5', 'C6', 'C7', 'C8', 'C9', 'C10', 'C11', 'C12', 'C13', 'C14', 'C15', 'C16', 'C17', 'C18'}, [(TempCycles(6,:))], ['where record =''',handles.recordName.String,'''']);
            update(handles.conn, 'CycleMT', {'C1', 'C2', 'C3', 'C4', 'C5', 'C6', 'C7', 'C8', 'C9', 'C10', 'C11', 'C12', 'C13', 'C14', 'C15', 'C16', 'C17', 'C18'}, [(TempCycles(7,:))], ['where record =''',handles.recordName.String,'''']);
            update(handles.conn, 'CycleSW', {'C1', 'C2', 'C3', 'C4', 'C5', 'C6', 'C7', 'C8', 'C9', 'C10', 'C11', 'C12', 'C13', 'C14', 'C15', 'C16', 'C17', 'C18'}, [(TempCycles(8,:))], ['where record =''',handles.recordName.String,'''']);
            update(handles.conn, 'CycleTotal', {'C1', 'C2', 'C3', 'C4', 'C5', 'C6', 'C7', 'C8', 'C9', 'C10', 'C11', 'C12', 'C13', 'C14', 'C15', 'C16', 'C17', 'C18'}, [(TempCycles(9,:))], ['where record =''',handles.recordName.String,'''']);
            update(handles.conn, 'CycleREMSegments', {'C1', 'C2', 'C3', 'C4', 'C5', 'C6', 'C7', 'C8', 'C9', 'C10', 'C11', 'C12', 'C13', 'C14', 'C15', 'C16', 'C17', 'C18'}, [(TempCycles(10,:))], ['where record =''',handles.recordName.String,'''']);
        end
        
        TempHours = NaN(9,18);
        TempHours(1:9,1:size(handles.stageStats.splitHour,2)) = handles.stageStats.splitHour;
        update(handles.conn, 'HourSplitWake', { 'H1', 'H2', 'H3', 'H4', 'H5', 'H6', 'H7', 'H8', 'H9', 'H10', 'H11', 'H12', 'H13', 'H14', 'H15', 'H16', 'H17', 'H18'}, [(TempHours(1,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'HourSplitS1', { 'H1', 'H2', 'H3', 'H4', 'H5', 'H6', 'H7', 'H8', 'H9', 'H10', 'H11', 'H12', 'H13', 'H14', 'H15', 'H16', 'H17', 'H18'}, [(TempHours(2,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'HourSplitS2', { 'H1', 'H2', 'H3', 'H4', 'H5', 'H6', 'H7', 'H8', 'H9', 'H10', 'H11', 'H12', 'H13', 'H14', 'H15', 'H16', 'H17', 'H18'}, [(TempHours(3,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'HourSplitS3', { 'H1', 'H2', 'H3', 'H4', 'H5', 'H6', 'H7', 'H8', 'H9', 'H10', 'H11', 'H12', 'H13', 'H14', 'H15', 'H16', 'H17', 'H18'}, [(TempHours(4,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'HourSplitS4', { 'H1', 'H2', 'H3', 'H4', 'H5', 'H6', 'H7', 'H8', 'H9', 'H10', 'H11', 'H12', 'H13', 'H14', 'H15', 'H16', 'H17', 'H18'}, [(TempHours(5,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'HourSplitREM', { 'H1', 'H2', 'H3', 'H4', 'H5', 'H6', 'H7', 'H8', 'H9', 'H10', 'H11', 'H12', 'H13', 'H14', 'H15', 'H16', 'H17', 'H18'}, [(TempHours(6,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'HourSplitMT', { 'H1', 'H2', 'H3', 'H4', 'H5', 'H6', 'H7', 'H8', 'H9', 'H10', 'H11', 'H12', 'H13', 'H14', 'H15', 'H16', 'H17', 'H18'}, [(TempHours(7,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'HourSplitSW', { 'H1', 'H2', 'H3', 'H4', 'H5', 'H6', 'H7', 'H8', 'H9', 'H10', 'H11', 'H12', 'H13', 'H14', 'H15', 'H16', 'H17', 'H18'}, [(TempHours(8,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'HourSplitTotal', { 'H1', 'H2', 'H3', 'H4', 'H5', 'H6', 'H7', 'H8', 'H9', 'H10', 'H11', 'H12', 'H13', 'H14', 'H15', 'H16', 'H17', 'H18'}, [(TempHours(9,:))], ['where record =''',handles.recordName.String,'''']);
        
        update(handles.conn, 'transitionsFromWake', { 'Wake', 'S1', 'S2', 'S3', 'S4', 'REM', 'MT', 'SW'}, [([handles.stageStats.transTableAll(1,:) handles.stageStats.transTableCollapse(1,4)])], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'transitionsFromS1', { 'Wake', 'S1', 'S2', 'S3', 'S4', 'REM', 'MT', 'SW'}, [([handles.stageStats.transTableAll(2,:) handles.stageStats.transTableCollapse(2,4)])], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'transitionsFromS2', { 'Wake', 'S1', 'S2', 'S3', 'S4', 'REM', 'MT', 'SW'}, [([handles.stageStats.transTableAll(3,:) handles.stageStats.transTableCollapse(3,4)])], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'transitionsFromS3', { 'Wake', 'S1', 'S2', 'S3', 'S4', 'REM', 'MT'}, [([handles.stageStats.transTableAll(4,:)])], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'transitionsFromS4', { 'Wake', 'S1', 'S2', 'S3', 'S4', 'REM', 'MT'}, [([handles.stageStats.transTableAll(5,:)])], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'transitionsFromREM', { 'Wake', 'S1', 'S2', 'S3', 'S4', 'REM', 'MT', 'SW'}, [([handles.stageStats.transTableAll(6,:) handles.stageStats.transTableCollapse(5,4)])], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'transitionsFromMT', { 'Wake', 'S1', 'S2', 'S3', 'S4', 'REM', 'MT', 'SW'}, [([handles.stageStats.transTableAll(7,:) handles.stageStats.transTableCollapse(6,4)])], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'transitionsFromSW', { 'Wake', 'S1', 'S2', 'SW', 'REM', 'MT'}, [([handles.stageStats.transTableCollapse(4,:)])], ['where record =''',handles.recordName.String,'''']);

        if isfield(handles.stageStats, 'eventData')
            % Events
            for i = 1:size(handles.stageStats.eventData.events)
                switch handles.stageStats.eventData.events{i,1}
                    case 'Movement Arousal'
                        update(handles.conn, 'eventsMvtArousals', {'sptWake', 'sptMT', 'sptNREM', 'sptREM', 'sptTST', 'nsptSleep', 'nsptWake'}, [([handles.stageStats.eventData.events{i,2}])], ['where record =''',handles.recordName.String,'''']);
                        
                end
            end
        end
    end
    
else
    
    % See if id exists
    if ~isempty(fetch(handles.conn,['SELECT 1 FROM idStudy WHERE id = ''',handles.id.String,''';']));
        
        % Error if inputted ID and Study don't match database.
        studyOnRecord=fetch(handles.conn,['SELECT study FROM idStudy WHERE id = ''',handles.id.String,''';']);
        if ~strcmpi(handles.studyName.String{handles.studyName.Value},studyOnRecord{1})
            
            msgbox(['The entered study: ''',handles.studyName.String{handles.studyName.Value},''' does not match study on record for ''', handles.id.String, ''': ''', studyOnRecord{1},'.'' Confirm!']);
            return;
        end
    else
        % Insert ID and Study
        insert(handles.conn, 'idStudy', {'id','study'}, [{str2num(handles.id.String), ...
            handles.studyName.String{handles.studyName.Value}}]);
    end
    
    % See if EDF has previously been entered, i.e., first record from this EDF?
    if  isempty(fetch(handles.conn,['SELECT 1 FROM edfInfo WHERE edfname = ''',handles.edfName.String,''';']))
        % No EDF: Enter information provided
        insert(handles.conn, 'edfinfo', {'edfname','id','condition'}, [{handles.edfName.String, ...
            str2num(handles.id.String), ...
            handles.condition.String}]);
    else
        
        % Confirm this EDF belongs to this condition and ID
        edfOnrecord=fetch(handles.conn,['SELECT condition FROM edfInfo WHERE edfname = ''',handles.edfName.String,''';']);
        if ~strcmpi(handles.condition.String,edfOnrecord{1})
            msgbox(['The entered condition: ''', handles.condition.String,''' does not match the conditon on record for this EDF: ''',edfOnrecord{1},'.'' Confirm!']);
            return;
        end
    end
    
    % ID exists, ID And Study Match, EDF exists and EDF and Condition
    % match. We can proceed with the upload for this record.
    
    % Enter Record Info
    
    % If Final Scores is Checked, make sure no other final scores.
    if handles.finalData.Value == 1
        
        
        if sum(cell2mat(fetch(handles.conn,['SELECT finalscores FROM scoredinfo WHERE edfname = ''',handles.edfName.String,''';']))) == 1
            
            recordOnRecord=fetch(handles.conn,['SELECT record FROM scoredinfo WHERE edfname = ''',handles.edfName.String,''' AND finalscores = 1;']);
            
            % Previous final data
            button = questdlg(['Previous final data for EDF: ''', handles.edfName.String,''' exists: ''', recordOnRecord{1}, '.'' Replace with current record?'],'Pre-existing Record Found','Replace','Cancel','Cancel');
            if strmatch(button,'Cancel')
                return;
            elseif strmatch(button,'Replace')
                
                % Remove final record from previous record.
                update(handles.conn, 'scoredinfo', {'finalscores'}, {'FALSE'}, ['where record = ''',recordOnRecord{1},'''']);
                
            end
        end
    end
    
    insert(handles.conn, 'scoredInfo', {'record','edfname','scorer','finalscores','uploadedby','datemodified', 'statsin', 'epochlength','combiningrule','minremlength','latencyrule'},[{handles.recordName.String,handles.edfName.String,handles.scorer.String,handles.finalData.Value,handles.conn.UserName,datestr(clock,'yyyy-mm-dd HH:MM:SS'), 'Hume'}, num2cell([handles.stageStats.stageData.win, handles.stageStats.rules.combiningRule, handles.stageStats.rules.minREMlength,handles.stageStats.rules.onsetRule ])]);
    insert(handles.conn, 'endOfNight', {'record','laststagesleep','awakeatlightson'},[{handles.recordName.String,handles.stageStats.lastStageSleep,handles.stageStats.awakeLightsOn}]);
    % Enter Statistics
    insert(handles.conn, 'lightsTimeInfo',{'record','lightsOff','lightsOn'}, [{handles.recordName.String,datestr(handles.stageStats.stageData.lightsOFF,'HH:MM:SS'),datestr(handles.stageStats.stageData.lightsON,'HH:MM:SS')}]);
    insert(handles.conn, 'TDT', {'record','epochs','Minutes','TDTper','SPTper','TSTper'}, [{handles.recordName.String},num2cell(handles.stageStats.percentSleep(1,:))]);
    insert(handles.conn, 'SPT', {'record','epochs','Minutes','TDTper','SPTper','TSTper'}, [{handles.recordName.String},num2cell(handles.stageStats.percentSleep(2,:))]);
    insert(handles.conn, 'TST', {'record','epochs','Minutes','TDTper','SPTper','TSTper'}, [{handles.recordName.String},num2cell(handles.stageStats.percentSleep(3,:))]);
    insert(handles.conn, 'SBSO', {'record','epochs','Minutes','TDTper','SPTper','TSTper'}, [{handles.recordName.String},num2cell(handles.stageStats.percentSleep(4,:))]);
    insert(handles.conn, 'WASO', {'record','epochs','Minutes','TDTper','SPTper','TSTper'}, [{handles.recordName.String},num2cell(handles.stageStats.percentSleep(5,:))]);
    insert(handles.conn, 'WAFA', {'record','epochs','Minutes','TDTper','SPTper','TSTper'}, [{handles.recordName.String},num2cell(handles.stageStats.percentSleep(6,:))]);
    insert(handles.conn, 'SAFA', {'record','epochs','Minutes','TDTper','SPTper','TSTper'}, [{handles.recordName.String},num2cell(handles.stageStats.percentSleep(7,:))]);
    insert(handles.conn, 'TWT', {'record','epochs','Minutes','TDTper','SPTper','TSTper'}, [{handles.recordName.String},num2cell(handles.stageStats.percentSleep(8,:))]);
    insert(handles.conn, 'Stage1', {'record','epochs','Minutes','TDTper','SPTper','TSTper'}, [{handles.recordName.String},num2cell(handles.stageStats.percentSleep(9,:))]);
    insert(handles.conn, 'Stage2', {'record','epochs','Minutes','TDTper','SPTper','TSTper'}, [{handles.recordName.String},num2cell(handles.stageStats.percentSleep(10,:))]);
    insert(handles.conn, 'Stage3', {'record','epochs','Minutes','TDTper','SPTper','TSTper'}, [{handles.recordName.String},num2cell(handles.stageStats.percentSleep(11,:))]);
    insert(handles.conn, 'Stage4', {'record','epochs','Minutes','TDTper','SPTper','TSTper'}, [{handles.recordName.String},num2cell(handles.stageStats.percentSleep(12,:))]);
    insert(handles.conn, 'REM', {'record','epochs','Minutes','TDTper','SPTper','TSTper'}, [{handles.recordName.String},num2cell(handles.stageStats.percentSleep(13,:))]);
    insert(handles.conn, 'MT', {'record','epochs','Minutes','TDTper','SPTper','TSTper'}, [{handles.recordName.String},num2cell(handles.stageStats.percentSleep(14,:))]);
    insert(handles.conn, 'NREM', {'record','epochs','Minutes','TDTper','SPTper','TSTper'}, [{handles.recordName.String},num2cell(handles.stageStats.percentSleep(15,:))]);
    insert(handles.conn, 'SW', {'record','epochs','Minutes','TDTper','SPTper','TSTper'}, [{handles.recordName.String},num2cell(handles.stageStats.percentSleep(16,:))]);
    insert(handles.conn, 'ANOM', {'record','epochs','Minutes','TDTper','SPTper','TSTper'}, [{handles.recordName.String},num2cell(handles.stageStats.percentSleep(17,:))]);
    
    insert(handles.conn, 'latencySleep', {'record','epochs','Minutes'}, [{handles.recordName.String},num2cell(handles.stageStats.SleepLat(1,:))]);
    insert(handles.conn, 'latency10min', {'record','epochs','Minutes'}, [{handles.recordName.String},num2cell(handles.stageStats.SleepLat(2,:))]);
    insert(handles.conn, 'latencyLOS1', {'record','epochs','Minutes'}, [{handles.recordName.String},num2cell(handles.stageStats.SleepLat(3,:))]);
    insert(handles.conn, 'latencyLOS2', {'record','epochs','Minutes'}, [{handles.recordName.String},num2cell(handles.stageStats.SleepLat(4,:))]);
    insert(handles.conn, 'latencyLOS3', {'record','epochs','Minutes'}, [{handles.recordName.String},num2cell(handles.stageStats.SleepLat(5,:))]);
    insert(handles.conn, 'latencyLOS4', {'record','epochs','Minutes'}, [{handles.recordName.String},num2cell(handles.stageStats.SleepLat(6,:))]);
    insert(handles.conn, 'latencyLOSW', {'record','epochs','Minutes'}, [{handles.recordName.String},num2cell(handles.stageStats.SleepLat(7,:))]);
    insert(handles.conn, 'latencyLOREM', {'record','epochs','Minutes'}, [{handles.recordName.String},num2cell(handles.stageStats.SleepLat(8,:))]);
    insert(handles.conn, 'latencySOS1', {'record','epochs','Minutes'}, [{handles.recordName.String},num2cell(handles.stageStats.SleepLat(10,:))]);
    insert(handles.conn, 'latencySOS2', {'record','epochs','Minutes'}, [{handles.recordName.String},num2cell(handles.stageStats.SleepLat(11,:))]);
    insert(handles.conn, 'latencySOS3', {'record','epochs','Minutes'}, [{handles.recordName.String},num2cell(handles.stageStats.SleepLat(12,:))]);
    insert(handles.conn, 'latencySOS4', {'record','epochs','Minutes'}, [{handles.recordName.String},num2cell(handles.stageStats.SleepLat(13,:))]);
    insert(handles.conn, 'latencySOSW', {'record','epochs','Minutes'}, [{handles.recordName.String},num2cell(handles.stageStats.SleepLat(14,:))]);
    insert(handles.conn, 'latencySOREM', {'record','epochs','Minutes'}, [{handles.recordName.String},num2cell(handles.stageStats.SleepLat(15,:))]);
    
    insert(handles.conn, 'QuarterWake', {'record','Q1','Q2','Q3','Q4'}, [{handles.recordName.String},num2cell(handles.stageStats.split4(1,:))]);
    insert(handles.conn, 'QuarterS1', {'record','Q1','Q2','Q3','Q4'}, [{handles.recordName.String},num2cell(handles.stageStats.split4(2,:))]);
    insert(handles.conn, 'QuarterS2', {'record','Q1','Q2','Q3','Q4'}, [{handles.recordName.String},num2cell(handles.stageStats.split4(3,:))]);
    insert(handles.conn, 'QuarterS3', {'record','Q1','Q2','Q3','Q4'}, [{handles.recordName.String},num2cell(handles.stageStats.split4(4,:))]);
    insert(handles.conn, 'QuarterS4', {'record','Q1','Q2','Q3','Q4'}, [{handles.recordName.String},num2cell(handles.stageStats.split4(5,:))]);
    insert(handles.conn, 'QuarterREM', {'record','Q1','Q2','Q3','Q4'}, [{handles.recordName.String},num2cell(handles.stageStats.split4(6,:))]);
    insert(handles.conn, 'QuarterMT', {'record','Q1','Q2','Q3','Q4'}, [{handles.recordName.String},num2cell(handles.stageStats.split4(7,:))]);
    insert(handles.conn, 'QuarterSW', {'record','Q1','Q2','Q3','Q4'}, [{handles.recordName.String},num2cell(handles.stageStats.split4(8,:))]);
    insert(handles.conn, 'QuarterTotal', {'record','Q1','Q2','Q3','Q4'}, [{handles.recordName.String},num2cell(handles.stageStats.split4(9,:))]);
    
    insert(handles.conn, 'ThirdWake', {'record','T1','T2','T3'}, [{handles.recordName.String},num2cell(handles.stageStats.split3(1,:))]);
    insert(handles.conn, 'ThirdS1', {'record','T1','T2','T3'}, [{handles.recordName.String},num2cell(handles.stageStats.split3(2,:))]);
    insert(handles.conn, 'ThirdS2', {'record','T1','T2','T3'}, [{handles.recordName.String},num2cell(handles.stageStats.split3(3,:))]);
    insert(handles.conn, 'ThirdS3', {'record','T1','T2','T3'}, [{handles.recordName.String},num2cell(handles.stageStats.split3(4,:))]);
    insert(handles.conn, 'ThirdS4', {'record','T1','T2','T3'}, [{handles.recordName.String},num2cell(handles.stageStats.split3(5,:))]);
    insert(handles.conn, 'ThirdREM', {'record','T1','T2','T3'}, [{handles.recordName.String},num2cell(handles.stageStats.split3(6,:))]);
    insert(handles.conn, 'ThirdMT', {'record','T1','T2','T3'}, [{handles.recordName.String},num2cell(handles.stageStats.split3(7,:))]);
    insert(handles.conn, 'ThirdSW', {'record','T1','T2','T3'}, [{handles.recordName.String},num2cell(handles.stageStats.split3(8,:))]);
    insert(handles.conn, 'ThirdTotal', {'record','T1','T2','T3'}, [{handles.recordName.String},num2cell(handles.stageStats.split3(9,:))]);
    
    insert(handles.conn, 'HalfWake', {'record','bi1', 'bi2'}, [{handles.recordName.String},num2cell(handles.stageStats.split2(1,:))]);
    insert(handles.conn, 'HalfS1', {'record','bi1', 'bi2'}, [{handles.recordName.String},num2cell(handles.stageStats.split2(2,:))]);
    insert(handles.conn, 'HalfS2', {'record','bi1', 'bi2'}, [{handles.recordName.String},num2cell(handles.stageStats.split2(3,:))]);
    insert(handles.conn, 'HalfS3', {'record','bi1', 'bi2'}, [{handles.recordName.String},num2cell(handles.stageStats.split2(4,:))]);
    insert(handles.conn, 'HalfS4', {'record','bi1', 'bi2'}, [{handles.recordName.String},num2cell(handles.stageStats.split2(5,:))]);
    insert(handles.conn, 'HalfREM', {'record','bi1', 'bi2'}, [{handles.recordName.String},num2cell(handles.stageStats.split2(6,:))]);
    insert(handles.conn, 'HalfMT', {'record','bi1', 'bi2'}, [{handles.recordName.String},num2cell(handles.stageStats.split2(7,:))]);
    insert(handles.conn, 'HalfSW', {'record','bi1', 'bi2'}, [{handles.recordName.String},num2cell(handles.stageStats.split2(8,:))]);
    insert(handles.conn, 'HalfTotal', {'record','bi1', 'bi2'}, [{handles.recordName.String},num2cell(handles.stageStats.split2(9,:))]);
    
    insert(handles.conn, 'CycleSummary', {'record', 'numCycles', 'numNREMP', 'numREMP'}, [{handles.recordName.String}, num2cell([handles.stageStats.CycleSummary(1,1),size(handles.stageStats.NREMperiodStats,2),handles.stageStats.CycleSummary(1,2)])]);
    TempCycles = NaN(10,18);
    TempCycles(1:10,1:size(handles.stageStats.CycleStats,2)) = [handles.stageStats.CycleStats; handles.stageStats.REMperiodStats(10,:)];
    insert(handles.conn, 'CycleWake', {'record','C1', 'C2', 'C3', 'C4', 'C5', 'C6', 'C7', 'C8', 'C9', 'C10', 'C11', 'C12', 'C13', 'C14', 'C15', 'C16', 'C17', 'C18'}, [{handles.recordName.String},num2cell(TempCycles(1,:))]);
    insert(handles.conn, 'CycleS1', {'record','C1', 'C2', 'C3', 'C4', 'C5', 'C6', 'C7', 'C8', 'C9', 'C10', 'C11', 'C12', 'C13', 'C14', 'C15', 'C16', 'C17', 'C18'}, [{handles.recordName.String},num2cell(TempCycles(2,:))]);
    insert(handles.conn, 'CycleS2', {'record','C1', 'C2', 'C3', 'C4', 'C5', 'C6', 'C7', 'C8', 'C9', 'C10', 'C11', 'C12', 'C13', 'C14', 'C15', 'C16', 'C17', 'C18'}, [{handles.recordName.String},num2cell(TempCycles(3,:))]);
    insert(handles.conn, 'CycleS3', {'record','C1', 'C2', 'C3', 'C4', 'C5', 'C6', 'C7', 'C8', 'C9', 'C10', 'C11', 'C12', 'C13', 'C14', 'C15', 'C16', 'C17', 'C18'}, [{handles.recordName.String},num2cell(TempCycles(4,:))]);
    insert(handles.conn, 'CycleS4', {'record','C1', 'C2', 'C3', 'C4', 'C5', 'C6', 'C7', 'C8', 'C9', 'C10', 'C11', 'C12', 'C13', 'C14', 'C15', 'C16', 'C17', 'C18'}, [{handles.recordName.String},num2cell(TempCycles(5,:))]);
    insert(handles.conn, 'CycleREM', {'record','C1', 'C2', 'C3', 'C4', 'C5', 'C6', 'C7', 'C8', 'C9', 'C10', 'C11', 'C12', 'C13', 'C14', 'C15', 'C16', 'C17', 'C18'}, [{handles.recordName.String},num2cell(TempCycles(6,:))]);
    insert(handles.conn, 'CycleMT', {'record','C1', 'C2', 'C3', 'C4', 'C5', 'C6', 'C7', 'C8', 'C9', 'C10', 'C11', 'C12', 'C13', 'C14', 'C15', 'C16', 'C17', 'C18'}, [{handles.recordName.String},num2cell(TempCycles(7,:))]);
    insert(handles.conn, 'CycleSW', {'record','C1', 'C2', 'C3', 'C4', 'C5', 'C6', 'C7', 'C8', 'C9', 'C10', 'C11', 'C12', 'C13', 'C14', 'C15', 'C16', 'C17', 'C18'}, [{handles.recordName.String},num2cell(TempCycles(8,:))]);
    insert(handles.conn, 'CycleTotal', {'record','C1', 'C2', 'C3', 'C4', 'C5', 'C6', 'C7', 'C8', 'C9', 'C10', 'C11', 'C12', 'C13', 'C14', 'C15', 'C16', 'C17', 'C18'}, [{handles.recordName.String},num2cell(TempCycles(9,:))]);
    insert(handles.conn, 'CycleREMSegments', {'record','C1', 'C2', 'C3', 'C4', 'C5', 'C6', 'C7', 'C8', 'C9', 'C10', 'C11', 'C12', 'C13', 'C14', 'C15', 'C16', 'C17', 'C18'}, [{handles.recordName.String},num2cell(TempCycles(10,:))]);
    
    TempHours = NaN(9,18);
    TempHours(1:9,1:size(handles.stageStats.splitHour,2)) = handles.stageStats.splitHour;
    insert(handles.conn, 'HourSplitWake', {'record', 'H1', 'H2', 'H3', 'H4', 'H5', 'H6', 'H7', 'H8', 'H9', 'H10', 'H11', 'H12', 'H13', 'H14', 'H15', 'H16', 'H17', 'H18'}, [{handles.recordName.String},num2cell(TempHours(1,:))]);
    insert(handles.conn, 'HourSplitS1', {'record', 'H1', 'H2', 'H3', 'H4', 'H5', 'H6', 'H7', 'H8', 'H9', 'H10', 'H11', 'H12', 'H13', 'H14', 'H15', 'H16', 'H17', 'H18'}, [{handles.recordName.String},num2cell(TempHours(2,:))]);
    insert(handles.conn, 'HourSplitS2', {'record', 'H1', 'H2', 'H3', 'H4', 'H5', 'H6', 'H7', 'H8', 'H9', 'H10', 'H11', 'H12', 'H13', 'H14', 'H15', 'H16', 'H17', 'H18'}, [{handles.recordName.String},num2cell(TempHours(3,:))]);
    insert(handles.conn, 'HourSplitS3', {'record', 'H1', 'H2', 'H3', 'H4', 'H5', 'H6', 'H7', 'H8', 'H9', 'H10', 'H11', 'H12', 'H13', 'H14', 'H15', 'H16', 'H17', 'H18'}, [{handles.recordName.String},num2cell(TempHours(4,:))]);
    insert(handles.conn, 'HourSplitS4', {'record', 'H1', 'H2', 'H3', 'H4', 'H5', 'H6', 'H7', 'H8', 'H9', 'H10', 'H11', 'H12', 'H13', 'H14', 'H15', 'H16', 'H17', 'H18'}, [{handles.recordName.String},num2cell(TempHours(5,:))]);
    insert(handles.conn, 'HourSplitREM', {'record', 'H1', 'H2', 'H3', 'H4', 'H5', 'H6', 'H7', 'H8', 'H9', 'H10', 'H11', 'H12', 'H13', 'H14', 'H15', 'H16', 'H17', 'H18'}, [{handles.recordName.String},num2cell(TempHours(6,:))]);
    insert(handles.conn, 'HourSplitMT', {'record', 'H1', 'H2', 'H3', 'H4', 'H5', 'H6', 'H7', 'H8', 'H9', 'H10', 'H11', 'H12', 'H13', 'H14', 'H15', 'H16', 'H17', 'H18'}, [{handles.recordName.String},num2cell(TempHours(7,:))]);
    insert(handles.conn, 'HourSplitSW', {'record', 'H1', 'H2', 'H3', 'H4', 'H5', 'H6', 'H7', 'H8', 'H9', 'H10', 'H11', 'H12', 'H13', 'H14', 'H15', 'H16', 'H17', 'H18'}, [{handles.recordName.String},num2cell(TempHours(8,:))]);
    insert(handles.conn, 'HourSplitTotal', {'record', 'H1', 'H2', 'H3', 'H4', 'H5', 'H6', 'H7', 'H8', 'H9', 'H10', 'H11', 'H12', 'H13', 'H14', 'H15', 'H16', 'H17', 'H18'}, [{handles.recordName.String},num2cell(TempHours(9,:))]);
    
    insert(handles.conn, 'transitionsFromWake', {'record', 'Wake', 'S1', 'S2', 'S3', 'S4', 'REM', 'MT', 'SW'}, [{handles.recordName.String},num2cell([handles.stageStats.transTableAll(1,:) handles.stageStats.transTableCollapse(1,4)])]);
    insert(handles.conn, 'transitionsFromS1', {'record', 'Wake', 'S1', 'S2', 'S3', 'S4', 'REM', 'MT', 'SW'}, [{handles.recordName.String},num2cell([handles.stageStats.transTableAll(2,:) handles.stageStats.transTableCollapse(2,4)])]);
    insert(handles.conn, 'transitionsFromS2', {'record', 'Wake', 'S1', 'S2', 'S3', 'S4', 'REM', 'MT', 'SW'}, [{handles.recordName.String},num2cell([handles.stageStats.transTableAll(3,:) handles.stageStats.transTableCollapse(3,4)])]);
    insert(handles.conn, 'transitionsFromS3', {'record', 'Wake', 'S1', 'S2', 'S3', 'S4', 'REM', 'MT'}, [{handles.recordName.String},num2cell([handles.stageStats.transTableAll(4,:)])]);
    insert(handles.conn, 'transitionsFromS4', {'record', 'Wake', 'S1', 'S2', 'S3', 'S4', 'REM', 'MT'}, [{handles.recordName.String},num2cell([handles.stageStats.transTableAll(5,:)])]);
    insert(handles.conn, 'transitionsFromREM', {'record', 'Wake', 'S1', 'S2', 'S3', 'S4', 'REM', 'MT', 'SW'}, [{handles.recordName.String},num2cell([handles.stageStats.transTableAll(6,:) handles.stageStats.transTableCollapse(5,4)])]);
    insert(handles.conn, 'transitionsFromMT', {'record', 'Wake', 'S1', 'S2', 'S3', 'S4', 'REM', 'MT', 'SW'}, [{handles.recordName.String},num2cell([handles.stageStats.transTableAll(7,:) handles.stageStats.transTableCollapse(6,4)])]);
    insert(handles.conn, 'transitionsFromSW', {'record', 'Wake', 'S1', 'S2', 'SW', 'REM', 'MT'}, [{handles.recordName.String},num2cell([handles.stageStats.transTableCollapse(4,:)])]);
    
    if isfield(handles.stageStats, 'eventData')
        % Events
        for i = 1:size(handles.stageStats.eventData.events)
            switch handles.stageStats.eventData.events{i,1}
                case 'Movement Arousal'
                    insert(handles.conn, 'eventsMvtArousals', {'record', 'sptWake', 'sptMT', 'sptNREM', 'sptREM', 'sptTST', 'nsptSleep', 'nsptWake'}, [{handles.recordName.String},num2cell([handles.stageStats.eventData.events{i,2}])]);
                    
            end
        end
    end
    
end
waitfor(msgbox('Upload complete!'));
close(handles.gui);


function fileIN_Callback(hObject, eventdata, handles)
% hObject    handle to fileIN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fileIN as text
%        str2double(get(hObject,'String')) returns contents of fileIN as a double


% --- Executes during object creation, after setting all properties.
function fileIN_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fileIN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in browseFileIN.
function browseFileIN_Callback(hObject, eventdata, handles)
% hObject    handle to browseFileIN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% formats = get(handles.fileType,'String');
% for i=2:length(formats)
%     fileListings{i-1,1} = ['*',handles.extList{i-1}];
%     fileListings{i-1,2} = formats{i};
% end
[statsDir] = uigetdir([],'Hümé Sleep Output Folder');
[folder, file] = fileparts(statsDir);
set(handles.fileIN, 'String', file);
set(handles.fileIN, 'ForegroundColor', 'k');
handles.pathName = folder;

if isempty(getappdata(0,'Conn'))
    msgbox(['Lost connection to database, sing out and log in again!']);
    return;
else
    if ~isopen(getappdata(0,'Conn'))
        msgbox(['Lost connection to database, sing out and log in again!']);
        return;
        
    else
        handles.conn = getappdata(0,'Conn');
        setdbprefs('DataReturnFormat','cellarray');  

        % Load SleepStats
        load([handles.pathName,'/',handles.fileIN.String,'/',handles.fileIN.String,'_stats.mat']);
        handles.stageStats = stageStats;
        % Set Record Name
        set(handles.recordName, 'String', handles.fileIN.String);
        
        % Strip ID and Scorer
        [scorer_id, cond] = strtok(handles.fileIN.String,'_');
        id = scorer_id(isstrprop(scorer_id,'digit'));
        scorer = scorer_id(isstrprop(scorer_id,'alpha'));
        
        set(handles.id,'String',id);
        set(handles.scorer,'String',scorer);
        set(handles.condition,'String',cond(2:end));
        
        studies = sortrows(fetch(handles.conn, 'SELECT study FROM studies;'));
        if  strmatch(class(studies),'table')
            studies = table2cell(studies);
        end
        set(handles.studyName,'String',{'Study',studies{:}});
        
        % Check ID in system
        if  ~isempty(fetch(handles.conn,['SELECT 1 FROM idStudy WHERE id = ',id,';']))
            
            set(handles.studyName,'Value',find(ismember(handles.studyName.String, fetch(handles.conn, ['SELECT study FROM idStudy WHERE id = ',id,';']))));
        else
            set(handles.studyName,'Value',1);
        end
        
        % If EDFNAME in Notes
        if isfield(handles.stageStats.stageData,'EDFname')
            set(handles.edfName,'String',handles.stageStats.stageData.EDFname);
        elseif ~isempty(handles.stageStats.stageData.Notes)
            
            if ~isempty(find(~cellfun('isempty',regexp(cellstr(handles.stageStats.stageData.Notes),'File name'))))
                
                FileStr=strsplit(handles.stageStats.stageData.Notes(find(~cellfun('isempty',regexp(cellstr(handles.stageStats.stageData.Notes),'File name'))),:));
                set(handles.edfName,'String',FileStr{3});
            end
        end
        
    end
end
% Update handles structure
guidata(hObject, handles);

% --- Executes on selection change in dbAuth.
function dbAuth_Callback(hObject, eventdata, handles)
% hObject    handle to dbAuth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns dbAuth contents as cell array
%        contents{get(hObject,'Value')} returns selected item from dbAuth


% --- Executes during object creation, after setting all properties.
function dbAuth_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dbAuth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function dbDomain_Callback(hObject, eventdata, handles)
% hObject    handle to dbDomain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dbDomain as text
%        str2double(get(hObject,'String')) returns contents of dbDomain as a double

% --- Executes during object creation, after setting all properties.
function dbDomain_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dbDomain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function dbPassword_Callback(hObject, eventdata, handles)
% hObject    handle to dbPassword (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dbPassword as text
%        str2double(get(hObject,'String')) returns contents of dbPassword as a double

% --- Executes during object creation, after setting all properties.
function dbPassword_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dbPassword (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function dbUsername_Callback(hObject, eventdata, handles)
% hObject    handle to dbUsername (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dbUsername as text
%        str2double(get(hObject,'String')) returns contents of dbUsername as a double

% --- Executes during object creation, after setting all properties.
function dbUsername_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dbUsername (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function dbName_Callback(hObject, eventdata, handles)
% hObject    handle to dbName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dbName as text
%        str2double(get(hObject,'String')) returns contents of dbName as a double


% --- Executes during object creation, after setting all properties.
function dbName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dbName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function dbAddress_Callback(hObject, eventdata, handles)
% hObject    handle to dbAddress (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dbAddress as text
%        str2double(get(hObject,'String')) returns contents of dbAddress as a double

% --- Executes during object creation, after setting all properties.
function dbAddress_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dbAddress (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function id_Callback(hObject, eventdata, handles)
% hObject    handle to id (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of id as text
%        str2double(get(hObject,'String')) returns contents of id as a double

% --- Executes during object creation, after setting all properties.
function id_CreateFcn(hObject, eventdata, handles)
% hObject    handle to id (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function studyName_Callback(hObject, eventdata, handles)
% hObject    handle to studyName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of studyName as text
%        str2double(get(hObject,'String')) returns contents of studyName as a double

% --- Executes during object creation, after setting all properties.
function studyName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to studyName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edfName_Callback(hObject, eventdata, handles)
% hObject    handle to edfName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edfName as text
%        str2double(get(hObject,'String')) returns contents of edfName as a double

% --- Executes during object creation, after setting all properties.
function edfName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edfName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function recordName_Callback(hObject, eventdata, handles)
% hObject    handle to recordName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of recordName as text
%        str2double(get(hObject,'String')) returns contents of recordName as a double

% --- Executes during object creation, after setting all properties.
function recordName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to recordName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function recordSite_Callback(hObject, eventdata, handles)
% hObject    handle to recordSite (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of recordSite as text
%        str2double(get(hObject,'String')) returns contents of recordSite as a double


% --- Executes during object creation, after setting all properties.
function recordSite_CreateFcn(hObject, eventdata, handles)
% hObject    handle to recordSite (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in finalData.
function finalData_Callback(hObject, eventdata, handles)
% hObject    handle to finalData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of finalData



function scorer_Callback(hObject, eventdata, handles)
% hObject    handle to scorer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of scorer as text
%        str2double(get(hObject,'String')) returns contents of scorer as a double


% --- Executes during object creation, after setting all properties.
function scorer_CreateFcn(hObject, eventdata, handles)
% hObject    handle to scorer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function condition_Callback(hObject, eventdata, handles)
% hObject    handle to condition (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of condition as text
%        str2double(get(hObject,'String')) returns contents of condition as a double


% --- Executes during object creation, after setting all properties.
function condition_CreateFcn(hObject, eventdata, handles)
% hObject    handle to condition (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
