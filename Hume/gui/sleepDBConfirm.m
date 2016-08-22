function varargout = sleepDBConfirm(varargin)
% SLEEPDBCONFIRM MATLAB code for sleepDBConfirm.fig
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
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help sleepDBConfirm

% Last Modified by GUIDE v2.5 15-Aug-2016 02:51:41

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @sleepDBConfirm_OpeningFcn, ...
    'gui_OutputFcn',  @sleepDBConfirm_OutputFcn, ...
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


% --- Executes just before sleepDBConfirm is made visible.
function sleepDBConfirm_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to sleepDBConfirm (see VARARGIN)

% Choose default command line output for sleepDBConfirm
handles.output = hObject;

% Set up confirmation info
if size(varargin, 2) == 2
    
    handles.conn = varargin{1};
    handles.input = varargin{2};
    
    % Load SleepStats
    load([handles.input.pathName,'/',handles.input.fileIN.String,'/',handles.input.fileIN.String,'_stats.mat']);
    handles.stageStats = stageStats;
    % Set Record Name
    set(handles.recordName, 'String', handles.input.fileIN.String);
    
    % Strip ID and Scorer
    [scorer_id, cond] = strtok(handles.input.fileIN.String,'_');
    id = scorer_id(isstrprop(scorer_id,'digit'));
    scorer = scorer_id(isstrprop(scorer_id,'alpha'));
    
    set(handles.id,'String',id);
    set(handles.scorer,'String',scorer);
    set(handles.condition,'String',cond(2:end));
    
    studies = sortrows(fetch(handles.conn, 'SELECT study FROM SleepLabStats.studies;'));
    set(handles.studyName,'String',{'Study',studies{:}});
    
    % Check ID in system
    if  ~isempty(fetch(handles.conn,['SELECT 1 FROM SleepLabStats.idStudy WHERE id = ',id,';']))
        
        set(handles.studyName,'Value',find(ismember(handles.studyName.String, fetch(handles.conn, ['SELECT study FROM SleepLabStats.idStudy WHERE id = ',id,';']))));
    else
        set(handles.studyName,'Value',1);
    end
    
    % If EDFNAME in Notes
    if isfield(handles.stageStats.stageData,'EDFname')
        set(handles.edfName,'String',handles.stageStats.stageData.EDFname);
    elseif ~isempty(handles.stageStats.stageData.Notes)
        
        FileStr=strsplit(handles.stageStats.stageData.Notes(find(~cellfun('isempty',regexp(cellstr(handles.stageStats.stageData.Notes),'File name'))),:));
        set(handles.edfName,'String',FileStr{3});
    end
    
end

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes sleepDBConfirm wait for user response (see UIRESUME)
% uiwait(handles.gui);


% --- Outputs from this function are returned to the command line.
function varargout = sleepDBConfirm_OutputFcn(hObject, eventdata, handles)
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
if  ~isempty(fetch(handles.conn,['SELECT 1 FROM SleepLabStats.scoredinfo WHERE record = ''',handles.recordName.String,''';']))
    
    button = questdlg(['Record:''', handles.recordName.String,''' already exists in server. Replace?'],'Duplicate Record Found','Replace','Cancel','Cancel');
    if strmatch(button,'Cancel')
        return;
    elseif strmatch(button,'Replace')
        
        % Confirm Record and EDF Match
        
        % Confirm EDF and ID Match
        IDonRecord=fetch(handles.conn,['SELECT id FROM SleepLabStats.edfinfo WHERE edfname = ''',handles.edfName.String,''';']);
        if ~strcmpi(handles.id.String,num2str(IDonRecord{1}))
            
            msgbox(['The entered ID: ''',handles.id.String,''' does not match ID on record for ''', handles.edfName.String, ''': ''', num2str(IDonRecord{1}),'.'' Confirm!']);
            return;
        end
        
        % Confirm ID and Study Match
        studyOnRecord=fetch(handles.conn,['SELECT study FROM SleepLabStats.idStudy WHERE id = ''',handles.id.String,''';']);
        if ~strcmpi(handles.studyName.String{handles.studyName.Value},studyOnRecord{1})
            
            msgbox(['The entered study: ''',handles.studyName.String{handles.studyName.Value},''' does not match study on record for ''', handles.id.String, ''': ''', studyOnRecord{1},'.'' Confirm!']);
            return;
        end
        
        % Check if previous record was final and if you want to overwrite
        % it.
        finalStatus = cell2mat(fetch(handles.conn,['SELECT finalscores FROM SleepLabStats.scoredinfo WHERE record = ''', handles.recordName.String,''';']));
        if finalStatus == 1
            
            button = questdlg(['The previous record was labeled ''Final Data,'' are you sure you want to replace?'],'Overwrite Final Scores?','Replace','Cancel','Cancel');
            if strmatch(button,'Cancel')
                return;
            end
        end
        
        % Proceed with overwriting:
        update(handles.conn, 'SleepLabStats.scoredinfo', {'finalscores','uploadedby','datemodified'}, {handles.finalData.Value,handles.conn.UserName,datestr(clock,'yyyy-mm-dd HH:MM:SS')}, ['where record =''',handles.recordName.String,'''']);
        
        update(handles.conn, 'SleepLabStats.TDT', {'epochs','Minutes','TDTper','SPTper','TSTper'}, [num2cell(handles.stageStats.percentSleep(1,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'SleepLabStats.SPT', {'epochs','Minutes','TDTper','SPTper','TSTper'}, [num2cell(handles.stageStats.percentSleep(2,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'SleepLabStats.TST', {'epochs','Minutes','TDTper','SPTper','TSTper'}, [num2cell(handles.stageStats.percentSleep(3,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'SleepLabStats.SBSO', {'epochs','Minutes','TDTper','SPTper','TSTper'}, [num2cell(handles.stageStats.percentSleep(4,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'SleepLabStats.WASO', {'epochs','Minutes','TDTper','SPTper','TSTper'}, [num2cell(handles.stageStats.percentSleep(5,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'SleepLabStats.WAFA', {'epochs','Minutes','TDTper','SPTper','TSTper'}, [num2cell(handles.stageStats.percentSleep(6,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'SleepLabStats.SAFA', {'epochs','Minutes','TDTper','SPTper','TSTper'}, [num2cell(handles.stageStats.percentSleep(7,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'SleepLabStats.TWT', {'epochs','Minutes','TDTper','SPTper','TSTper'}, [num2cell(handles.stageStats.percentSleep(8,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'SleepLabStats.Stage1', {'epochs','Minutes','TDTper','SPTper','TSTper'}, [num2cell(handles.stageStats.percentSleep(9,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'SleepLabStats.Stage2', {'epochs','Minutes','TDTper','SPTper','TSTper'}, [num2cell(handles.stageStats.percentSleep(10,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'SleepLabStats.Stage3', {'epochs','Minutes','TDTper','SPTper','TSTper'}, [num2cell(handles.stageStats.percentSleep(11,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'SleepLabStats.Stage4', {'epochs','Minutes','TDTper','SPTper','TSTper'}, [num2cell(handles.stageStats.percentSleep(12,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'SleepLabStats.REM', {'epochs','Minutes','TDTper','SPTper','TSTper'}, [num2cell(handles.stageStats.percentSleep(13,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'SleepLabStats.MT', {'epochs','Minutes','TDTper','SPTper','TSTper'}, [num2cell(handles.stageStats.percentSleep(14,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'SleepLabStats.NREM', {'epochs','Minutes','TDTper','SPTper','TSTper'}, [num2cell(handles.stageStats.percentSleep(15,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'SleepLabStats.SW', {'epochs','Minutes','TDTper','SPTper','TSTper'}, [num2cell(handles.stageStats.percentSleep(16,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'SleepLabStats.ANOM', {'epochs','Minutes','TDTper','SPTper','TSTper'}, [num2cell(handles.stageStats.percentSleep(17,:))], ['where record =''',handles.recordName.String,'''']);
        
        update(handles.conn, 'SleepLabStats.latencySleep', {'epochs','Minutes'}, [num2cell(handles.stageStats.SleepLat(1,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'SleepLabStats.latency10min', {'epochs','Minutes'}, [num2cell(handles.stageStats.SleepLat(2,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'SleepLabStats.latencyLOS1', {'epochs','Minutes'}, [num2cell(handles.stageStats.SleepLat(3,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'SleepLabStats.latencyLOS2', {'epochs','Minutes'}, [num2cell(handles.stageStats.SleepLat(4,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'SleepLabStats.latencyLOS3', {'epochs','Minutes'}, [num2cell(handles.stageStats.SleepLat(5,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'SleepLabStats.latencyLOS4', {'epochs','Minutes'}, [num2cell(handles.stageStats.SleepLat(6,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'SleepLabStats.latencyLOSW', {'epochs','Minutes'}, [num2cell(handles.stageStats.SleepLat(7,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'SleepLabStats.latencyLOREM', {'epochs','Minutes'}, [num2cell(handles.stageStats.SleepLat(8,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'SleepLabStats.latencySOS1', {'epochs','Minutes'}, [num2cell(handles.stageStats.SleepLat(10,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'SleepLabStats.latencySOS2', {'epochs','Minutes'}, [num2cell(handles.stageStats.SleepLat(11,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'SleepLabStats.latencySOS3', {'epochs','Minutes'}, [num2cell(handles.stageStats.SleepLat(12,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'SleepLabStats.latencySOS4', {'epochs','Minutes'}, [num2cell(handles.stageStats.SleepLat(13,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'SleepLabStats.latencySOSW', {'epochs','Minutes'}, [num2cell(handles.stageStats.SleepLat(14,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'SleepLabStats.latencySOREM', {'epochs','Minutes'}, [num2cell(handles.stageStats.SleepLat(15,:))], ['where record =''',handles.recordName.String,'''']);
        
        update(handles.conn, 'SleepLabStats.QuarterWake', {'Q1','Q2','Q3','Q4'}, [num2cell(handles.stageStats.split4(1,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'SleepLabStats.QuarterS1', {'Q1','Q2','Q3','Q4'}, [num2cell(handles.stageStats.split4(2,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'SleepLabStats.QuarterS2', {'Q1','Q2','Q3','Q4'}, [num2cell(handles.stageStats.split4(3,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'SleepLabStats.QuarterS3', {'Q1','Q2','Q3','Q4'}, [num2cell(handles.stageStats.split4(4,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'SleepLabStats.QuarterS4', {'Q1','Q2','Q3','Q4'}, [num2cell(handles.stageStats.split4(5,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'SleepLabStats.QuarterREM', {'Q1','Q2','Q3','Q4'}, [num2cell(handles.stageStats.split4(6,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'SleepLabStats.QuarterMT', {'Q1','Q2','Q3','Q4'}, [num2cell(handles.stageStats.split4(7,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'SleepLabStats.QuarterSW', {'Q1','Q2','Q3','Q4'}, [num2cell(handles.stageStats.split4(8,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'SleepLabStats.QuarterTotal', {'Q1','Q2','Q3','Q4'}, [num2cell(handles.stageStats.split4(9,:))], ['where record =''',handles.recordName.String,'''']);
        
        update(handles.conn, 'SleepLabStats.ThirdWake', {'T1','T2','T3'}, [num2cell(handles.stageStats.split3(1,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'SleepLabStats.ThirdS1', {'T1','T2','T3'}, [num2cell(handles.stageStats.split3(2,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'SleepLabStats.ThirdS2', {'T1','T2','T3'}, [num2cell(handles.stageStats.split3(3,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'SleepLabStats.ThirdS3', {'T1','T2','T3'}, [num2cell(handles.stageStats.split3(4,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'SleepLabStats.ThirdS4', {'T1','T2','T3'}, [num2cell(handles.stageStats.split3(5,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'SleepLabStats.ThirdREM', {'T1','T2','T3'}, [num2cell(handles.stageStats.split3(6,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'SleepLabStats.ThirdMT', {'T1','T2','T3'}, [num2cell(handles.stageStats.split3(7,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'SleepLabStats.ThirdSW', {'T1','T2','T3'}, [num2cell(handles.stageStats.split3(8,:))], ['where record =''',handles.recordName.String,'''']);
        update(handles.conn, 'SleepLabStats.ThirdTotal', {'T1','T2','T3'}, [num2cell(handles.stageStats.split3(9,:))], ['where record =''',handles.recordName.String,'''']);
    end
    
else
    
    % See if id exists
    if ~isempty(fetch(handles.conn,['SELECT 1 FROM SleepLabStats.idStudy WHERE id = ''',handles.id.String,''';']));
        
        % Error if inputted ID and Study don't match database.
        studyOnRecord=fetch(handles.conn,['SELECT study FROM SleepLabStats.idStudy WHERE id = ''',handles.id.String,''';']);
        if ~strcmpi(handles.studyName.String{handles.studyName.Value},studyOnRecord{1})
            
            msgbox(['The entered study: ''',handles.studyName.String{handles.studyName.Value},''' does not match study on record for ''', handles.id.String, ''': ''', studyOnRecord{1},'.'' Confirm!']);
            return;
        end
    else
        % Insert ID and Study
        insert(handles.conn, 'SleepLabStats.idStudy', {'id','study'}, [{str2num(handles.id.String), ...
            handles.studyName.String{handles.studyName.Value}}]);
    end
    
    % See if EDF has previously been entered, i.e., first record from this EDF?
    if  isempty(fetch(handles.conn,['SELECT 1 FROM SleepLabStats.edfInfo WHERE edfname = ''',handles.edfName.String,''';']))
        % No EDF: Enter information provided
        insert(handles.conn, 'SleepLabStats.edfinfo', {'edfname','id','condition'}, [{handles.edfName.String, ...
            str2num(handles.id.String), ...
            handles.condition.String}]);
    else
        
        % Confirm this EDF belongs to this condition and ID
        edfOnrecord=fetch(handles.conn,['SELECT condition FROM SleepLabStats.edfInfo WHERE edfname = ''',handles.edfName.String,''';']);
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
        
        
        if sum(cell2mat(fetch(handles.conn,['SELECT finalscores FROM SleepLabStats.scoredinfo WHERE edfname = ''FCCBABSL.EDF'';']))) == 1
            
            recordOnRecord=fetch(handles.conn,['SELECT record FROM SleepLabStats.scoredinfo WHERE edfname = ''',handles.edfName.String,''' AND finalscores = 1;']);
            
            % Previous final data
            button = questdlg(['Previous final data for EDF: ''', handles.edfName.String,''' exists: ''', recordOnRecord{1}, '.'' Replace with current record?'],'Pre-existing Record Found','Replace','Cancel','Cancel');
            if strmatch(button,'Cancel')
                return;
            elseif strmatch(button,'Replace')
                
                % Remove final record from previous record.
                update(handles.conn, 'SleepLabStats.scoredinfo', {'finalscores'}, {'FALSE'}, ['where record = ''',recordOnRecord{1},'''']);
                
            end
        end
    end

        insert(handles.conn, 'SleepLabStats.scoredInfo', {'record','edfname','scorer','finalscores','uploadedby','datemodified'},[{handles.recordName.String,handles.edfName.String,handles.scorer.String,handles.finalData.Value,handles.conn.UserName,datestr(clock,'yyyy-mm-dd HH:MM:SS')}]);

    % Enter Statistics
    insert(handles.conn, 'SleepLabStats.TDT', {'record','epochs','Minutes','TDTper','SPTper','TSTper'}, [{handles.recordName.String},num2cell(handles.stageStats.percentSleep(1,:))]);
    insert(handles.conn, 'SleepLabStats.SPT', {'record','epochs','Minutes','TDTper','SPTper','TSTper'}, [{handles.recordName.String},num2cell(handles.stageStats.percentSleep(2,:))]);
    insert(handles.conn, 'SleepLabStats.TST', {'record','epochs','Minutes','TDTper','SPTper','TSTper'}, [{handles.recordName.String},num2cell(handles.stageStats.percentSleep(3,:))]);
    insert(handles.conn, 'SleepLabStats.SBSO', {'record','epochs','Minutes','TDTper','SPTper','TSTper'}, [{handles.recordName.String},num2cell(handles.stageStats.percentSleep(4,:))]);
    insert(handles.conn, 'SleepLabStats.WASO', {'record','epochs','Minutes','TDTper','SPTper','TSTper'}, [{handles.recordName.String},num2cell(handles.stageStats.percentSleep(5,:))]);
    insert(handles.conn, 'SleepLabStats.WAFA', {'record','epochs','Minutes','TDTper','SPTper','TSTper'}, [{handles.recordName.String},num2cell(handles.stageStats.percentSleep(6,:))]);
    insert(handles.conn, 'SleepLabStats.SAFA', {'record','epochs','Minutes','TDTper','SPTper','TSTper'}, [{handles.recordName.String},num2cell(handles.stageStats.percentSleep(7,:))]);
    insert(handles.conn, 'SleepLabStats.TWT', {'record','epochs','Minutes','TDTper','SPTper','TSTper'}, [{handles.recordName.String},num2cell(handles.stageStats.percentSleep(8,:))]);
    insert(handles.conn, 'SleepLabStats.Stage1', {'record','epochs','Minutes','TDTper','SPTper','TSTper'}, [{handles.recordName.String},num2cell(handles.stageStats.percentSleep(9,:))]);
    insert(handles.conn, 'SleepLabStats.Stage2', {'record','epochs','Minutes','TDTper','SPTper','TSTper'}, [{handles.recordName.String},num2cell(handles.stageStats.percentSleep(10,:))]);
    insert(handles.conn, 'SleepLabStats.Stage3', {'record','epochs','Minutes','TDTper','SPTper','TSTper'}, [{handles.recordName.String},num2cell(handles.stageStats.percentSleep(11,:))]);
    insert(handles.conn, 'SleepLabStats.Stage4', {'record','epochs','Minutes','TDTper','SPTper','TSTper'}, [{handles.recordName.String},num2cell(handles.stageStats.percentSleep(12,:))]);
    insert(handles.conn, 'SleepLabStats.REM', {'record','epochs','Minutes','TDTper','SPTper','TSTper'}, [{handles.recordName.String},num2cell(handles.stageStats.percentSleep(13,:))]);
    insert(handles.conn, 'SleepLabStats.MT', {'record','epochs','Minutes','TDTper','SPTper','TSTper'}, [{handles.recordName.String},num2cell(handles.stageStats.percentSleep(14,:))]);
    insert(handles.conn, 'SleepLabStats.NREM', {'record','epochs','Minutes','TDTper','SPTper','TSTper'}, [{handles.recordName.String},num2cell(handles.stageStats.percentSleep(15,:))]);
    insert(handles.conn, 'SleepLabStats.SW', {'record','epochs','Minutes','TDTper','SPTper','TSTper'}, [{handles.recordName.String},num2cell(handles.stageStats.percentSleep(16,:))]);
    insert(handles.conn, 'SleepLabStats.ANOM', {'record','epochs','Minutes','TDTper','SPTper','TSTper'}, [{handles.recordName.String},num2cell(handles.stageStats.percentSleep(17,:))]);
    
    insert(handles.conn, 'SleepLabStats.latencySleep', {'record','epochs','Minutes'}, [{handles.recordName.String},num2cell(handles.stageStats.SleepLat(1,:))]);
    insert(handles.conn, 'SleepLabStats.latency10min', {'record','epochs','Minutes'}, [{handles.recordName.String},num2cell(handles.stageStats.SleepLat(2,:))]);
    insert(handles.conn, 'SleepLabStats.latencyLOS1', {'record','epochs','Minutes'}, [{handles.recordName.String},num2cell(handles.stageStats.SleepLat(3,:))]);
    insert(handles.conn, 'SleepLabStats.latencyLOS2', {'record','epochs','Minutes'}, [{handles.recordName.String},num2cell(handles.stageStats.SleepLat(4,:))]);
    insert(handles.conn, 'SleepLabStats.latencyLOS3', {'record','epochs','Minutes'}, [{handles.recordName.String},num2cell(handles.stageStats.SleepLat(5,:))]);
    insert(handles.conn, 'SleepLabStats.latencyLOS4', {'record','epochs','Minutes'}, [{handles.recordName.String},num2cell(handles.stageStats.SleepLat(6,:))]);
    insert(handles.conn, 'SleepLabStats.latencyLOSW', {'record','epochs','Minutes'}, [{handles.recordName.String},num2cell(handles.stageStats.SleepLat(7,:))]);
    insert(handles.conn, 'SleepLabStats.latencyLOREM', {'record','epochs','Minutes'}, [{handles.recordName.String},num2cell(handles.stageStats.SleepLat(8,:))]);
    insert(handles.conn, 'SleepLabStats.latencySOS1', {'record','epochs','Minutes'}, [{handles.recordName.String},num2cell(handles.stageStats.SleepLat(10,:))]);
    insert(handles.conn, 'SleepLabStats.latencySOS2', {'record','epochs','Minutes'}, [{handles.recordName.String},num2cell(handles.stageStats.SleepLat(11,:))]);
    insert(handles.conn, 'SleepLabStats.latencySOS3', {'record','epochs','Minutes'}, [{handles.recordName.String},num2cell(handles.stageStats.SleepLat(12,:))]);
    insert(handles.conn, 'SleepLabStats.latencySOS4', {'record','epochs','Minutes'}, [{handles.recordName.String},num2cell(handles.stageStats.SleepLat(13,:))]);
    insert(handles.conn, 'SleepLabStats.latencySOSW', {'record','epochs','Minutes'}, [{handles.recordName.String},num2cell(handles.stageStats.SleepLat(14,:))]);
    insert(handles.conn, 'SleepLabStats.latencySOREM', {'record','epochs','Minutes'}, [{handles.recordName.String},num2cell(handles.stageStats.SleepLat(15,:))]);
    
    insert(handles.conn, 'SleepLabStats.QuarterWake', {'record','Q1','Q2','Q3','Q4'}, [{handles.recordName.String},num2cell(handles.stageStats.split4(1,:))]);
    insert(handles.conn, 'SleepLabStats.QuarterS1', {'record','Q1','Q2','Q3','Q4'}, [{handles.recordName.String},num2cell(handles.stageStats.split4(2,:))]);
    insert(handles.conn, 'SleepLabStats.QuarterS2', {'record','Q1','Q2','Q3','Q4'}, [{handles.recordName.String},num2cell(handles.stageStats.split4(3,:))]);
    insert(handles.conn, 'SleepLabStats.QuarterS3', {'record','Q1','Q2','Q3','Q4'}, [{handles.recordName.String},num2cell(handles.stageStats.split4(4,:))]);
    insert(handles.conn, 'SleepLabStats.QuarterS4', {'record','Q1','Q2','Q3','Q4'}, [{handles.recordName.String},num2cell(handles.stageStats.split4(5,:))]);
    insert(handles.conn, 'SleepLabStats.QuarterREM', {'record','Q1','Q2','Q3','Q4'}, [{handles.recordName.String},num2cell(handles.stageStats.split4(6,:))]);
    insert(handles.conn, 'SleepLabStats.QuarterMT', {'record','Q1','Q2','Q3','Q4'}, [{handles.recordName.String},num2cell(handles.stageStats.split4(7,:))]);
    insert(handles.conn, 'SleepLabStats.QuarterSW', {'record','Q1','Q2','Q3','Q4'}, [{handles.recordName.String},num2cell(handles.stageStats.split4(8,:))]);
    insert(handles.conn, 'SleepLabStats.QuarterTotal', {'record','Q1','Q2','Q3','Q4'}, [{handles.recordName.String},num2cell(handles.stageStats.split4(9,:))]);
    
    insert(handles.conn, 'SleepLabStats.ThirdWake', {'record','T1','T2','T3'}, [{handles.recordName.String},num2cell(handles.stageStats.split3(1,:))]);
    insert(handles.conn, 'SleepLabStats.ThirdS1', {'record','T1','T2','T3'}, [{handles.recordName.String},num2cell(handles.stageStats.split3(2,:))]);
    insert(handles.conn, 'SleepLabStats.ThirdS2', {'record','T1','T2','T3'}, [{handles.recordName.String},num2cell(handles.stageStats.split3(3,:))]);
    insert(handles.conn, 'SleepLabStats.ThirdS3', {'record','T1','T2','T3'}, [{handles.recordName.String},num2cell(handles.stageStats.split3(4,:))]);
    insert(handles.conn, 'SleepLabStats.ThirdS4', {'record','T1','T2','T3'}, [{handles.recordName.String},num2cell(handles.stageStats.split3(5,:))]);
    insert(handles.conn, 'SleepLabStats.ThirdREM', {'record','T1','T2','T3'}, [{handles.recordName.String},num2cell(handles.stageStats.split3(6,:))]);
    insert(handles.conn, 'SleepLabStats.ThirdMT', {'record','T1','T2','T3'}, [{handles.recordName.String},num2cell(handles.stageStats.split3(7,:))]);
    insert(handles.conn, 'SleepLabStats.ThirdSW', {'record','T1','T2','T3'}, [{handles.recordName.String},num2cell(handles.stageStats.split3(8,:))]);
    insert(handles.conn, 'SleepLabStats.ThirdTotal', {'record','T1','T2','T3'}, [{handles.recordName.String},num2cell(handles.stageStats.split3(9,:))]);
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
handles.pathName = folder;
guidata(hObject,handles);

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
