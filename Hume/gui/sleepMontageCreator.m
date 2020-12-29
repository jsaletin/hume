function varargout = sleepMontageCreator(varargin)
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

% Edit the above text to modify the response to help sleepMontageCreator

% Last Modified by GUIDE v2.5 22-Dec-2020 10:45:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @sleepMontageCreator_OpeningFcn, ...
                   'gui_OutputFcn',  @sleepMontageCreator_OutputFcn, ...
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


% --- Executes just before sleepMontageCreator is made visible.
function sleepMontageCreator_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to sleepMontageCreator (see VARARGIN)
% channelNames = {'Channel'};
% labels = {varargin{1}.EEG.chanlocs(:).labels}
% channelNames = {channelNames{1} labels{1:length(labels)}}';
% for ch=1:14
%     eval(['set(handles.channel',num2str(ch),',''String'',channelNames);']);
% end
% 
% electrodes = flipud(varargin{1}.electrodes);
% colors = flipud(varargin{1}.colors);
% gridChs = varargin{1}.scaleChans;
% grids = varargin{1}.grids;
% hideChs = varargin{1}.hideChans;
% 
% for e=1:length(electrodes)
%     
%     i = find(ismember(labels,electrodes{e}));
%     eval(['set(handles.channel',num2str(e),',''Value'',',num2str(i+1),');']);
%     eval(['set(handles.color',num2str(e),',''BackgroundColor'',[',num2str(colors{e}),']);']);
% 
% end
% 
% for e = 1:length(gridChs)
%     
%     i = find(ismember(electrodes,gridChs{e}));
%     eval(['set(handles.amp',num2str(i),',''Value'', 1);']);
% 
% end
% 
% for e = 1:length(hideChs)
%     
%     i = find(ismember(electrodes,hideChs{e}));
%     eval(['set(handles.hide',num2str(i),',''Value'', 1);']);
% 
% end

defaultGridMat = {
    '-75'   [0 .5 0]
    '-37.5'   [0 .5 0]
    '0'     [0 .5 0]
    '37.5'    [0 .5 0]
    '75'    [0 .5 0]};

for i = 1:14
    
    eval(['handles.gridMat',num2str(i),' = defaultGridMat;']);
    eval(['set(handles.scale',num2str(i),', ''Value'', 13);']);
    eval(['set(handles.amp',num2str(i),', ''Value'', 0);']);
     eval(['set(handles.color',num2str(i),', ''BackgroundColor'', [.925 .925 .925]);']);

end



% Choose default command line output for sleepMontageCreator
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes sleepMontageCreator wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = sleepMontageCreator_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in channel1.
function channel1_Callback(hObject, eventdata, handles)
% hObject    handle to channel1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns channel1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from channel1


% --- Executes during object creation, after setting all properties.
function channel1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to channel1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in color1.
function color1_Callback(hObject, eventdata, handles)
% hObject    handle to color1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns color1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from color1
c = uisetcolor;
set(hObject,'BackgroundColor',c);

% --- Executes during object creation, after setting all properties.
function color1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to color1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in amp1.
function amp1_Callback(hObject, eventdata, handles)
% hObject    handle to amp1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of amp1


% --- Executes on button press in hide1.
function hide1_Callback(hObject, eventdata, handles)
% hObject    handle to hide1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of hide1


% --- Executes on selection change in channel2.
function channel2_Callback(hObject, eventdata, handles)
% hObject    handle to channel2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns channel2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from channel2


% --- Executes during object creation, after setting all properties.
function channel2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to channel2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in channel3.
function channel3_Callback(hObject, eventdata, handles)
% hObject    handle to channel3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns channel3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from channel3


% --- Executes during object creation, after setting all properties.
function channel3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to channel3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in channel4.
function channel4_Callback(hObject, eventdata, handles)
% hObject    handle to channel4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns channel4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from channel4


% --- Executes during object creation, after setting all properties.
function channel4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to channel4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in channel5.
function channel5_Callback(hObject, eventdata, handles)
% hObject    handle to channel5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns channel5 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from channel5


% --- Executes during object creation, after setting all properties.
function channel5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to channel5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in channel6.
function channel6_Callback(hObject, eventdata, handles)
% hObject    handle to channel6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns channel6 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from channel6


% --- Executes during object creation, after setting all properties.
function channel6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to channel6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in channel7.
function channel7_Callback(hObject, eventdata, handles)
% hObject    handle to channel7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns channel7 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from channel7


% --- Executes during object creation, after setting all properties.
function channel7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to channel7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in channel8.
function channel8_Callback(hObject, eventdata, handles)
% hObject    handle to channel8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns channel8 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from channel8


% --- Executes during object creation, after setting all properties.
function channel8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to channel8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in channel9.
function channel9_Callback(hObject, eventdata, handles)
% hObject    handle to channel9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns channel9 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from channel9


% --- Executes during object creation, after setting all properties.
function channel9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to channel9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in channel10.
function channel10_Callback(hObject, eventdata, handles)
% hObject    handle to channel10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns channel10 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from channel10


% --- Executes during object creation, after setting all properties.
function channel10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to channel10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in channel11.
function channel11_Callback(hObject, eventdata, handles)
% hObject    handle to channel11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns channel11 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from channel11


% --- Executes during object creation, after setting all properties.
function channel11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to channel11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in channel12.
function channel12_Callback(hObject, eventdata, handles)
% hObject    handle to channel12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns channel12 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from channel12


% --- Executes during object creation, after setting all properties.
function channel12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to channel12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in channel13.
function channel13_Callback(hObject, eventdata, handles)
% hObject    handle to channel13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns channel13 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from channel13


% --- Executes during object creation, after setting all properties.
function channel13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to channel13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in channel14.
function channel14_Callback(hObject, eventdata, handles)
% hObject    handle to channel14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns channel14 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from channel14


% --- Executes during object creation, after setting all properties.
function channel14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to channel14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in color2.
function color2_Callback(hObject, eventdata, handles)
% hObject    handle to color2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns color2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from color2
c = uisetcolor;
set(hObject,'BackgroundColor',c);

% --- Executes during object creation, after setting all properties.
function color2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to color2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in color3.
function color3_Callback(hObject, eventdata, handles)
% hObject    handle to color3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns color3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from color3
c = uisetcolor;
set(hObject,'BackgroundColor',c);

% --- Executes during object creation, after setting all properties.
function color3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to color3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in color4.
function color4_Callback(hObject, eventdata, handles)
% hObject    handle to color4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns color4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from color4
c = uisetcolor;
set(hObject,'BackgroundColor',c);

% --- Executes during object creation, after setting all properties.
function color4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to color4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in color5.
function color5_Callback(hObject, eventdata, handles)
% hObject    handle to color5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns color5 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from color5
c = uisetcolor;
set(hObject,'BackgroundColor',c);

% --- Executes during object creation, after setting all properties.
function color5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to color5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in color6.
function color6_Callback(hObject, eventdata, handles)
% hObject    handle to color6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns color6 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from color6
c = uisetcolor;
set(hObject,'BackgroundColor',c);

% --- Executes during object creation, after setting all properties.
function color6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to color6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in color7.
function color7_Callback(hObject, eventdata, handles)
% hObject    handle to color7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns color7 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from color7
c = uisetcolor;
set(hObject,'BackgroundColor',c);

% --- Executes during object creation, after setting all properties.
function color7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to color7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in color8.
function color8_Callback(hObject, eventdata, handles)
% hObject    handle to color8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns color8 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from color8
c = uisetcolor;
set(hObject,'BackgroundColor',c);

% --- Executes during object creation, after setting all properties.
function color8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to color8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in color9.
function color9_Callback(hObject, eventdata, handles)
% hObject    handle to color9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns color9 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from color9
c = uisetcolor;
set(hObject,'BackgroundColor',c);

% --- Executes during object creation, after setting all properties.
function color9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to color9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.

% --- Executes on selection change in color10.
function color10_Callback(hObject, eventdata, handles)
% hObject    handle to color10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns color10 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from color10
c = uisetcolor;
set(hObject,'BackgroundColor',c);

% --- Executes during object creation, after setting all properties.
function color10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to color10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.

% --- Executes on selection change in color11.
function color11_Callback(hObject, eventdata, handles)
% hObject    handle to color11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns color11 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from color11
c = uisetcolor;
set(hObject,'BackgroundColor',c);

% --- Executes during object creation, after setting all properties.
function color11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to color11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.

% --- Executes on selection change in color13.
function color13_Callback(hObject, eventdata, handles)
% hObject    handle to color13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns color13 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from color13
c = uisetcolor;
set(hObject,'BackgroundColor',c);

% --- Executes during object creation, after setting all properties.
function color13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to color13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.

% --- Executes on selection change in color14.
function color14_Callback(hObject, eventdata, handles)
% hObject    handle to color14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns color14 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from color14
c = uisetcolor;
set(hObject,'BackgroundColor',c);

% --- Executes during object creation, after setting all properties.
function color14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to color14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.

% --- Executes on button press in amp2.
function amp2_Callback(hObject, eventdata, handles)
% hObject    handle to amp2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of amp2


% --- Executes on button press in amp3.
function amp3_Callback(hObject, eventdata, handles)
% hObject    handle to amp3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of amp3


% --- Executes on button press in amp4.
function amp4_Callback(hObject, eventdata, handles)
% hObject    handle to amp4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of amp4


% --- Executes on button press in amp5.
function amp5_Callback(hObject, eventdata, handles)
% hObject    handle to amp5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of amp5


% --- Executes on button press in amp6.
function amp6_Callback(hObject, eventdata, handles)
% hObject    handle to amp6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of amp6


% --- Executes on button press in amp7.
function amp7_Callback(hObject, eventdata, handles)
% hObject    handle to amp7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of amp7


% --- Executes on button press in amp8.
function amp8_Callback(hObject, eventdata, handles)
% hObject    handle to amp8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of amp8


% --- Executes on button press in amp9.
function amp9_Callback(hObject, eventdata, handles)
% hObject    handle to amp9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of amp9


% --- Executes on button press in amp10.
function amp10_Callback(hObject, eventdata, handles)
% hObject    handle to amp10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of amp10


% --- Executes on button press in amp11.
function amp11_Callback(hObject, eventdata, handles)
% hObject    handle to amp11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of amp11


% --- Executes on button press in amp12.
function amp12_Callback(hObject, eventdata, handles)
% hObject    handle to amp12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of amp12


% --- Executes on button press in amp13.
function amp13_Callback(hObject, eventdata, handles)
% hObject    handle to amp13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of amp13


% --- Executes on button press in amp14.
function amp14_Callback(hObject, eventdata, handles)
% hObject    handle to amp14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of amp14


% --- Executes on button press in hide2.
function hide2_Callback(hObject, eventdata, handles)
% hObject    handle to hide2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of hide2


% --- Executes on button press in hide4.
function hide4_Callback(hObject, eventdata, handles)
% hObject    handle to hide4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of hide4


% --- Executes on button press in hide5.
function hide5_Callback(hObject, eventdata, handles)
% hObject    handle to hide5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of hide5


% --- Executes on button press in hide3.
function hide3_Callback(hObject, eventdata, handles)
% hObject    handle to hide3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of hide3


% --- Executes on button press in hide6.
function hide6_Callback(hObject, eventdata, handles)
% hObject    handle to hide6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of hide6


% --- Executes on button press in hide7.
function hide7_Callback(hObject, eventdata, handles)
% hObject    handle to hide7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of hide7


% --- Executes on button press in hide8.
function hide8_Callback(hObject, eventdata, handles)
% hObject    handle to hide8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of hide8


% --- Executes on button press in hide9.
function hide9_Callback(hObject, eventdata, handles)
% hObject    handle to hide9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of hide9


% --- Executes on button press in hide10.
function hide10_Callback(hObject, eventdata, handles)
% hObject    handle to hide10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of hide10


% --- Executes on button press in hide11.
function hide11_Callback(hObject, eventdata, handles)
% hObject    handle to hide11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of hide11


% --- Executes on button press in hide12.
function hide12_Callback(hObject, eventdata, handles)
% hObject    handle to hide12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of hide12


% --- Executes on button press in hide13.
function hide13_Callback(hObject, eventdata, handles)
% hObject    handle to hide13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of hide13


% --- Executes on button press in hide14.
function hide14_Callback(hObject, eventdata, handles)
% hObject    handle to hide14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of hide14

% --- Executes on button press in color12.
function color12_Callback(hObject, eventdata, handles)
% hObject    handle to color12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
c = uisetcolor;
set(hObject,'BackgroundColor',c);



function grid1_Callback(hObject, eventdata, handles)
% hObject    handle to grid1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of grid1 as text
%        str2double(get(hObject,'String')) returns contents of grid1 as a double


% --- Executes during object creation, after setting all properties.
function grid1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to grid1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function grid2_Callback(hObject, eventdata, handles)
% hObject    handle to grid2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of grid2 as text
%        str2double(get(hObject,'String')) returns contents of grid2 as a double


% --- Executes during object creation, after setting all properties.
function grid2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to grid2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function grid3_Callback(hObject, eventdata, handles)
% hObject    handle to grid3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of grid3 as text
%        str2double(get(hObject,'String')) returns contents of grid3 as a double


% --- Executes during object creation, after setting all properties.
function grid3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to grid3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function grid4_Callback(hObject, eventdata, handles)
% hObject    handle to grid4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of grid4 as text
%        str2double(get(hObject,'String')) returns contents of grid4 as a double


% --- Executes during object creation, after setting all properties.
function grid4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to grid4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function grid5_Callback(hObject, eventdata, handles)
% hObject    handle to grid5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of grid5 as text
%        str2double(get(hObject,'String')) returns contents of grid5 as a double


% --- Executes during object creation, after setting all properties.
function grid5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to grid5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in saveMontage.
function saveMontage_Callback(hObject, eventdata, handles)
% hObject    handle to saveMontage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
montageFile = sprintf('function CurrMontage = sleep_Montage(handles)\n');
montageFile = [montageFile,sprintf('%%%%    Auto-generated Húmë Scoring Montage\n')];
montageFile = [montageFile,sprintf('%%  Montage Generated from File: %s\n',get(handles.editDataIN,'String'))];
montageFile = [montageFile,sprintf('%%  Montage Generated on Date: %s\n\n',date)];
montageFile = [montageFile,sprintf('%%%%    Copyright (c) 2015 Jared M. Saletin, PhD and Stephanie M. Greer, PhD\n')];
montageFile = [montageFile,sprintf('%%\n')];
montageFile = [montageFile,sprintf('%%   This file is part of Húmë.\n')];
montageFile = [montageFile,sprintf('%%\n')];
montageFile = [montageFile,sprintf('%%   Húmë is free software: you can redistribute it and/or modify it\n')];
montageFile = [montageFile,sprintf('%%   under the terms of the GNU General Public License as published by the\n')];
montageFile = [montageFile,sprintf('%%   Free Software Foundation, either version 3 of the License, or (at your\n')];
montageFile = [montageFile,sprintf('%%   option) any later version.\n')];
montageFile = [montageFile,sprintf('%% \n')];
montageFile = [montageFile,sprintf('%%   Húmë is distributed in the hope that it will be useful, but\n')];
montageFile = [montageFile,sprintf('%%   WITHOUT ANY WARRANTY; without even the implied warranty of\n')];
montageFile = [montageFile,sprintf('%%   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU\n')];
montageFile = [montageFile,sprintf('%%   General Public License for more details.\n')];
montageFile = [montageFile,sprintf('%% \n')];
montageFile = [montageFile,sprintf('%%   You should have received a copy of the GNU General Public License along\n')];
montageFile = [montageFile,sprintf('%%   with Húmë.  If not, see <http://www.gnu.org/licenses/>.\n')];
montageFile = [montageFile,sprintf('%%\n')];
montageFile = [montageFile,sprintf('%%   Húmë is intended for research purposes only. Any commerical or medical\n')];
montageFile = [montageFile,sprintf('%%   use of this software is prohibited. The authors accept no\n')];
montageFile = [montageFile,sprintf('%%   responsibility for its use in this manner.\n')];
montageFile = [montageFile,sprintf('%%%%\n')];

montageFile = [montageFile,sprintf('%% channels to hide\n')];
channels = '{';
colors = '{';
ampChs = '{';
scaleChs = '{';
hideChs = '{';

g=0;
for e = 1:14
    
    eval(['val = get(handles.channel',num2str(e),', ''Value'');']);
    if val > 1
        eval(['channelSet = get(handles.channel',num2str(e),', ''String'');']);
        channel = channelSet(val);
        channels = [channels,'''',channel{1},''';'];

        eval(['col = get(handles.color',num2str(e),', ''BackgroundColor'');']);
        colors = [colors,'[',num2str(col),'];'];

        eval(['hide = get(handles.hide',num2str(e),', ''Value'');']);
        if hide == 1
            hideChs = [hideChs,'''',channel{1},''' '];
        end
        
        eval(['neg = get(handles.neg',num2str(e),', ''Value'');']);
        if hide == 1
            negChs = [negChs,'''',channel{1},''' '];
        end
        
        eval(['val = get(handles.scale',num2str(e),', ''Value'');']);
        eval(['scaleSet = get(handles.scale',num2str(e),', ''String'');']);
        scale = scaleSet(val);
        scaleChs = [scaleChs,'''',scale{1},''';'];
        
        eval(['amp = get(handles.amp',num2str(e),', ''Value'');']);
        if amp == 1
            g=g+1;
            ampChs = [ampChs,'''',channel{1},''' '];
            bigGridMat{g,1} = channel{1};
            eval(['bigGridMat{g,2} = handles.gridMat',num2str(e),';']);
        end
        
        eval(['o2sat = get(handles.o2sat',num2str(e),', ''Value'');']);
        if hide == 1
            o2satChs = [o2satChs,'''',channel{1},''' '];
        end
    end

end
channels = [channels,'}'];
hideChs = [hideChs,'}'];
negChs = [negChs,'}'];
ampChs = [ampChs,'}'];
colors = [colors,'}'];
scaleChs =[scaleChs,'}'];
o2satChs = [o2satChs,'}'];

montageFile = [montageFile,sprintf('CurrMontage.hideChans = %s;\n', hideChs)];

montageFile = [montageFile,sprintf('%%electrode names that should be ploted.\n')];
montageFile = [montageFile,sprintf('CurrMontage.electrodes = flipud(%s);\n',channels)];

montageFile = [montageFile,sprintf('%%colors for each electrode. The order and length must match the electrode list\n')];
montageFile = [montageFile,sprintf('CurrMontage.colors = flipud(%s);\n', colors)];

montageFile = [montageFile,sprintf('%%scale for each electrode. The order and length must match the electrode list\n')];
montageFile = [montageFile,sprintf('CurrMontage.scale = flipud(%s);\n', scaleChs)];

montageFile = [montageFile,sprintf('%% channels to add scale lines to\n')];
montageFile = [montageFile,sprintf('CurrMontage.scaleChans = %s;\n', ampChs)];

montageFile = [montageFile,sprintf('%% channels to plot as second-to-second numeric data (e.g., SpO2) data\n')];
montageFile = [montageFile,sprintf('CurrMontage.o2satChs = %s;\n', o2satChs)];

montageFile = [montageFile,sprintf('%% channels to plot negative up\n')];
montageFile = [montageFile,sprintf('CurrMontage.negChans = %s;\n', negChs)];

montageFile = [montageFile,sprintf('%% voltage to place scales\n')];

for i = 1:size(bigGridMat,1)

    % print channel index
    montageFile = [montageFile,sprintf('CurrMontage.bigGridMat{%d,1} = ''%s'';\n',i,bigGridMat{i,1})];
   
    % print grid amp cells
    config = bigGridMat{i,2};
    for r = 1:size(config,1);
        montageFile = [montageFile,sprintf('CurrMontage.bigGridMat{%d,2}{%d,1} = ''%s'';\n',i,r,bigGridMat{i,2}{r,1})];
        montageFile = [montageFile,sprintf('CurrMontage.bigGridMat{%d,2}{%d,2} = [%d %d %d];\n',i,r,bigGridMat{i,2}{r,2}(1,1),bigGridMat{i,2}{r,2}(1,2),bigGridMat{i,2}{r,2}(1,3))];
    end
end
%montageFile = [montageFile,sprintf('handles.grids = %s;\n',grids)];
[fileName,pathName]= uiputfile({'*.m'},'Save Montage File');
fid = fopen([pathName,fileName],'w');
fwrite(fid,montageFile);
fclose(fid);

% --- Executes on button press in loadMontage.
function loadMontage_Callback(hObject, eventdata, handles)
% hObject    handle to loadMontage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
defaultGridMat = {
    '-75'   [0 .5 0]
    '-37.5'   [0 .5 0]
    '0'     [0 .5 0]
    '37.5'    [0 .5 0]
    '75'    [0 .5 0]};

for i = 1:14
    
    eval(['handles.gridMat',num2str(i),' = defaultGridMat;']);
    eval(['set(handles.scale',num2str(i),', ''Value'', 10);']);
    eval(['set(handles.amp',num2str(i),', ''Value'', 0);']);
     eval(['set(handles.color',num2str(i),', ''BackgroundColor'', [.925 .925 .925]);']);

end

[fileName,pathName]= uigetfile({'*.m'},'Load Montage File');

eval(['montage = ',fileName(1:end-2),';']);

bigGridMat = montage.bigGridMat;
colors = flipud(montage.colors);
electrodes = flipud(montage.electrodes);
negChs = montage.negChans;
hideChs = montage.hideChans;
scale = flipud(montage.scale);
ampChs = montage.scaleChans;
o2satChs = montage.o2satChs;

for e=1:length(montage.electrodes)
    
    i = find(ismember(handles.labels,electrodes{e}));
    eval(['set(handles.channel',num2str(e),',''Value'',',num2str(i(1)+1),');']);
    eval(['set(handles.color',num2str(e),',''BackgroundColor'',[',num2str(colors{e}),']);']);
    
    eval(['scaleSet = get(handles.scale',num2str(e),', ''String'');']);
    i = find(ismember(scaleSet,scale{e}));
    eval(['set(handles.scale',num2str(e),',''Value'',',num2str(i(1)),');']);

          
end

for e = 1:length(hideChs)
    
    i = find(ismember(electrodes,hideChs{e}));
    eval(['set(handles.hide',num2str(i),',''Value'', 1);']);

end

for e = 1:length(negChs)

    i = find(ismember(electrodes,negChs{e}));
    if isempty(i)
        errCode=1;
        break
    end
    eval(['set(handles.neg',num2str(i),',''Value'', 1);']);

end

for e = 1:length(o2satChs)

    i = find(ismember(electrodes,o2satChs{e}));
    if isempty(i)
        errCode=1;
        break
    end
    eval(['set(handles.o2sat',num2str(i),',''Value'', 1);']);
    eval(['set(handles.amp',num2str(i),',''Enable'', ''off'');']);
    eval(['set(handles.hide',num2str(i),',''Enable'', ''off'');']);
    eval(['set(handles.color',num2str(i),',''Enable'', ''off'');']);
    eval(['set(handles.setGrid',num2str(i),',''Enable'', ''off'');']);
    eval(['set(handles.scale',num2str(i),',''Enable'', ''off'');']);
    eval(['set(handles.neg',num2str(i),',''Enable'', ''off'');']);
    
end

for e = 1:length(ampChs)
    
    i = find(ismember(electrodes,ampChs{e}));
    eval(['set(handles.amp',num2str(i),',''Value'', 1);']);

    chanSet = bigGridMat(:,1);
    channel = find(ismember(chanSet,ampChs{e}));
    
    gridData = bigGridMat{channel,2};
    
    eval(['handles.grid',num2str(i),' = gridData;']);
    
end

% --- Executes on button press in loadData.
function loadData_Callback(hObject, eventdata, handles)
% hObject    handle to loadData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[filename, filePath] = uigetfile({'*.mat','MAT-files (*.mat)'; '*.edf','EDF-files (*.edf)'; '*.set', 'EEGLAB (*.set)'; '*.*',  'All Files (*.*)'}, 'Sleep Data File');
set(handles.editDataIN,'String',filename);
if(strcmp(filename((end - 3):end), '.mat'))
    load([filePath,filename]);
elseif(strcmp(filename((end - 3):end), '.edf') || strcmp(filename((end - 3):end), '.EDF'))
    EEG = pop_biosig([filePath,filename]);
elseif(strcmp(filename((end - 3):end), '.set'))
    EEG = pop_loadset([filePath,filename]); 
else
    display('CAN NOT OPEN FILE: don''t recognise file ending')
end

channelNames = {'Channel'};
handles.labels = {EEG.chanlocs(:).labels};
channelNames = {channelNames{1} handles.labels{1:length(handles.labels)}}';
for ch=1:14
    eval(['set(handles.channel',num2str(ch),',''String'',channelNames);']);
end
guidata(hObject, handles);



function editDataIN_Callback(hObject, eventdata, handles)
% hObject    handle to editDataIN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editDataIN as text
%        str2double(get(hObject,'String')) returns contents of editDataIN as a double


% --- Executes during object creation, after setting all properties.
function editDataIN_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editDataIN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in setGrid1.
function setGrid1_Callback(hObject, eventdata, handles)
% hObject    handle to setGrid1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.gridMat1 = sleepAmpGrids(handles.gridMat1);
guidata(hObject, handles);

% --- Executes on button press in setGrid2.
function setGrid2_Callback(hObject, eventdata, handles)
% hObject    handle to setGrid2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.gridMat2 = sleepAmpGrids(handles.gridMat2);
guidata(hObject, handles);

% --- Executes on button press in setGrid3.
function setGrid3_Callback(hObject, eventdata, handles)
% hObject    handle to setGrid3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.gridMat3 = sleepAmpGrids(handles.gridMat3);
guidata(hObject, handles);

% --- Executes on button press in setGrid4.
function setGrid4_Callback(hObject, eventdata, handles)
% hObject    handle to setGrid4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.gridMat4 = sleepAmpGrids(handles.gridMat4);
guidata(hObject, handles);

% --- Executes on button press in setGrid5.
function setGrid5_Callback(hObject, eventdata, handles)
% hObject    handle to setGrid5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.gridMat5 = sleepAmpGrids(handles.gridMat5);
guidata(hObject, handles);

% --- Executes on button press in setGrid6.
function setGrid6_Callback(hObject, eventdata, handles)
% hObject    handle to setGrid6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.gridMat6 = sleepAmpGrids(handles.gridMat6);
guidata(hObject, handles);

% --- Executes on button press in setGrid7.
function setGrid7_Callback(hObject, eventdata, handles)
% hObject    handle to setGrid7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.gridMat7 = sleepAmpGrids(handles.gridMat7);
guidata(hObject, handles);

% --- Executes on button press in setGrid8.
function setGrid8_Callback(hObject, eventdata, handles)
% hObject    handle to setGrid8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.gridMat8 = sleepAmpGrids(handles.gridMat8);
guidata(hObject, handles);

% --- Executes on button press in setGrid9.
function setGrid9_Callback(hObject, eventdata, handles)
% hObject    handle to setGrid9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.gridMat9 = sleepAmpGrids(handles.gridMat9);
guidata(hObject, handles);

% --- Executes on button press in setGrid10.
function setGrid10_Callback(hObject, eventdata, handles)
% hObject    handle to setGrid10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.gridMat10 = sleepAmpGrids(handles.gridMat10);
guidata(hObject, handles);

% --- Executes on button press in setGrid11.
function setGrid11_Callback(hObject, eventdata, handles)
% hObject    handle to setGrid11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.gridMat11 = sleepAmpGrids(handles.gridMat11);
guidata(hObject, handles);

% --- Executes on button press in setGrid12.
function setGrid12_Callback(hObject, eventdata, handles)
% hObject    handle to setGrid12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.gridMat12 = sleepAmpGrids(handles.gridMat12);
guidata(hObject, handles);

% --- Executes on button press in setGrid13.
function setGrid13_Callback(hObject, eventdata, handles)
% hObject    handle to setGrid13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.gridMat13 = sleepAmpGrids(handles.gridMat13);
guidata(hObject, handles);

% --- Executes on button press in setGrid14.
function setGrid14_Callback(hObject, eventdata, handles)
% hObject    handle to setGrid14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.gridMat14 = sleepAmpGrids(handles.gridMat14);
guidata(hObject, handles);

% --- Executes on selection change in scale1.
function scale1_Callback(hObject, eventdata, handles)
% hObject    handle to scale1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns scale1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from scale1


% --- Executes during object creation, after setting all properties.
function scale1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to scale1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in scale2.
function scale2_Callback(hObject, eventdata, handles)
% hObject    handle to scale2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns scale2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from scale2


% --- Executes during object creation, after setting all properties.
function scale2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to scale2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in scale3.
function scale3_Callback(hObject, eventdata, handles)
% hObject    handle to scale3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns scale3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from scale3


% --- Executes during object creation, after setting all properties.
function scale3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to scale3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in scale4.
function scale4_Callback(hObject, eventdata, handles)
% hObject    handle to scale4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns scale4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from scale4


% --- Executes during object creation, after setting all properties.
function scale4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to scale4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in scale5.
function scale5_Callback(hObject, eventdata, handles)
% hObject    handle to scale5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns scale5 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from scale5


% --- Executes during object creation, after setting all properties.
function scale5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to scale5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in scale6.
function scale6_Callback(hObject, eventdata, handles)
% hObject    handle to scale6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns scale6 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from scale6


% --- Executes during object creation, after setting all properties.
function scale6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to scale6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in scale7.
function scale7_Callback(hObject, eventdata, handles)
% hObject    handle to scale7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns scale7 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from scale7


% --- Executes during object creation, after setting all properties.
function scale7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to scale7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in scale8.
function scale8_Callback(hObject, eventdata, handles)
% hObject    handle to scale8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns scale8 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from scale8


% --- Executes during object creation, after setting all properties.
function scale8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to scale8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in scale9.
function scale9_Callback(hObject, eventdata, handles)
% hObject    handle to scale9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns scale9 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from scale9


% --- Executes during object creation, after setting all properties.
function scale9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to scale9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in scale10.
function scale10_Callback(hObject, eventdata, handles)
% hObject    handle to scale10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns scale10 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from scale10


% --- Executes during object creation, after setting all properties.
function scale10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to scale10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in scale11.
function scale11_Callback(hObject, eventdata, handles)
% hObject    handle to scale11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns scale11 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from scale11


% --- Executes during object creation, after setting all properties.
function scale11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to scale11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in scale12.
function scale12_Callback(hObject, eventdata, handles)
% hObject    handle to scale12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns scale12 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from scale12


% --- Executes during object creation, after setting all properties.
function scale12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to scale12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in scale13.
function scale13_Callback(hObject, eventdata, handles)
% hObject    handle to scale13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns scale13 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from scale13


% --- Executes during object creation, after setting all properties.
function scale13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to scale13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in scale14.
function scale14_Callback(hObject, eventdata, handles)
% hObject    handle to scale14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns scale14 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from scale14


% --- Executes during object creation, after setting all properties.
function scale14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to scale14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in o2sat1.
function o2sat1_Callback(hObject, eventdata, handles)
% hObject    handle to o2sat1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of o2sat1
switch get(hObject,'Value')
    case 0
        set(handles.amp1,'Enable', 'on');
        set(handles.hide1,'Enable', 'on');
        set(handles.color1,'Enable', 'on');
        set(handles.setGrid1,'Enable', 'on');
        set(handles.scale1,'Enable', 'on');
        set(handles.neg1,'Enable','on');
    case 1
        set(handles.amp1,'Enable', 'off');
        set(handles.hide1,'Enable', 'off');
        set(handles.color1,'Enable', 'off');
        set(handles.setGrid1,'Enable', 'off');
        set(handles.scale1,'Enable', 'off');
        set(handles.neg1,'Enable','off');
end

% --- Executes on button press in o2sat2.
function o2sat2_Callback(hObject, eventdata, handles)
% hObject    handle to o2sat2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of o2sat2
switch get(hObject,'Value')
    case 0
        set(handles.amp2,'Enable', 'on');
        set(handles.hide2,'Enable', 'on');
        set(handles.color2,'Enable', 'on');
        set(handles.setGrid2,'Enable', 'on');
        set(handles.scale2,'Enable', 'on');
        set(handles.neg2,'Enable','on');
    case 1
        set(handles.amp2,'Enable', 'off');
        set(handles.hide2,'Enable', 'off');
        set(handles.color2,'Enable', 'off');
        set(handles.setGrid2,'Enable', 'off');
        set(handles.scale2,'Enable', 'off');
        set(handles.neg2,'Enable','off');
end

% --- Executes on button press in o2sat3.
function o2sat3_Callback(hObject, eventdata, handles)
% hObject    handle to o2sat3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of o2sat3
switch get(hObject,'Value')
    case 0
        set(handles.amp3,'Enable', 'on');
        set(handles.hide3,'Enable', 'on');
        set(handles.color3,'Enable', 'on');
        set(handles.setGrid3,'Enable', 'on');
        set(handles.scale3,'Enable', 'on');
        set(handles.neg3,'Enable','on');
    case 1
        set(handles.amp3,'Enable', 'off');
        set(handles.hide3,'Enable', 'off');
        set(handles.color3,'Enable', 'off');
        set(handles.setGrid3,'Enable', 'off');
        set(handles.scale3,'Enable', 'off');
        set(handles.neg3,'Enable','off');
end

% --- Executes on button press in o2sat4.
function o2sat4_Callback(hObject, eventdata, handles)
% hObject    handle to o2sat4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of o2sat4
switch get(hObject,'Value')
    case 0
        set(handles.amp4,'Enable', 'on');
        set(handles.hide4,'Enable', 'on');
        set(handles.color4,'Enable', 'on');
        set(handles.setGrid4,'Enable', 'on');
        set(handles.scale4,'Enable', 'on');
        set(handles.neg4,'Enable','on');
    case 1
        set(handles.amp4,'Enable', 'off');
        set(handles.hide4,'Enable', 'off');
        set(handles.color4,'Enable', 'off');
        set(handles.setGrid4,'Enable', 'off');
        set(handles.scale4,'Enable', 'off');
        set(handles.neg4,'Enable','off');
end

% --- Executes on button press in o2sat5.
function o2sat5_Callback(hObject, eventdata, handles)
% hObject    handle to o2sat5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of o2sat5
switch get(hObject,'Value')
    case 0
        set(handles.amp5,'Enable', 'on');
        set(handles.hide5,'Enable', 'on');
        set(handles.color5,'Enable', 'on');
        set(handles.setGrid5,'Enable', 'on');
        set(handles.scale5,'Enable', 'on');
        set(handles.neg5,'Enable','on');
    case 1
        set(handles.amp5,'Enable', 'off');
        set(handles.hide5,'Enable', 'off');
        set(handles.color5,'Enable', 'off');
        set(handles.setGrid5,'Enable', 'off');
        set(handles.scale5,'Enable', 'off');
        set(handles.neg5,'Enable','off');
end

% --- Executes on button press in o2sat6.
function o2sat6_Callback(hObject, eventdata, handles)
% hObject    handle to o2sat6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of o2sat6
switch get(hObject,'Value')
    case 0
        set(handles.amp6,'Enable', 'on');
        set(handles.hide6,'Enable', 'on');
        set(handles.color6,'Enable', 'on');
        set(handles.setGrid6,'Enable', 'on');
        set(handles.scale6,'Enable', 'on');
        set(handles.neg6,'Enable','on');
    case 1
        set(handles.amp6,'Enable', 'off');
        set(handles.hide6,'Enable', 'off');
        set(handles.color6,'Enable', 'off');
        set(handles.setGrid6,'Enable', 'off');
        set(handles.scale6,'Enable', 'off');
        set(handles.neg6,'Enable','off');
end

% --- Executes on button press in o2sat7.
function o2sat7_Callback(hObject, eventdata, handles)
% hObject    handle to o2sat7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of o2sat7
switch get(hObject,'Value')
    case 0
        set(handles.amp7,'Enable', 'on');
        set(handles.hide7,'Enable', 'on');
        set(handles.color7,'Enable', 'on');
        set(handles.setGrid7,'Enable', 'on');
        set(handles.scale7,'Enable', 'on');
        set(handles.neg7,'Enable','on');
    case 1
        set(handles.amp7,'Enable', 'off');
        set(handles.hide7,'Enable', 'off');
        set(handles.color7,'Enable', 'off');
        set(handles.setGrid7,'Enable', 'off');
        set(handles.scale7,'Enable', 'off');
        set(handles.neg7,'Enable','off');
end

% --- Executes on button press in o2sat8.
function o2sat8_Callback(hObject, eventdata, handles)
% hObject    handle to o2sat8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of o2sat8
switch get(hObject,'Value')
    case 0
        set(handles.amp8,'Enable', 'on');
        set(handles.hide8,'Enable', 'on');
        set(handles.color8,'Enable', 'on');
        set(handles.setGrid8,'Enable', 'on');
        set(handles.scale8,'Enable', 'on');
        set(handles.neg8,'Enable','on');
    case 1
        set(handles.amp8,'Enable', 'off');
        set(handles.hide8,'Enable', 'off');
        set(handles.color8,'Enable', 'off');
        set(handles.setGrid8,'Enable', 'off');
        set(handles.scale8,'Enable', 'off');
        set(handles.neg8,'Enable','off');
end

% --- Executes on button press in o2sat9.
function o2sat9_Callback(hObject, eventdata, handles)
% hObject    handle to o2sat9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of o2sat9
switch get(hObject,'Value')
    case 0
        set(handles.amp9,'Enable', 'on');
        set(handles.hide9,'Enable', 'on');
        set(handles.color9,'Enable', 'on');
        set(handles.setGrid9,'Enable', 'on');
        set(handles.scale9,'Enable', 'on');
        set(handles.neg9,'Enable','on');
    case 1
        set(handles.amp9,'Enable', 'off');
        set(handles.hide9,'Enable', 'off');
        set(handles.color9,'Enable', 'off');
        set(handles.setGrid9,'Enable', 'off');
        set(handles.scale9,'Enable', 'off');
        set(handles.neg9,'Enable','off');
end


% --- Executes on button press in o2sat10.
function o2sat10_Callback(hObject, eventdata, handles)
% hObject    handle to o2sat10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of o2sat10
switch get(hObject,'Value')
    case 0
        set(handles.amp10,'Enable', 'on');
        set(handles.hide10,'Enable', 'on');
        set(handles.color10,'Enable', 'on');
        set(handles.setGrid10,'Enable', 'on');
        set(handles.scale10,'Enable', 'on');
        set(handles.neg10,'Enable','on');
    case 1
        set(handles.amp10,'Enable', 'off');
        set(handles.hide10,'Enable', 'off');
        set(handles.color10,'Enable', 'off');
        set(handles.setGrid10,'Enable', 'off');
        set(handles.scale10,'Enable', 'off');
        set(handles.neg10,'Enable','off');
end


% --- Executes on button press in o2sat11.
function o2sat11_Callback(hObject, eventdata, handles)
% hObject    handle to o2sat11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of o2sat11
switch get(hObject,'Value')
    case 0
        set(handles.amp11,'Enable', 'on');
        set(handles.hide11,'Enable', 'on');
        set(handles.color11,'Enable', 'on');
        set(handles.setGrid11,'Enable', 'on');
        set(handles.scale11,'Enable', 'on');
        set(handles.neg11,'Enable','on');
    case 1
        set(handles.amp11,'Enable', 'off');
        set(handles.hide11,'Enable', 'off');
        set(handles.color11,'Enable', 'off');
        set(handles.setGrid11,'Enable', 'off');
        set(handles.scale11,'Enable', 'off');
        set(handles.neg11,'Enable','off');
end

        
    


% --- Executes on button press in o2sat12.
function o2sat12_Callback(hObject, eventdata, handles)
% hObject    handle to o2sat12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of o2sat12
switch get(hObject,'Value')
    case 0
        set(handles.amp12,'Enable', 'on');
        set(handles.hide12,'Enable', 'on');
        set(handles.color12,'Enable', 'on');
        set(handles.setGrid12,'Enable', 'on');
        set(handles.scale12,'Enable', 'on');
        set(handles.neg12,'Enable','on');
    case 1
        set(handles.amp12,'Enable', 'off');
        set(handles.hide12,'Enable', 'off');
        set(handles.color12,'Enable', 'off');
        set(handles.setGrid12,'Enable', 'off');
        set(handles.scale12,'Enable', 'off');
        set(handles.neg12,'Enable','off');
end


% --- Executes on button press in o2sat13.
function o2sat13_Callback(hObject, eventdata, handles)
% hObject    handle to o2sat13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of o2sat13
switch get(hObject,'Value')
    case 0
        set(handles.amp13,'Enable', 'on');
        set(handles.hide13,'Enable', 'on');
        set(handles.color13,'Enable', 'on');
        set(handles.setGrid13,'Enable', 'on');
        set(handles.scale13,'Enable', 'on');
        set(handles.neg13,'Enable','on');
    case 1
        set(handles.amp13,'Enable', 'off');
        set(handles.hide13,'Enable', 'off');
        set(handles.color13,'Enable', 'off');
        set(handles.setGrid13,'Enable', 'off');
        set(handles.scale13,'Enable', 'off');
        set(handles.neg13,'Enable','off');
end


% --- Executes on button press in o2sat14.
function o2sat14_Callback(hObject, eventdata, handles)
% hObject    handle to o2sat14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of o2sat14
switch get(hObject,'Value')
    case 0
        set(handles.amp14,'Enable', 'on');
        set(handles.hide14,'Enable', 'on');
        set(handles.color14,'Enable', 'on');
        set(handles.setGrid14,'Enable', 'on');
        set(handles.scale14,'Enable', 'on');
        set(handles.neg14,'Enable','on');
    case 1
        set(handles.amp14,'Enable', 'off');
        set(handles.hide14,'Enable', 'off');
        set(handles.color14,'Enable', 'off');
        set(handles.setGrid14,'Enable', 'off');
        set(handles.scale14,'Enable', 'off');
        set(handles.neg14,'Enable','off');
end



% --- Executes on button press in neg1.
function neg1_Callback(hObject, eventdata, handles)
% hObject    handle to neg1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of neg1


% --- Executes on button press in neg2.
function neg2_Callback(hObject, eventdata, handles)
% hObject    handle to neg2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of neg2


% --- Executes on button press in neg3.
function neg3_Callback(hObject, eventdata, handles)
% hObject    handle to neg3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of neg3


% --- Executes on button press in neg4.
function neg4_Callback(hObject, eventdata, handles)
% hObject    handle to neg4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of neg4


% --- Executes on button press in neg5.
function neg5_Callback(hObject, eventdata, handles)
% hObject    handle to neg5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of neg5


% --- Executes on button press in neg6.
function neg6_Callback(hObject, eventdata, handles)
% hObject    handle to neg6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of neg6


% --- Executes on button press in neg7.
function neg7_Callback(hObject, eventdata, handles)
% hObject    handle to neg7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of neg7


% --- Executes on button press in neg8.
function neg8_Callback(hObject, eventdata, handles)
% hObject    handle to neg8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of neg8


% --- Executes on button press in neg9.
function neg9_Callback(hObject, eventdata, handles)
% hObject    handle to neg9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of neg9


% --- Executes on button press in neg10.
function neg10_Callback(hObject, eventdata, handles)
% hObject    handle to neg10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of neg10


% --- Executes on button press in neg11.
function neg11_Callback(hObject, eventdata, handles)
% hObject    handle to neg11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of neg11


% --- Executes on button press in neg12.
function neg12_Callback(hObject, eventdata, handles)
% hObject    handle to neg12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of neg12


% --- Executes on button press in neg13.
function neg13_Callback(hObject, eventdata, handles)
% hObject    handle to neg13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of neg13


% --- Executes on button press in neg14.
function neg14_Callback(hObject, eventdata, handles)
% hObject    handle to neg14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of neg14
