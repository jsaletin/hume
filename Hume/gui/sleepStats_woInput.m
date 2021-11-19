function varargout = sleepStats_woInput(varargin)
% SLEEPSTATS_WOINPUT MATLAB code for sleepStats_woInput.fig
%%   Copyright (c) 2015 Jared M. Saletin, PhD and Stephanie M. Greer, PhD
%
%   This file is part of H�m�.
%   
%   H�m� is free software: you can redistribute it and/or modify it
%   under the terms of the GNU General Public License as published by the
%   Free Software Foundation, either version 3 of the License, or (at your
%   option) any later version.
% 
%   H�m� is distributed in the hope that it will be useful, but
%   WITHOUT ANY WARRANTY; without even the implied warranty of
%   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
%   General Public License for more details.
% 
%   You should have received a copy of the GNU General Public License along
%   with H�m�.  If not, see <http://www.gnu.org/licenses/>.
%
%   H�m� is intended for research purposes only. Any commercial or medical
%   use of this software is prohibited. The authors accept no
%   responsibility for its use in this manner.
%%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help sleepStats_woInput

% Last Modified by GUIDE v2.5 06-Jul-2021 15:00:41

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @sleepStats_woInput_OpeningFcn, ...
                   'gui_OutputFcn',  @sleepStats_woInput_OutputFcn, ...
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


% --- Executes just before sleepStats_woInput is made visible.
function sleepStats_woInput_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to sleepStats_woInput (see VARARGIN)

% Choose default command line output for sleepStats_woInput
handles.output = hObject;

handles.onsetMode = 1;
handles.endMode = 1;
handles.combRule = 25;
handles.rempMIN = 0;
handles.endREM = 0;

if length(varargin)>1
    handles.stageData = varargin{1};
    handles.file = varargin{2}{1};

    [pathName, fileName] =fileparts(handles.file);
    set(handles.fileIN,'String',fileName);
    handles.pathName = pathName;
    handles.fileName = fileName;
end

handles.pickChSpect.String = {varargin{3}.chanlocs.labels};
handles.EEG = varargin{3};
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes sleepStats_woInput wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = sleepStats_woInput_OutputFcn(hObject, eventdata, handles) 
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
file = get(handles.fileIN, 'String');
onsetMode = handles.onsetMode;
remRules = [handles.combRule handles.rempMIN handles.endREM];
endMode = handles.endMode;

if sum(ismember({handles.EEG.chanlocs.labels},'SpO2'))>0
    SpO2 = handles.EEG.data(ismember({handles.EEG.chanlocs.labels},'SpO2'),:);
    stageStats = plotSleepStats_wOSat(handles.stageData,onsetMode,remRules,endMode,[],handles.skipREM.Value,handles.pathName,handles.fileName, SpO2, handles.EEG.srate);
else
    stageStats=plotSleepStats(handles.stageData,onsetMode,remRules,endMode,[],handles.skipREM.Value,handles.pathName,handles.fileName);
end

if handles.includeSpect.Value == 1
    
    % Run Spectrogram
    h0=spectrogramRpt_SingleCh(handles.EEG, handles.pickChSpect.String{handles.pickChSpect.Value}, stageStats);
    % Save
    saveas(h0, [handles.pathName, '/', handles.fileName,'/',handles.fileName, '_', handles.pickChSpect.String{handles.pickChSpect.Value}, '_Spectrogram.png'], 'png');
    % Append to HTML output
    close(h0);
    fid = fopen([handles.pathName, '/', handles.fileName,'/',handles.fileName, '.html'], 'A');  
    report = [sprintf('<hr><P style="page-break-before: always"><h1>Sleep Spectrogram Report:</h1><img src=''%s'' style="width: 95%%; height: 95%%"/>', [handles.pathName, '/', handles.fileName,'/',handles.fileName, '_', handles.pickChSpect.String{handles.pickChSpect.Value}, '_Spectrogram.png'])];
    fwrite(fid, report);
    fclose(fid);
    web([handles.pathName, '/', handles.fileName,'/',handles.fileName, '.html']);
    
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
[folderName pathName] = uiputfile({'*.*',  'All Files (*.*)'},'Output Directory','stageStats');
set(handles.fileIN, 'String', folderName);
handles.pathName = pathName;
handles.fileName = folderName;
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


% --- Executes on button press in includeSpect.
function includeSpect_Callback(hObject, eventdata, handles)
% hObject    handle to includeSpect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of includeSpect


% --- Executes on selection change in pickChSpect.
function pickChSpect_Callback(hObject, eventdata, handles)
% hObject    handle to pickChSpect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pickChSpect contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pickChSpect


% --- Executes during object creation, after setting all properties.
function pickChSpect_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pickChSpect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in skipREM.
function skipREM_Callback(hObject, eventdata, handles)
% hObject    handle to skipREM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of skipREM
