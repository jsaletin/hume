function varargout = sleepStatsDBReport(varargin)
% SLEEPSTATSDBREPORT MATLAB code for sleepStatsDBReport.fig
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
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help sleepStatsDBReport

% Last Modified by GUIDE v2.5 23-Aug-2016 13:02:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @sleepStatsDBReport_OpeningFcn, ...
    'gui_OutputFcn',  @sleepStatsDBReport_OutputFcn, ...
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


% --- Executes just before sleepStatsDBReport is made visible.
function sleepStatsDBReport_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to sleepStatsDBReport (see VARARGIN)

% Choose default command line output for sleepStatsDBReport
handles.output = hObject;

if size(varargin, 2) == 2
    
    handles.conn = varargin{1};
    
    studiesOnRecord = fetch(handles.conn,['SELECT DISTINCT SleepLabStats.idStudy.study FROM SleepLabStats.EDFInfo JOIN SleepLabStats.idStudy ON SleepLabStats.EDFInfo.id = SleepLabStats.idStudy.id JOIN SleepLabStats.scoredInfo ON SleepLabStats.scoredInfo.EDFname = SleepLabStats.EDFInfo.EDFname']);
    set(handles.studyList,'String',studiesOnRecord);
    
    %     idsOnRecord = fetch(handles.conn, ['SELECT DISTINCT SleepLabStats.EDFInfo.id FROM SleepLabStats.scoredInfo JOIN SleepLabStats.EDFInfo ON SleepLabStats.scoredInfo.EDFname = SleepLabStats.EDFInfo.EDFname;']);
    %     set(handles.idList, 'String', [idsOnRecord{:}]);
    
end

% Populate Study List
humepath = which('hume');
reportpath = dir(fullfile(fileparts(humepath), 'coreFunctions/sqlReports'));
reports = {reportpath.name}'

for i = 3:length(reports)
    handles.reportFuncs{i-2} = reports{i}(1:end-2);
    repName{i-2} = eval(handles.reportFuncs{i-2});
end
set(handles.templates,'String',repName);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes sleepStatsDBReport wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = sleepStatsDBReport_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in idList.
function idList_Callback(hObject, eventdata, handles)
% hObject    handle to idList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns idList contents as cell array
%        contents{get(hObject,'Value')} returns selected item from idList


% --- Executes during object creation, after setting all properties.
function idList_CreateFcn(hObject, eventdata, handles)
% hObject    handle to idList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in studyList.
function studyList_Callback(hObject, eventdata, handles)
% hObject    handle to studyList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns studyList contents as cell array
%        contents{get(hObject,'Value')} returns selected item from studyList
studyList = hObject.String(hObject.Value);
if ~isempty(studyList)
    conditionsOnRecord = fetch(handles.conn,['SELECT DISTINCT SleepLabStats.EDFInfo.condition FROM SleepLabStats.scoredInfo JOIN SleepLabStats.EDFInfo ON SleepLabStats.scoredInfo.EDFname = SleepLabStats.EDFInfo.EDFname  JOIN SleepLabStats.idStudy ON SleepLabStats.EDFInfo.id = SleepLabStats.idStudy.id WHERE SleepLabStats.idStudy.study IN (', strjoin(strcat('''',studyList,''''),', '), ');']);
else
    conditionsOnRecord = '';
    set(handles.allConds', 'Value', 0);
    allConds_Callback(handles.allConds,[],handles);
end
set(handles.condList, 'String', conditionsOnRecord);
condList_Callback(handles.condList,[],handles);
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function studyList_CreateFcn(hObject, eventdata, handles)
% hObject    handle to studyList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in condList.
function condList_Callback(hObject, eventdata, handles)
% hObject    handle to condList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns condList contents as cell array
%        contents{get(hObject,'Value')} returns selected item from condList
if ~isempty(hObject.String)
    condList = hObject.String(hObject.Value);
    if ~isempty(condList)
        studyList = handles.studyList.String(handles.studyList.Value);
        idsOnRecord = fetch(handles.conn,['SELECT DISTINCT SleepLabStats.idStudy.id FROM SleepLabStats.scoredInfo JOIN SleepLabStats.EDFInfo ON SleepLabStats.scoredInfo.EDFname = SleepLabStats.EDFInfo.EDFname  JOIN SleepLabStats.idStudy ON SleepLabStats.EDFInfo.id = SleepLabStats.idStudy.id WHERE SleepLabStats.idStudy.study IN (', strjoin(strcat('''',studyList,''''),', '), ') AND SleepLabStats.EDFInfo.Condition IN (', strjoin(strcat('''',condList,''''),', '), ') ;']);
    else
        idsOnRecord = '';
        set(handles.allIDs', 'Value', 0);
        allIDs_Callback(handles.allConds,[],handles);
    end
else
    idsOnRecord = '';
    set(handles.allIDs', 'Value', 0);
    allIDs_Callback(handles.allConds,[],handles);
end

set(handles.idList, 'String', idsOnRecord);
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function condList_CreateFcn(hObject, eventdata, handles)
% hObject    handle to condList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in makeReport.
function makeReport_Callback(hObject, eventdata, handles)
% hObject    handle to makeReport (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get List of Records Needed
studyList = handles.studyList.String(handles.studyList.Value);
condList = handles.condList.String(handles.condList.Value);
idList = handles.idList.String(handles.idList.Value);

if ~isempty(studyList) & ~isempty(condList) & ~isempty(idList)
    recordList = fetch(handles.conn, ['SELECT record FROM SleepLabStats.scoredInfo ', ...
        'JOIN SleepLabStats.EDFInfo ', ...
        'ON SleepLabStats.EDFInfo.EDFName = SleepLabStats.scoredInfo.EDFName ', ...
        'JOIN SleepLabStats.idStudy ', ...
        'ON SleepLabStats.idStudy.id = SleepLabStats.EDFInfo.id ', ...
        'WHERE SleepLabStats.idStudy.id IN (',strjoin(strcat('''',idList,''''),', '), ') ', ...
        'AND SleepLabStats.EDFInfo.condition IN (',strjoin(strcat('''',condList,''''),', '), ') ', ...
        'AND SleepLabStats.idStudy.study IN (',strjoin(strcat('''',studyList,''''),', '), ') ', ....
        'AND SleepLabStats.scoredInfo.finalScores = ',num2str(handles.finalOnly.Value),';']);
    
    
    reportType = 1;
    eval(['[reportName, statistics] = ',handles.reportFuncs{handles.templates.Value},'(recordList);']);
    assignin('base','ReportTable', statistics)
    
    if handles.saveFile.Value == 1
        try
        [saveName,savePath] = uiputfile({'*.csv', 'Comma Separated Value file (*.csv)';'.xlsx', 'Excel 2007 and later (*.xlsx)';'.xls', 'Excel 2003 and earlier (*.xls)'}, 'Save report table as');
        writetable(statistics,[savePath,'/',saveName])
        catch
        end
    end
else
    msgbox('Please make study, condition, and ID selections.');
end



% --- Executes on button press in allStudies.
function allStudies_Callback(hObject, eventdata, handles)
% hObject    handle to allStudies (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of allStudies
if get(hObject, 'Value') == 1
    
    % Select All
    set(handles.studyList, 'Value', [1:1:size(handles.studyList.String,1)]);
    studyList_Callback(handles.studyList, [], handles);
    
elseif get(hObject, 'Value') == 0
    
    % Unselect All
    set(handles.studyList,'Value',[]);
    studyList_Callback(handles.studyList, [], handles);
end
guidata(hObject,handles)

% --- Executes on button press in allConds.
function allConds_Callback(hObject, eventdata, handles)
% hObject    handle to allConds (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of allConds
if get(hObject, 'Value') == 1
    
    % Select All
    set(handles.condList, 'Value', [1:1:size(handles.condList.String,1)]);
    condList_Callback(handles.condList, [], handles);
    
elseif get(hObject, 'Value') == 0
    
    % Unselect All
    set(handles.condList,'Value',[]);
    condList_Callback(handles.condList, [], handles);
end
guidata(hObject,handles)

% --- Executes on button press in allIDs.
function allIDs_Callback(hObject, eventdata, handles)
% hObject    handle to allIDs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of allIDs
if get(hObject, 'Value') == 1
    
    % Select All
    set(handles.idList, 'Value', [1:1:size(handles.idList.String,1)]);
    
elseif get(hObject, 'Value') == 0
    
    % Unselect All
    set(handles.idList,'value',[]);
end
guidata(hObject,handles)


% --- Executes on button press in finalOnly.
function finalOnly_Callback(hObject, eventdata, handles)
% hObject    handle to finalOnly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of finalOnly

function updateIDs(condList)
% Updates Condition List

% hObject    handle to finalOnly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% handles    structure with handles and user data (see GUIDATA)

studyList = handles.studyList.String(handles.studyList.Value);
if ~isempty(studyList)
    conditionsOnRecord = fetch(handles.conn,['SELECT DISTINCT SleepLabStats.EDFInfo.condition FROM SleepLabStats.scoredInfo JOIN SleepLabStats.EDFInfo ON SleepLabStats.scoredInfo.EDFname = SleepLabStats.EDFInfo.EDFname  JOIN SleepLabStats.idStudy ON SleepLabStats.EDFInfo.id = SleepLabStats.idStudy.id WHERE SleepLabStats.idStudy.study IN (', strjoin(strcat('''',studyList,''''),', '), ');']);
else
    conditionsOnRecord = '';
end
set(handles.condList, 'String', conditionsOnRecord);
guidata(gcf, handles);


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in saveFile.
function saveFile_Callback(hObject, eventdata, handles)
% hObject    handle to saveFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of saveFile


% --- Executes on selection change in templates.
function templates_Callback(hObject, eventdata, handles)
% hObject    handle to templates (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns templates contents as cell array
%        contents{get(hObject,'Value')} returns selected item from templates


% --- Executes during object creation, after setting all properties.
function templates_CreateFcn(hObject, eventdata, handles)
% hObject    handle to templates (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
