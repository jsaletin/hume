function varargout = sleepDBConnect(varargin)
% SLEEPDBCONNECT MATLAB code for sleepDBConnect.fig
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
%%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help sleepDBConnect

% Last Modified by GUIDE v2.5 22-Aug-2016 18:33:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @sleepDBConnect_OpeningFcn, ...
                   'gui_OutputFcn',  @sleepDBConnect_OutputFcn, ...
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


% --- Executes just before sleepDBConnect is made visible.
function sleepDBConnect_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to sleepDBConnect (see VARARGIN)

% Choose default command line output for sleepDBConnect
handles.output = hObject;

% Setup FileTypes
sleepPath = which('hume');
handles.extList = {'.mat'};
handles.importList = {[]};
handles.password='';
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes sleepDBConnect wait for user response (see UIRESUME)
% uiwait(handles.gui);


% --- Outputs from this function are returned to the command line.
function varargout = sleepDBConnect_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in connect.
function connect_Callback(hObject, eventdata, handles)
% hObject    handle to connect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% open a connection

switch handles.dbAuth.Value
    
    case 1
       msgbox('Please pick a server authentication type');
       
    case 2
       handles.conn = database(handles.dbName.String,handles.dbUsername.String,handles.dbPassword.String, ...
                 'net.sourceforge.jtds.jdbc.Driver', ['jdbc:jtds:sqlserver://',handles.dbAddress.String,'/',handles.dbName.String,';domain=',handles.dbDomain.String,';useNTLMv2=true;']);

    case 3
       handles.conn = database(handles.dbName.String,handles.dbUsername.String,handles.dbPassword.String, ...
                'Vendor','Microsoft SQL Server','Server',handles.dbAddress.String, ...
                'AuthType','Server','portnumber',1433);
            
    case 4 
       handles.conn = database(handles.dbName.String,'jared','',...
                'Vendor','PostgreSQL',...
                'Server','localhost');
    case 5
        msgbox('Integarted Húmë is not yet implemented');
end

if ~isfield(handles,'conn')
        msgbox('Failed to Connect to Database, Check Parameters');
        return;
elseif isopen(handles.conn) == 0
        msgbox('Failed to Connect to Database, Check Parameters');
        return
else
    guidata(hObject,handles);
    setappdata(0,'Conn',handles.conn);
    waitfor(msgbox('Connection OK!'));
    close(handles.gui);    % sleepStatsDBReport2(conn, handles);
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


% --- Executes on key press with focus on dbPassword and none of its controls.
function dbPassword_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to dbPassword (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% Function to replace all characters in the password edit box with
% asterisks
% if ~isfield(handles.dbPassword,'password')
%     password = '';
%     handles.dbPassword = password;
% else 
%     password = handles.dbPassword.password;
% end
% 
% key = eventdata.Key;
% 
% switch key
%     case 'backspace'
%         password = password(1:end-1); % Delete the last character in the password
%     case 'tab' 
%     case 'escape'
%     case 'delete'
%     otherwise
%         password = [password eventdata.Character]; % Add the typed character to the password
% end
% SizePass = size(password); % Find the number of asterisks
% if SizePass(2) > 0
%     asterisk(1,1:SizePass(2)) = '*'; % Create a string of asterisks the same size as the password
%     set(hObject,'String',asterisk) % Set the text in the password edit box to the asterisk string
% else
%     set(hObject,'String','')
% end
% msgbox(password);
% handles.dbPassword.password=password;
% guidata(hObject,handles);
% %set(handles,'password',password) % Store the password in its current state


% --- Executes when user attempts to close gui.
function gui_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to gui (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
delete(hObject);
