function varargout = sleepStatsDBCommit(varargin)
% SLEEPSTATSDBCOMMIT MATLAB code for sleepStatsDBCommit.fig
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

% Edit the above text to modify the response to help sleepStatsDBCommit

% Last Modified by GUIDE v2.5 15-Aug-2016 02:48:50

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @sleepStatsDBCommit_OpeningFcn, ...
                   'gui_OutputFcn',  @sleepStatsDBCommit_OutputFcn, ...
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


% --- Executes just before sleepStatsDBCommit is made visible.
function sleepStatsDBCommit_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to sleepStatsDBCommit (see VARARGIN)

% Choose default command line output for sleepStatsDBCommit
handles.output = hObject;

% Setup FileTypes
sleepPath = which('hume');
handles.extList = {'.mat'};
handles.importList = {[]};

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes sleepStatsDBCommit wait for user response (see UIRESUME)
% uiwait(handles.gui);


% --- Outputs from this function are returned to the command line.
function varargout = sleepStatsDBCommit_OutputFcn(hObject, eventdata, handles) 
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

% open a connection

switch handles.dbAuth.Value
    
    case 1
       msgbox('Please pick a server authentication type');
       
    case 2
       conn = database(handles.dbName.String,handles.dbUsername.String,handles.dbPassword.String, ...
                 'net.sourceforge.jtds.jdbc.Driver', ['jdbc:jtds:sqlserver://',handles.dbAddress.String,'/',handles.dbName.String,';domain=',handles.dbDomain.String,';useNTLMv2=true;']);

    case 3
       conn = database(handles.dbName.String,handles.dbUsername.String,handles.dbPassword.String, ...
                'Vendor','Microsoft SQL Server','Server',handles.dbAddress.String, ...
                'AuthType','Server','portnumber',1433);
            
    case 4 
       conn = database(handles.dbName.String,'jared','',...
                'Vendor','PostgreSQL',...
                'Server','localhost');
    case 5
        msgbox('Integarted Húmë is not yet implemented');
end 
    
    if isopen(conn) == 0
        msgbox('Failed to Connect to Database, Check Parameters');
        return;
    end
        
        sleepDBConfirm(conn, handles);
        
        


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
guidata(hObject,handles);

% --- Executes on selection change in dbAuth.
function dbAuth_Callback(hObject, eventdata, handles)
% hObject    handle to dbAuth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns dbAuth contents as cell array
%        contents{get(hObject,'Value')} returns selected item from dbAuth
if hObject.Value == 1
    set(handles.dbAddress,'Enable', 'off');
    set(handles.dbName,'Enable', 'off');
    set(handles.dbUsername,'Enable', 'off');
    set(handles.dbPassword,'Enable', 'off');
    set(handles.dbDomain,'Enable', 'off');
elseif hObject.Value == 2
    set(handles.dbAddress,'Enable', 'on');
    set(handles.dbName,'Enable', 'on');
    set(handles.dbUsername,'Enable', 'on');
    set(handles.dbPassword,'Enable', 'on');    
    set(handles.dbDomain,'Enable', 'on');
else
    set(handles.dbAddress,'Enable', 'on');
    set(handles.dbName,'Enable', 'on');
    set(handles.dbUsername,'Enable', 'on');
    set(handles.dbPassword,'Enable', 'on');
    set(handles.dbDomain,'Enable', 'off');
end

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


% --- Executes when uipanel8 is resized.
function uipanel8_SizeChangedFcn(hObject, eventdata, handles)
% hObject    handle to uipanel8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
