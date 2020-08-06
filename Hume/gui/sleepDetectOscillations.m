function varargout = sleepDetectOscillations(varargin)
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

% Edit the above text to modify the response to help sleepDetectOscillations

% Last Modified by GUIDE v2.5 15-Jul-2020 16:00:00

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @sleepDetectOscillations_OpeningFcn, ...
                   'gui_OutputFcn',  @sleepDetectOscillations_OutputFcn, ...
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

% --- Executes just before sleepDetectOscillations is made visible.
function sleepDetectOscillations_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to sleepDetectOscillations (see VARARGIN)

% Choose default command line output for sleepDetectOscillations
handles.output = hObject;

% Populate Channel list
set(handles.channel, 'String', {varargin{1}.labels});
% Update handles structure
guidata(hObject, handles);

uiwait(handles.figure1);
% UIWAIT makes sleepDetectOscillations wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = sleepDetectOscillations_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

delete(handles.figure1);



% --- Executes during object creation, after setting all properties.
function channel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to channel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function channel_Callback(hObject, eventdata, handles)
% hObject    handle to channel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of channel as text
%        str2double(get(hObject,'String')) returns contents of channel as a double

% --- Executes on button press in waveType.
function waveType_Callback(hObject, eventdata, handles)
% hObject    handle to waveType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of waveType
% --- Executes on button press in detect.
function detect_Callback(hObject, eventdata, handles, varargin)
% hObject    handle to detect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% spindles
if strcmp(handles.waveType.String{handles.waveType.Value}, 'Sleep Spindles')
    
        % Detect spindles
         answer = questdlg({['Spindles are to be detected from: ', handles.channel.String{handles.channel.Value}]},...
                'Confirm spindle detection?',...
                'Yes','No',[]);
            if strcmp(answer,'Yes')
                out.functionCall = ['detectSpindles(handles.stageData, handles.EEG, ''', handles.channel.String{handles.channel.Value}, ''');'];
                out.ch = handles.channel.String{handles.channel.Value};
                out.type = ['Sleep Spindle (Ferrarelli/Warby ',out.ch,')'];

            end
            
% slow waves
elseif strcmp(handles.waveType.String{handles.waveType.Value}, 'Slow Waves')
     % Detect spindles
         answer = questdlg({['Slow Waves are to be detected from: ', handles.channel.String{handles.channel.Value}]},...
                'Confirm Slow Wave detection?',...
                'Yes','No',[]);
            if strcmp(answer,'Yes')
                 out.functionCall = ['detectSW(handles.stageData, handles.EEG, ''', handles.channel.String{handles.channel.Value}, ''');'];
                 out.ch = handles.channel.String{handles.channel.Value};
                 out.type = ['Slow Wave (detected ',out.ch,')'];
                 
            end
end

handles.output = out;
guidata(hObject, handles); 

uiresume(handles.figure1);
