function varargout = sleepStats(varargin)
% SLEEPSTATS MATLAB code for sleepStats.fig
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

% Edit the above text to modify the response to help sleepStats

% Last Modified by GUIDE v2.5 09-Jan-2015 14:03:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @sleepStats_OpeningFcn, ...
                   'gui_OutputFcn',  @sleepStats_OutputFcn, ...
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


% --- Executes just before sleepStats is made visible.
function sleepStats_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to sleepStats (see VARARGIN)

% Choose default command line output for sleepStats
handles.output = hObject;

% Setup FileTypes
sleepPath = which('sleepSMG');
fileTypes = dir([fullfile(fileparts(sleepPath), 'importFunctions'),'/*.m']);
type=get(handles.fileType, 'String');
handles.extList = {'.mat'};
handles.importList = {[]};

if length(fileTypes)>=1
    for i = 1:length(fileTypes)
        eval(['[scorer id cond outname outfile fileInfo{i}] = ',fileTypes(i).name(1:(end-2)),';']);
        type{i+2}=fileInfo{i}{1};
        handles.extList{i+1}=fileInfo{i}{2};
        handles.importList{i+1}=fileInfo{i}{3};
    end
set(handles.fileType,'String',type);
end
handles.onsetMode = 1;
handles.endMode = 1;
handles.combRule = 25;
handles.rempMIN = 0;
handles.endREM = 0;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes sleepStats wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = sleepStats_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function combRule_Callback(hObject, eventdata, handles)
% hObject    handle to combRule (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of combRule as text
%        str2double(get(hObject,'String')) returns contents of combRule as a double
handles.combRule = str2double(get(hObject,'String'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function combRule_CreateFcn(hObject, eventdata, handles)
% hObject    handle to combRule (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function rempMIN_Callback(hObject, eventdata, handles)
% hObject    handle to rempMIN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rempMIN as text
%        str2double(get(hObject,'String')) returns contents of rempMIN as a double
handles.rempMIN = str2double(get(hObject,'String'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function rempMIN_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rempMIN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in endREMP.
function endREMP_Callback(hObject, eventdata, handles)
% hObject    handle to endREMP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns endREMP contents as cell array
%        contents{get(hObject,'Value')} returns selected item from endREMP
items = get(hObject,'String');
index_selected = get(hObject,'Value');
item_selected = items{index_selected};
handles.endREM = index_selected - 1;
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function endREMP_CreateFcn(hObject, eventdata, handles)
% hObject    handle to endREMP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in runStats.
function runStats_Callback(hObject, eventdata, handles)
% hObject    handle to runStats (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
file = [handles.pathName,'/',get(handles.fileIN, 'String')];
onsetMode = handles.onsetMode;
remRules = [handles.combRule handles.rempMIN handles.endREM];
endMode = handles.endMode;

if  handles.extValue ~= get(handles.fileType,'Value')-1
    
    errordlg('File Mismatch: File extension and specified type do not match, please check settings','Wrong File Type');
else
plotSleepStats(file,onsetMode,remRules,endMode,handles.importList{get(handles.fileType,'Value')-1});
end


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

formats = get(handles.fileType,'String');
for i=2:length(formats)
    fileListings{i-1,1} = ['*',handles.extList{i-1}];
    fileListings{i-1,2} = formats{i};
end

[fileName, pathName] = uigetfile([fileListings; {'*.*',  'All Files (*.*)'}], 'Sleep Data File');
set(handles.fileIN, 'String', fileName);
[path, file, ext] = fileparts(fileName); 
handles.extValue=find(ismember(handles.extList,ext));
set(handles.fileType,'Value',handles.extValue+1);
fileType_Callback(hObject, eventdata, handles);
handles.pathName = pathName;
guidata(hObject,handles);


% --- Executes when selected object is changed in sleepLatRules.
function sleepLatRules_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in sleepLatRules 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
newButton=get(eventdata.NewValue,'tag');
switch newButton
     case 'threeEpOnset'
        handles.onsetMode = 1;
    case 'firstEpOnset'
        handles.onsetMode = 2;
    case 'st2Onset'
        handles.onsetMode = 3;
    case 'tenMinOnset'
        handles.onsetMode = 4;
end
guidata(hObject,handles);


% --- Executes when selected object is changed in sleepEndRules.
function sleepEndRules_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in sleepEndRules 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
newButton=get(eventdata.NewValue,'tag');
switch newButton
     case 'endSlpOnset'
        handles.endMode = 1;
    case 'endSlpFinal'
        handles.endMode = 2;
end
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function endSlpOnset_CreateFcn(hObject, eventdata, handles)
% hObject    handle to endSlpOnset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on selection change in fileType.
function fileType_Callback(hObject, eventdata, handles)
% hObject    handle to fileType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns fileType contents as cell array
%        contents{get(hObject,'Value')} returns selected item from fileType

% --- Executes during object creation, after setting all properties.
function fileType_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fileType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
