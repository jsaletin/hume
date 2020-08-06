function varargout = sleepDBLocal(varargin)
% SLEEPDBLOCAL MATLAB code for sleepDBLocal.fig
%      SLEEPDBLOCAL, by itself, creates a new SLEEPDBLOCAL or raises the existing
%      singleton*.
%
%      H = SLEEPDBLOCAL returns the handle to a new SLEEPDBLOCAL or the handle to
%      the existing singleton*.
%
%      SLEEPDBLOCAL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SLEEPDBLOCAL.M with the given input arguments.
%
%      SLEEPDBLOCAL('Property','Value',...) creates a new SLEEPDBLOCAL or raises
%      the existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before sleepDBLocal_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to sleepDBLocal_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help sleepDBLocal

% Last Modified by GUIDE v2.5 09-Jul-2020 16:29:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @sleepDBLocal_OpeningFcn, ...
                   'gui_OutputFcn',  @sleepDBLocal_OutputFcn, ...
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

% --- Executes just before sleepDBLocal is made visible.
function sleepDBLocal_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to sleepDBLocal (see VARARGIN)

% Choose default command line output for sleepDBLocal
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

initialize_gui(hObject, handles, false);

% UIWAIT makes sleepDBLocal wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = sleepDBLocal_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function DBfilename_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DBfilename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DBfilename_Callback(hObject, eventdata, handles)
% hObject    handle to DBfilename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DBfilename as text
%        str2double(get(hObject,'String')) returns contents of DBfilename as a double

guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function password_CreateFcn(hObject, eventdata, handles)
% hObject    handle to password (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function password_Callback(hObject, eventdata, handles)
% hObject    handle to password (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of password as text
%        str2double(get(hObject,'String')) returns contents of password as a double


% --- Executes on button press in connect.
function connect_Callback(hObject, eventdata, handles)
% hObject    handle to connect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% open a connection

     
%handles.conn = sqlite(handles.DBfilename.String);
 
handles.conn = database('','','','org.sqlite.JDBC',['jdbc:sqlite:',handles.DBfilename.String]);

if ~isfield(handles,'conn')
        msgbox('Failed to Connect to Database, Check Parameters');
        return;
elseif ~isopen(handles.conn)
        msgbox('Failed to Connect to Database, Check Parameters');
        return
else
    guidata(hObject,handles);
    setappdata(0,'Conn',handles.conn);
    waitfor(msgbox('Connection OK!'));
    close(handles.figure1);    
end


% --------------------------------------------------------------------
function initialize_gui(fig_handle, handles, isreset)
% If the metricdata field is present and the reset flag is false, it means
% we are we are just re-initializing a GUI by calling it from the cmd line
% while it is up. So, bail out as we dont want to reset the data.


% Update handles structure
guidata(handles.figure1, handles);


% --- Executes on button press in cancel.
function cancel_Callback(hObject, eventdata, handles)
% hObject    handle to cancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in loadDB.
function loadDB_Callback(hObject, eventdata, handles)
% hObject    handle to loadDB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[fileName, pathName] = uigetfile( {'*.db',  'SQLite Database (*.db)'}, 'SQLite Database');
set(handles.DBfilename, 'String', [pathName,fileName]);
%handles.pathName = pathName;
guidata(hObject,handles);


% --- Executes on button press in passwordYN.
function passwordYN_Callback(hObject, eventdata, handles)
% hObject    handle to passwordYN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of passwordYN
switch get(handles.passwordYN,'Value')
    case 0
        set(handles.password,'Enable', 'off');
    case 1
        set(handles.password,'Enable', 'on');
end
guidata(hObject,handles);
