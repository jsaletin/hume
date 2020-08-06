function varargout = sleepOscillationReport(varargin)
%%   Copyright (c) 2020 Jared M. Saletin, PhD and Stephanie M. Greer, PhD
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

% Edit the above text to modify the response to help sleepOscillationReport

% Last Modified by GUIDE v2.5 20-Jul-2020 16:35:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @sleepOscillationReport_OpeningFcn, ...
                   'gui_OutputFcn',  @sleepOscillationReport_OutputFcn, ...
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

% --- Executes just before sleepOscillationReport is made visible.
function sleepOscillationReport_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to sleepOscillationReport (see VARARGIN)

% Choose default command line output for sleepOscillationReport
handles.output = hObject;
handles.rectEvents = varargin{1};

% Get unique events
EventTypes = unique([handles.rectEvents(:,5)]);

% Populate swevent list
set(handles.swEvent, 'String', EventTypes);
set(handles.spiEvent, 'String', EventTypes);

% Update handles structure
guidata(hObject, handles);

uiwait(handles.figure1);
% UIWAIT makes sleepOscillationReport wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = sleepOscillationReport_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

delete(handles.figure1);



% --- Executes during object creation, after setting all properties.
function swEvent_CreateFcn(hObject, eventdata, handles)
% hObject    handle to swEvent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function swEvent_Callback(hObject, eventdata, handles)
% hObject    handle to swEvent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of swEvent as text
%        str2double(get(hObject,'String')) returns contents of swEvent as a double

% --- Executes on button press in waveType.
function waveType_Callback(hObject, eventdata, handles)
% hObject    handle to waveType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in spi.
function spi_Callback(hObject, eventdata, handles)
% hObject    handle to spi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.spi.Value == 0
set(handles.spiEvent,'Enable', 'off');
else
    set(handles.spiEvent,'Enable', 'on');
end
% Hint: get(hObject,'Value') returns toggle state of spi


% --- Executes on selection change in spiEvent.
function spiEvent_Callback(hObject, eventdata, handles)
% hObject    handle to spiEvent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns spiEvent contents as cell array
%        contents{get(hObject,'Value')} returns selected item from spiEvent


% --- Executes during object creation, after setting all properties.
function spiEvent_CreateFcn(hObject, eventdata, handles)
% hObject    handle to spiEvent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in sw.
function sw_Callback(hObject, eventdata, handles)
% hObject    handle to sw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.sw.Value == 0
set(handles.swEvent,'Enable', 'off');
else
    set(handles.swEvent,'Enable', 'on');
end

% Hint: get(hObject,'Value') returns toggle state of sw


% --- Executes on button press in OK.
function OK_Callback(hObject, eventdata, handles)
% hObject    handle to OK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.spi.Value && handles.sw.Value
    %check if spi and SW come from same channel
    if strcmp( ...
            handles.rectEvents{min(find(strcmp([handles.rectEvents(:,5)], handles.spiEvent.String{handles.spiEvent.Value}))),1}, ...
            handles.rectEvents{min(find(strcmp([handles.rectEvents(:,5)], handles.swEvent.String{handles.swEvent.Value}))),1})
        
            out = ['out = SWSpiCoupling(handles.stageData, handles.EEG, ''', ...
                handles.rectEvents{min(find(strcmp([handles.rectEvents(:,5)], handles.spiEvent.String{handles.spiEvent.Value}))),1}, ''', ''' ...
                handles.spiEvent.String{handles.spiEvent.Value},''' , ''',handles.swEvent.String{handles.swEvent.Value},''');'];     
    end
elseif handles.spi.Value && ~handles.sw.Value
elseif ~handles.spi.Value && handles.sw.Value
end

handles.output = out;
guidata(hObject, handles); 

uiresume(handles.figure1);
