function varargout = sleepAmpGrids(varargin)
% SLEEPAMPGRIDS MATLAB code for sleepAmpGrids.fig
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

% Edit the above text to modify the response to help sleepAmpGrids

% Last Modified by GUIDE v2.5 12-Jan-2015 17:31:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @sleepAmpGrids_OpeningFcn, ...
                   'gui_OutputFcn',  @sleepAmpGrids_OutputFcn, ...
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


% --- Executes just before sleepAmpGrids is made visible.
function sleepAmpGrids_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to sleepAmpGrids (see VARARGIN)

% Choose default command line output for sleepAmpGrids
handles.output = hObject;

inGridMat = varargin{1};

toFill = [1:size(inGridMat,1)];
toBlank = [size(inGridMat,1)+1:10];

for f=1:length(toFill)
    
    eval(['set(handles.g',num2str(toFill(f)),', ''String'', inGridMat{f,1});']);
    eval(['set(handles.g',num2str(toFill(f)),'c, ''BackgroundColor'', inGridMat{f,2});']);
    
end

for f=1:length(toBlank)
    
    eval(['set(handles.g',num2str(toBlank(f)),', ''String'', '''');']);
    eval(['set(handles.g',num2str(toBlank(f)),'c, ''BackgroundColor'', [.925 .925 .925]);']);
    
end

% Update handles structure
guidata(hObject, handles);
uiwait(handles.figure1);

% UIWAIT makes sleepAmpGrids wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = sleepAmpGrids_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.gridMat;
delete(handles.figure1);

% --- Executes on button press in doneB.
function doneB_Callback(hObject, eventdata, handles)
% hObject    handle to doneB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
g1=get(handles.g1,'String');
g2=get(handles.g2,'String');
g3=get(handles.g3,'String');
g4=get(handles.g4,'String');
g5=get(handles.g5,'String');
g6=get(handles.g6,'String');
g7=get(handles.g7,'String');
g8=get(handles.g8,'String');
g9=get(handles.g9,'String');
g10=get(handles.g10,'String');

g1c=get(handles.g1c,'BackgroundColor');
g2c=get(handles.g2c,'BackgroundColor');
g3c=get(handles.g3c,'BackgroundColor');
g4c=get(handles.g4c,'BackgroundColor');
g5c=get(handles.g5c,'BackgroundColor');
g6c=get(handles.g6c,'BackgroundColor');
g7c=get(handles.g7c,'BackgroundColor');
g8c=get(handles.g8c,'BackgroundColor');
g9c=get(handles.g9c,'BackgroundColor');
g10c=get(handles.g10c,'BackgroundColor');

grids = 0;
for i = 1:10
    
    eval(['gvalue = get(handles.g',num2str(i),', ''String'');']);
    eval(['gcolor = get(handles.g',num2str(i),'c, ''BackgroundColor'');']);
    
    if ~isempty(gvalue)
        grids = grids+1;
        gridMat{i,1} = gvalue;
        gridMat{i,2} = gcolor;
    end
    
end

handles.gridMat = gridMat;
guidata(hObject, handles);

uiresume(handles.figure1);


function g1_Callback(hObject, eventdata, handles)
% hObject    handle to g1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of g1 as text
%        str2double(get(hObject,'String')) returns contents of g1 as a double


% --- Executes during object creation, after setting all properties.
function g1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to g1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function g2_Callback(hObject, eventdata, handles)
% hObject    handle to g2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of g2 as text
%        str2double(get(hObject,'String')) returns contents of g2 as a double


% --- Executes during object creation, after setting all properties.
function g2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to g2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function g3_Callback(hObject, eventdata, handles)
% hObject    handle to g3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of g3 as text
%        str2double(get(hObject,'String')) returns contents of g3 as a double


% --- Executes during object creation, after setting all properties.
function g3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to g3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function g4_Callback(hObject, eventdata, handles)
% hObject    handle to g4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of g4 as text
%        str2double(get(hObject,'String')) returns contents of g4 as a double


% --- Executes during object creation, after setting all properties.
function g4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to g4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function g5_Callback(hObject, eventdata, handles)
% hObject    handle to g5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of g5 as text
%        str2double(get(hObject,'String')) returns contents of g5 as a double


% --- Executes during object creation, after setting all properties.
function g5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to g5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function g6_Callback(hObject, eventdata, handles)
% hObject    handle to g6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of g6 as text
%        str2double(get(hObject,'String')) returns contents of g6 as a double


% --- Executes during object creation, after setting all properties.
function g6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to g6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function g7_Callback(hObject, eventdata, handles)
% hObject    handle to g7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of g7 as text
%        str2double(get(hObject,'String')) returns contents of g7 as a double


% --- Executes during object creation, after setting all properties.
function g7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to g7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function g8_Callback(hObject, eventdata, handles)
% hObject    handle to g8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of g8 as text
%        str2double(get(hObject,'String')) returns contents of g8 as a double


% --- Executes during object creation, after setting all properties.
function g8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to g8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function g9_Callback(hObject, eventdata, handles)
% hObject    handle to g9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of g9 as text
%        str2double(get(hObject,'String')) returns contents of g9 as a double


% --- Executes during object creation, after setting all properties.
function g9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to g9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function g10_Callback(hObject, eventdata, handles)
% hObject    handle to g10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of g10 as text
%        str2double(get(hObject,'String')) returns contents of g10 as a double


% --- Executes during object creation, after setting all properties.
function g10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to g10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in g1c.
function g1c_Callback(hObject, eventdata, handles)
% hObject    handle to g1c (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
c = uisetcolor;
set(hObject,'BackgroundColor',c);

% --- Executes on button press in g2c.
function g2c_Callback(hObject, eventdata, handles)
% hObject    handle to g2c (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
c = uisetcolor;
set(hObject,'BackgroundColor',c);

% --- Executes on button press in g3c.
function g3c_Callback(hObject, eventdata, handles)
% hObject    handle to g3c (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
c = uisetcolor;
set(hObject,'BackgroundColor',c);

% --- Executes on button press in g4c.
function g4c_Callback(hObject, eventdata, handles)
% hObject    handle to g4c (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
c = uisetcolor;
set(hObject,'BackgroundColor',c);

% --- Executes on button press in g5c.
function g5c_Callback(hObject, eventdata, handles)
% hObject    handle to g5c (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
c = uisetcolor;
set(hObject,'BackgroundColor',c);

% --- Executes on button press in g6c.
function g6c_Callback(hObject, eventdata, handles)
% hObject    handle to g6c (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
c = uisetcolor;
set(hObject,'BackgroundColor',c);

% --- Executes on button press in g7c.
function g7c_Callback(hObject, eventdata, handles)
% hObject    handle to g7c (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
c = uisetcolor;
set(hObject,'BackgroundColor',c);

% --- Executes on button press in g8c.
function g8c_Callback(hObject, eventdata, handles)
% hObject    handle to g8c (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
c = uisetcolor;
set(hObject,'BackgroundColor',c);

% --- Executes on button press in g9c.
function g9c_Callback(hObject, eventdata, handles)
% hObject    handle to g9c (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
c = uisetcolor;
set(hObject,'BackgroundColor',c);

% --- Executes on button press in g10c.
function g10c_Callback(hObject, eventdata, handles)
% hObject    handle to g10c (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
c = uisetcolor;
set(hObject,'BackgroundColor',c);
