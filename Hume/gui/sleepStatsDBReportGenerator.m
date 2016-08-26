function varargout = sleepStatsDBReportGenerator(varargin)
% SLEEPSTATSDBREPORTGENERATOR MATLAB code for sleepStatsDBReportGenerator.fig
%      SLEEPSTATSDBREPORTGENERATOR, by itself, creates a new SLEEPSTATSDBREPORTGENERATOR or raises the existing
%      singleton*.
%
%      H = SLEEPSTATSDBREPORTGENERATOR returns the handle to a new SLEEPSTATSDBREPORTGENERATOR or the handle to
%      the existing singleton*.
%
%      SLEEPSTATSDBREPORTGENERATOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SLEEPSTATSDBREPORTGENERATOR.M with the given input arguments.
%
%      SLEEPSTATSDBREPORTGENERATOR('Property','Value',...) creates a new SLEEPSTATSDBREPORTGENERATOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before sleepStatsDBReportGenerator_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to sleepStatsDBReportGenerator_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help sleepStatsDBReportGenerator

% Last Modified by GUIDE v2.5 26-Aug-2016 16:29:36

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @sleepStatsDBReportGenerator_OpeningFcn, ...
                   'gui_OutputFcn',  @sleepStatsDBReportGenerator_OutputFcn, ...
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


% --- Executes just before sleepStatsDBReportGenerator is made visible.
function sleepStatsDBReportGenerator_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to sleepStatsDBReportGenerator (see VARARGIN)

% Choose default command line output for sleepStatsDBReportGenerator
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes sleepStatsDBReportGenerator wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = sleepStatsDBReportGenerator_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in TDT_ep.
function TDT_ep_Callback(hObject, eventdata, handles)
% hObject    handle to TDT_ep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TDT_ep


% --- Executes on button press in SPT_ep.
function SPT_ep_Callback(hObject, eventdata, handles)
% hObject    handle to SPT_ep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of SPT_ep


% --- Executes on button press in TST_ep.
function TST_ep_Callback(hObject, eventdata, handles)
% hObject    handle to TST_ep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TST_ep


% --- Executes on button press in SBSO_ep.
function SBSO_ep_Callback(hObject, eventdata, handles)
% hObject    handle to SBSO_ep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of SBSO_ep


% --- Executes on button press in WASO_ep.
function WASO_ep_Callback(hObject, eventdata, handles)
% hObject    handle to WASO_ep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of WASO_ep


% --- Executes on button press in WAFA_ep.
function WAFA_ep_Callback(hObject, eventdata, handles)
% hObject    handle to WAFA_ep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of WAFA_ep


% --- Executes on button press in SAFA_ep.
function SAFA_ep_Callback(hObject, eventdata, handles)
% hObject    handle to SAFA_ep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of SAFA_ep


% --- Executes on button press in TWT_ep.
function TWT_ep_Callback(hObject, eventdata, handles)
% hObject    handle to TWT_ep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TWT_ep


% --- Executes on button press in St1_ep.
function St1_ep_Callback(hObject, eventdata, handles)
% hObject    handle to St1_ep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of St1_ep


% --- Executes on button press in St2_ep.
function St2_ep_Callback(hObject, eventdata, handles)
% hObject    handle to St2_ep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of St2_ep


% --- Executes on button press in St3_ep.
function St3_ep_Callback(hObject, eventdata, handles)
% hObject    handle to St3_ep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of St3_ep


% --- Executes on button press in St4_ep.
function St4_ep_Callback(hObject, eventdata, handles)
% hObject    handle to St4_ep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of St4_ep


% --- Executes on button press in REM_ep.
function REM_ep_Callback(hObject, eventdata, handles)
% hObject    handle to REM_ep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of REM_ep


% --- Executes on button press in MT_ep.
function MT_ep_Callback(hObject, eventdata, handles)
% hObject    handle to MT_ep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of MT_ep


% --- Executes on button press in SW_ep.
function SW_ep_Callback(hObject, eventdata, handles)
% hObject    handle to SW_ep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of SW_ep


% --- Executes on button press in NREM_ep.
function NREM_ep_Callback(hObject, eventdata, handles)
% hObject    handle to NREM_ep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of NREM_ep


% --- Executes on button press in TDT_min.
function TDT_min_Callback(hObject, eventdata, handles)
% hObject    handle to TDT_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TDT_min


% --- Executes on button press in SPT_min.
function SPT_min_Callback(hObject, eventdata, handles)
% hObject    handle to SPT_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of SPT_min


% --- Executes on button press in TST_min.
function TST_min_Callback(hObject, eventdata, handles)
% hObject    handle to TST_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TST_min


% --- Executes on button press in SBSO_min.
function SBSO_min_Callback(hObject, eventdata, handles)
% hObject    handle to SBSO_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of SBSO_min


% --- Executes on button press in WASO_min.
function WASO_min_Callback(hObject, eventdata, handles)
% hObject    handle to WASO_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of WASO_min


% --- Executes on button press in WAFA_min.
function WAFA_min_Callback(hObject, eventdata, handles)
% hObject    handle to WAFA_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of WAFA_min


% --- Executes on button press in SAFA_min.
function SAFA_min_Callback(hObject, eventdata, handles)
% hObject    handle to SAFA_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of SAFA_min


% --- Executes on button press in TWT_min.
function TWT_min_Callback(hObject, eventdata, handles)
% hObject    handle to TWT_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TWT_min


% --- Executes on button press in St1_min.
function St1_min_Callback(hObject, eventdata, handles)
% hObject    handle to St1_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of St1_min


% --- Executes on button press in St2_min.
function St2_min_Callback(hObject, eventdata, handles)
% hObject    handle to St2_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of St2_min


% --- Executes on button press in St3_min.
function St3_min_Callback(hObject, eventdata, handles)
% hObject    handle to St3_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of St3_min


% --- Executes on button press in St4_min.
function St4_min_Callback(hObject, eventdata, handles)
% hObject    handle to St4_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of St4_min


% --- Executes on button press in REM_min.
function REM_min_Callback(hObject, eventdata, handles)
% hObject    handle to REM_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of REM_min


% --- Executes on button press in MT_min.
function MT_min_Callback(hObject, eventdata, handles)
% hObject    handle to MT_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of MT_min


% --- Executes on button press in SW_min.
function SW_min_Callback(hObject, eventdata, handles)
% hObject    handle to SW_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of SW_min


% --- Executes on button press in NREM_min.
function NREM_min_Callback(hObject, eventdata, handles)
% hObject    handle to NREM_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of NREM_min


% --- Executes on button press in TDT_TDT.
function TDT_TDT_Callback(hObject, eventdata, handles)
% hObject    handle to TDT_TDT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TDT_TDT


% --- Executes on button press in SPT_TDT.
function SPT_TDT_Callback(hObject, eventdata, handles)
% hObject    handle to SPT_TDT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of SPT_TDT


% --- Executes on button press in TST_TDT.
function TST_TDT_Callback(hObject, eventdata, handles)
% hObject    handle to TST_TDT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TST_TDT


% --- Executes on button press in SBSO_TDT.
function SBSO_TDT_Callback(hObject, eventdata, handles)
% hObject    handle to SBSO_TDT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of SBSO_TDT


% --- Executes on button press in WASO_TDT.
function WASO_TDT_Callback(hObject, eventdata, handles)
% hObject    handle to WASO_TDT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of WASO_TDT


% --- Executes on button press in WAFA_TDT.
function WAFA_TDT_Callback(hObject, eventdata, handles)
% hObject    handle to WAFA_TDT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of WAFA_TDT


% --- Executes on button press in SAFA_TDT.
function SAFA_TDT_Callback(hObject, eventdata, handles)
% hObject    handle to SAFA_TDT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of SAFA_TDT


% --- Executes on button press in TWT_TDT.
function TWT_TDT_Callback(hObject, eventdata, handles)
% hObject    handle to TWT_TDT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TWT_TDT


% --- Executes on button press in St1_TDT.
function St1_TDT_Callback(hObject, eventdata, handles)
% hObject    handle to St1_TDT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of St1_TDT


% --- Executes on button press in St2_TDT.
function St2_TDT_Callback(hObject, eventdata, handles)
% hObject    handle to St2_TDT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of St2_TDT


% --- Executes on button press in St3_TDT.
function St3_TDT_Callback(hObject, eventdata, handles)
% hObject    handle to St3_TDT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of St3_TDT


% --- Executes on button press in St4_TDT.
function St4_TDT_Callback(hObject, eventdata, handles)
% hObject    handle to St4_TDT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of St4_TDT


% --- Executes on button press in REM_TDT.
function REM_TDT_Callback(hObject, eventdata, handles)
% hObject    handle to REM_TDT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of REM_TDT


% --- Executes on button press in MT_TDT.
function MT_TDT_Callback(hObject, eventdata, handles)
% hObject    handle to MT_TDT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of MT_TDT


% --- Executes on button press in SW_TDT.
function SW_TDT_Callback(hObject, eventdata, handles)
% hObject    handle to SW_TDT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of SW_TDT


% --- Executes on button press in NREM_TDT.
function NREM_TDT_Callback(hObject, eventdata, handles)
% hObject    handle to NREM_TDT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of NREM_TDT


% --- Executes on button press in TDT_SPT.
function TDT_SPT_Callback(hObject, eventdata, handles)
% hObject    handle to TDT_SPT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TDT_SPT


% --- Executes on button press in SPT_SPT.
function SPT_SPT_Callback(hObject, eventdata, handles)
% hObject    handle to SPT_SPT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of SPT_SPT


% --- Executes on button press in TST_SPT.
function TST_SPT_Callback(hObject, eventdata, handles)
% hObject    handle to TST_SPT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TST_SPT


% --- Executes on button press in SBSO_SPT.
function SBSO_SPT_Callback(hObject, eventdata, handles)
% hObject    handle to SBSO_SPT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of SBSO_SPT


% --- Executes on button press in WASO_SPT.
function WASO_SPT_Callback(hObject, eventdata, handles)
% hObject    handle to WASO_SPT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of WASO_SPT


% --- Executes on button press in WAFA_SPT.
function WAFA_SPT_Callback(hObject, eventdata, handles)
% hObject    handle to WAFA_SPT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of WAFA_SPT


% --- Executes on button press in SAFA_SPT.
function SAFA_SPT_Callback(hObject, eventdata, handles)
% hObject    handle to SAFA_SPT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of SAFA_SPT


% --- Executes on button press in TWT_SPT.
function TWT_SPT_Callback(hObject, eventdata, handles)
% hObject    handle to TWT_SPT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TWT_SPT


% --- Executes on button press in St1_SPT.
function St1_SPT_Callback(hObject, eventdata, handles)
% hObject    handle to St1_SPT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of St1_SPT


% --- Executes on button press in St2_SPT.
function St2_SPT_Callback(hObject, eventdata, handles)
% hObject    handle to St2_SPT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of St2_SPT


% --- Executes on button press in St3_SPT.
function St3_SPT_Callback(hObject, eventdata, handles)
% hObject    handle to St3_SPT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of St3_SPT


% --- Executes on button press in St4_SPT.
function St4_SPT_Callback(hObject, eventdata, handles)
% hObject    handle to St4_SPT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of St4_SPT


% --- Executes on button press in REM_SPT.
function REM_SPT_Callback(hObject, eventdata, handles)
% hObject    handle to REM_SPT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of REM_SPT


% --- Executes on button press in MT_SPT.
function MT_SPT_Callback(hObject, eventdata, handles)
% hObject    handle to MT_SPT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of MT_SPT


% --- Executes on button press in SW_SPT.
function SW_SPT_Callback(hObject, eventdata, handles)
% hObject    handle to SW_SPT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of SW_SPT


% --- Executes on button press in NREM_SPT.
function NREM_SPT_Callback(hObject, eventdata, handles)
% hObject    handle to NREM_SPT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of NREM_SPT


% --- Executes on button press in TDT_TST.
function TDT_TST_Callback(hObject, eventdata, handles)
% hObject    handle to TDT_TST (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TDT_TST


% --- Executes on button press in SPT_TST.
function SPT_TST_Callback(hObject, eventdata, handles)
% hObject    handle to SPT_TST (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of SPT_TST


% --- Executes on button press in TST_TST.
function TST_TST_Callback(hObject, eventdata, handles)
% hObject    handle to TST_TST (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TST_TST


% --- Executes on button press in SBSO_TST.
function SBSO_TST_Callback(hObject, eventdata, handles)
% hObject    handle to SBSO_TST (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of SBSO_TST


% --- Executes on button press in WASO_TST.
function WASO_TST_Callback(hObject, eventdata, handles)
% hObject    handle to WASO_TST (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of WASO_TST


% --- Executes on button press in WAFA_TST.
function WAFA_TST_Callback(hObject, eventdata, handles)
% hObject    handle to WAFA_TST (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of WAFA_TST


% --- Executes on button press in SAFA_TST.
function SAFA_TST_Callback(hObject, eventdata, handles)
% hObject    handle to SAFA_TST (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of SAFA_TST


% --- Executes on button press in TWT_TST.
function TWT_TST_Callback(hObject, eventdata, handles)
% hObject    handle to TWT_TST (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TWT_TST


% --- Executes on button press in St1_TST.
function St1_TST_Callback(hObject, eventdata, handles)
% hObject    handle to St1_TST (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of St1_TST


% --- Executes on button press in St2_TST.
function St2_TST_Callback(hObject, eventdata, handles)
% hObject    handle to St2_TST (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of St2_TST


% --- Executes on button press in St3_TST.
function St3_TST_Callback(hObject, eventdata, handles)
% hObject    handle to St3_TST (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of St3_TST


% --- Executes on button press in St4_TST.
function St4_TST_Callback(hObject, eventdata, handles)
% hObject    handle to St4_TST (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of St4_TST


% --- Executes on button press in REM_TST.
function REM_TST_Callback(hObject, eventdata, handles)
% hObject    handle to REM_TST (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of REM_TST


% --- Executes on button press in MT_TST.
function MT_TST_Callback(hObject, eventdata, handles)
% hObject    handle to MT_TST (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of MT_TST


% --- Executes on button press in SW_TST.
function SW_TST_Callback(hObject, eventdata, handles)
% hObject    handle to SW_TST (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of SW_TST


% --- Executes on button press in NREM_TST.
function NREM_TST_Callback(hObject, eventdata, handles)
% hObject    handle to NREM_TST (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of NREM_TST


% --- Executes on button press in LOSO_ep.
function LOSO_ep_Callback(hObject, eventdata, handles)
% hObject    handle to LOSO_ep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of LOSO_ep


% --- Executes on button press in LO10_ep.
function LO10_ep_Callback(hObject, eventdata, handles)
% hObject    handle to LO10_ep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of LO10_ep


% --- Executes on button press in LOS1_ep.
function LOS1_ep_Callback(hObject, eventdata, handles)
% hObject    handle to LOS1_ep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of LOS1_ep


% --- Executes on button press in LOS2_ep.
function LOS2_ep_Callback(hObject, eventdata, handles)
% hObject    handle to LOS2_ep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of LOS2_ep


% --- Executes on button press in LOS3_ep.
function LOS3_ep_Callback(hObject, eventdata, handles)
% hObject    handle to LOS3_ep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of LOS3_ep


% --- Executes on button press in LOS4_ep.
function LOS4_ep_Callback(hObject, eventdata, handles)
% hObject    handle to LOS4_ep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of LOS4_ep


% --- Executes on button press in LOSW_ep.
function LOSW_ep_Callback(hObject, eventdata, handles)
% hObject    handle to LOSW_ep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of LOSW_ep


% --- Executes on button press in LOREM_ep.
function LOREM_ep_Callback(hObject, eventdata, handles)
% hObject    handle to LOREM_ep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of LOREM_ep


% --- Executes on button press in LOANOM_ep.
function LOANOM_ep_Callback(hObject, eventdata, handles)
% hObject    handle to LOANOM_ep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of LOANOM_ep


% --- Executes on button press in SOS1_ep.
function SOS1_ep_Callback(hObject, eventdata, handles)
% hObject    handle to SOS1_ep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of SOS1_ep


% --- Executes on button press in SOS2_ep.
function SOS2_ep_Callback(hObject, eventdata, handles)
% hObject    handle to SOS2_ep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of SOS2_ep


% --- Executes on button press in SOS3_ep.
function SOS3_ep_Callback(hObject, eventdata, handles)
% hObject    handle to SOS3_ep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of SOS3_ep


% --- Executes on button press in SOS4_ep.
function SOS4_ep_Callback(hObject, eventdata, handles)
% hObject    handle to SOS4_ep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of SOS4_ep


% --- Executes on button press in SOSW_ep.
function SOSW_ep_Callback(hObject, eventdata, handles)
% hObject    handle to SOSW_ep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of SOSW_ep


% --- Executes on button press in LOSO_min.
function LOSO_min_Callback(hObject, eventdata, handles)
% hObject    handle to LOSO_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of LOSO_min


% --- Executes on button press in LO10_min.
function LO10_min_Callback(hObject, eventdata, handles)
% hObject    handle to LO10_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of LO10_min


% --- Executes on button press in LOS1_min.
function LOS1_min_Callback(hObject, eventdata, handles)
% hObject    handle to LOS1_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of LOS1_min


% --- Executes on button press in LOS2_min.
function LOS2_min_Callback(hObject, eventdata, handles)
% hObject    handle to LOS2_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of LOS2_min


% --- Executes on button press in LOS3_min.
function LOS3_min_Callback(hObject, eventdata, handles)
% hObject    handle to LOS3_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of LOS3_min


% --- Executes on button press in LOS4_min.
function LOS4_min_Callback(hObject, eventdata, handles)
% hObject    handle to LOS4_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of LOS4_min


% --- Executes on button press in LOSW_min.
function LOSW_min_Callback(hObject, eventdata, handles)
% hObject    handle to LOSW_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of LOSW_min


% --- Executes on button press in LOREM_min.
function LOREM_min_Callback(hObject, eventdata, handles)
% hObject    handle to LOREM_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of LOREM_min


% --- Executes on button press in LOANOM_min.
function LOANOM_min_Callback(hObject, eventdata, handles)
% hObject    handle to LOANOM_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of LOANOM_min


% --- Executes on button press in SOS1_min.
function SOS1_min_Callback(hObject, eventdata, handles)
% hObject    handle to SOS1_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of SOS1_min


% --- Executes on button press in SOS2_min.
function SOS2_min_Callback(hObject, eventdata, handles)
% hObject    handle to SOS2_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of SOS2_min


% --- Executes on button press in SOS3_min.
function SOS3_min_Callback(hObject, eventdata, handles)
% hObject    handle to SOS3_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of SOS3_min


% --- Executes on button press in SOS4_min.
function SOS4_min_Callback(hObject, eventdata, handles)
% hObject    handle to SOS4_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of SOS4_min


% --- Executes on button press in SOSW_min.
function SOSW_min_Callback(hObject, eventdata, handles)
% hObject    handle to SOSW_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of SOSW_min


% --- Executes on button press in ANOM_ep.
function ANOM_ep_Callback(hObject, eventdata, handles)
% hObject    handle to ANOM_ep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ANOM_ep


% --- Executes on button press in ANOM_min.
function ANOM_min_Callback(hObject, eventdata, handles)
% hObject    handle to ANOM_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ANOM_min


% --- Executes on button press in checkbox111.
function checkbox111_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox111 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox111


% --- Executes on button press in checkbox112.
function checkbox112_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox112 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox112


% --- Executes on button press in ANOM_TST.
function ANOM_TST_Callback(hObject, eventdata, handles)
% hObject    handle to ANOM_TST (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ANOM_TST


% --- Executes on button press in SOREM_ep.
function SOREM_ep_Callback(hObject, eventdata, handles)
% hObject    handle to SOREM_ep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of SOREM_ep


% --- Executes on button press in SOREM_min.
function SOREM_min_Callback(hObject, eventdata, handles)
% hObject    handle to SOREM_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of SOREM_min


% --- Executes on button press in wake_q.
function wake_q_Callback(hObject, eventdata, handles)
% hObject    handle to wake_q (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of wake_q


% --- Executes on button press in St1_q.
function St1_q_Callback(hObject, eventdata, handles)
% hObject    handle to St1_q (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of St1_q


% --- Executes on button press in St2_q.
function St2_q_Callback(hObject, eventdata, handles)
% hObject    handle to St2_q (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of St2_q


% --- Executes on button press in St3_q.
function St3_q_Callback(hObject, eventdata, handles)
% hObject    handle to St3_q (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of St3_q


% --- Executes on button press in St4_q.
function St4_q_Callback(hObject, eventdata, handles)
% hObject    handle to St4_q (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of St4_q


% --- Executes on button press in REM_q.
function REM_q_Callback(hObject, eventdata, handles)
% hObject    handle to REM_q (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of REM_q


% --- Executes on button press in MT_q.
function MT_q_Callback(hObject, eventdata, handles)
% hObject    handle to MT_q (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of MT_q


% --- Executes on button press in Total_q.
function Total_q_Callback(hObject, eventdata, handles)
% hObject    handle to Total_q (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Total_q


% --- Executes on button press in SW_q.
function SW_q_Callback(hObject, eventdata, handles)
% hObject    handle to SW_q (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of SW_q


% --- Executes on button press in Wake_t.
function Wake_t_Callback(hObject, eventdata, handles)
% hObject    handle to Wake_t (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Wake_t


% --- Executes on button press in St1_t.
function St1_t_Callback(hObject, eventdata, handles)
% hObject    handle to St1_t (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of St1_t


% --- Executes on button press in St2_t.
function St2_t_Callback(hObject, eventdata, handles)
% hObject    handle to St2_t (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of St2_t


% --- Executes on button press in St3_t.
function St3_t_Callback(hObject, eventdata, handles)
% hObject    handle to St3_t (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of St3_t


% --- Executes on button press in St4_t.
function St4_t_Callback(hObject, eventdata, handles)
% hObject    handle to St4_t (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of St4_t


% --- Executes on button press in REM_t.
function REM_t_Callback(hObject, eventdata, handles)
% hObject    handle to REM_t (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of REM_t


% --- Executes on button press in MT_t.
function MT_t_Callback(hObject, eventdata, handles)
% hObject    handle to MT_t (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of MT_t


% --- Executes on button press in Total_t.
function Total_t_Callback(hObject, eventdata, handles)
% hObject    handle to Total_t (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Total_t


% --- Executes on button press in SW_t.
function SW_t_Callback(hObject, eventdata, handles)
% hObject    handle to SW_t (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of SW_t


% --- Executes on button press in Wake_half.
function Wake_half_Callback(hObject, eventdata, handles)
% hObject    handle to Wake_half (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Wake_half


% --- Executes on button press in St1_half.
function St1_half_Callback(hObject, eventdata, handles)
% hObject    handle to St1_half (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of St1_half


% --- Executes on button press in St2_half.
function St2_half_Callback(hObject, eventdata, handles)
% hObject    handle to St2_half (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of St2_half


% --- Executes on button press in St3_half.
function St3_half_Callback(hObject, eventdata, handles)
% hObject    handle to St3_half (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of St3_half


% --- Executes on button press in St4_half.
function St4_half_Callback(hObject, eventdata, handles)
% hObject    handle to St4_half (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of St4_half


% --- Executes on button press in REM_half.
function REM_half_Callback(hObject, eventdata, handles)
% hObject    handle to REM_half (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of REM_half


% --- Executes on button press in MT_half.
function MT_half_Callback(hObject, eventdata, handles)
% hObject    handle to MT_half (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of MT_half


% --- Executes on button press in Total_half.
function Total_half_Callback(hObject, eventdata, handles)
% hObject    handle to Total_half (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Total_half


% --- Executes on button press in SW_half.
function SW_half_Callback(hObject, eventdata, handles)
% hObject    handle to SW_half (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of SW_half


% --- Executes on button press in Wake_hr.
function Wake_hr_Callback(hObject, eventdata, handles)
% hObject    handle to Wake_hr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Wake_hr


% --- Executes on button press in St1_hr.
function St1_hr_Callback(hObject, eventdata, handles)
% hObject    handle to St1_hr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of St1_hr


% --- Executes on button press in St2_hr.
function St2_hr_Callback(hObject, eventdata, handles)
% hObject    handle to St2_hr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of St2_hr


% --- Executes on button press in St3_hr.
function St3_hr_Callback(hObject, eventdata, handles)
% hObject    handle to St3_hr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of St3_hr


% --- Executes on button press in St4_hr.
function St4_hr_Callback(hObject, eventdata, handles)
% hObject    handle to St4_hr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of St4_hr


% --- Executes on button press in REM_hr.
function REM_hr_Callback(hObject, eventdata, handles)
% hObject    handle to REM_hr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of REM_hr


% --- Executes on button press in MT_hr.
function MT_hr_Callback(hObject, eventdata, handles)
% hObject    handle to MT_hr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of MT_hr


% --- Executes on button press in Total_hr.
function Total_hr_Callback(hObject, eventdata, handles)
% hObject    handle to Total_hr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Total_hr


% --- Executes on button press in SW_hr.
function SW_hr_Callback(hObject, eventdata, handles)
% hObject    handle to SW_hr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of SW_hr


% --- Executes on button press in transitions.
function transitions_Callback(hObject, eventdata, handles)
% hObject    handle to transitions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of transitions


% --- Executes on button press in lightsOFFON.
function lightsOFFON_Callback(hObject, eventdata, handles)
% hObject    handle to lightsOFFON (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of lightsOFFON


% --- Executes on button press in cycleSum.
function cycleSum_Callback(hObject, eventdata, handles)
% hObject    handle to cycleSum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cycleSum


% --- Executes on button press in lastStage.
function lastStage_Callback(hObject, eventdata, handles)
% hObject    handle to lastStage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of lastStage


% --- Executes on button press in EDFName.
function EDFName_Callback(hObject, eventdata, handles)
% hObject    handle to EDFName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of EDFName


% --- Executes on button press in scorer.
function scorer_Callback(hObject, eventdata, handles)
% hObject    handle to scorer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of scorer


% --- Executes on button press in epLength.
function epLength_Callback(hObject, eventdata, handles)
% hObject    handle to epLength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of epLength


% --- Executes on button press in uploadDate.
function uploadDate_Callback(hObject, eventdata, handles)
% hObject    handle to uploadDate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of uploadDate


% --- Executes on button press in saveTemplate.
function saveTemplate_Callback(hObject, eventdata, handles)
% hObject    handle to saveTemplate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in loadTemplate.
function loadTemplate_Callback(hObject, eventdata, handles)
% hObject    handle to loadTemplate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in allArch.
function allArch_Callback(hObject, eventdata, handles)
% hObject    handle to allArch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of allArch


% --- Executes on button press in allSplit.
function allSplit_Callback(hObject, eventdata, handles)
% hObject    handle to allSplit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of allSplit


% --- Executes on button press in allLat.
function allLat_Callback(hObject, eventdata, handles)
% hObject    handle to allLat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of allLat
