function varargout = sleepReliability(varargin)
% SLEEPRELIABILITY MATLAB code for sleepReliability.fig
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

% Edit the above text to modify the response to help sleepReliability

% Last Modified by GUIDE v2.5 08-Jan-2015 11:17:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @sleepReliability_OpeningFcn, ...
                   'gui_OutputFcn',  @sleepReliability_OutputFcn, ...
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


% --- Executes just before sleepReliability is made visible.
function sleepReliability_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to sleepReliability (see VARARGIN)

% Choose default command line output for sleepReliability
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes sleepReliability wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = sleepReliability_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in browsePrimaryIn.
function browsePrimaryIn_Callback(hObject, eventdata, handles)
% hObject    handle to browsePrimaryIn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[folder] = uigetdir([],'Primary Scorer');
set(handles.primaryFileIN, 'String', folder);
guidata(hObject,handles);

% --- Executes on button press in browseDataOut.
function browseDataOut_Callback(hObject, eventdata, handles)
% hObject    handle to browseDataOut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[folderName pathName] = uiputfile({'*.*',  'All Files (*.*)'},'Output Directory','Reliability');
set(handles.folderOUT, 'String', folderName);
handles.folderOUTPath = pathName;
guidata(hObject,handles);

function folderOUT_Callback(hObject, eventdata, handles)
% hObject    handle to folderOUT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of folderOUT as text
%        str2double(get(hObject,'String')) returns contents of folderOUT as a double


% --- Executes during object creation, after setting all properties.
function folderOUT_CreateFcn(hObject, eventdata, handles)
% hObject    handle to folderOUT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function secondaryFileIN_Callback(hObject, eventdata, handles)
% hObject    handle to secondaryFileIN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of secondaryFileIN as text
%        str2double(get(hObject,'String')) returns contents of secondaryFileIN as a double


% --- Executes during object creation, after setting all properties.
function secondaryFileIN_CreateFcn(hObject, eventdata, handles)
% hObject    handle to secondaryFileIN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in browseSecondaryIn.
function browseSecondaryIn_Callback(hObject, eventdata, handles)
% hObject    handle to browseSecondaryIn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[folder] = uigetdir([],'Secondary Scorer');
set(handles.secondaryFileIN, 'String', folder);
guidata(hObject,handles);


function primaryFileIN_Callback(hObject, eventdata, handles)
% hObject    handle to primaryFileIN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of primaryFileIN as text
%        str2double(get(hObject,'String')) returns contents of primaryFileIN as a double


% --- Executes during object creation, after setting all properties.
function primaryFileIN_CreateFcn(hObject, eventdata, handles)
% hObject    handle to primaryFileIN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in runStats.
function runStats_Callback(hObject, eventdata, handles)
% hObject    handle to runStats (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
primaryScorer = get(handles.primaryFileIN,'string');
secondaryScorer = get(handles.secondaryFileIN,'string');
outPath = handles.folderOUTPath;
outName = get(handles.folderOUT,'string');
Reliability(primaryScorer,secondaryScorer,outPath,outName);
