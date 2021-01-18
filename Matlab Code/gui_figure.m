function varargout = gui_figure(varargin)
% gui_figure MATLAB code for gui_figure.fig
%      gui_figure, by itself, creates a new gui_figure or raises the existing
%      singleton*.
%
%      H = gui_figure returns the handle to a new gui_figure or the handle to
%      the existing singleton*.
%
%      gui_figure('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in gui_figure.M with the given input arguments.
%
%      gui_figure('Property','Value',...) creates a new gui_figure or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the gui_figure before gui_figure_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      Stop.  All inputs are passed to gui_figure_OpeningFcn via varargin.
%
%      *See gui_figure Options on GUIDE's Tools menu.  Choose "gui_figure allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_figure

% Last Modified by GUIDE v2.5 28-Jul-2016 15:34:50

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_figure_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_figure_OutputFcn, ...
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


% --- Executes just before gui_figure is made visible.
function gui_figure_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui_figure (see VARARGIN)

% Choose default command line output for gui_figure
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui_figure wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_figure_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Browse.
function Browse_Callback(hObject, eventdata, handles)
    global gui;
    
    gui.browse();
    
    
% --- Executes on button press in Start.
function Start_Callback(hObject, eventdata, handles)
    global gui;
    
    gui.start();


% --- Executes on button press in Stop.
function Stop_Callback(hObject, eventdata, handles)
% hObject    handle to Stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    global gui;
    
    gui.stop();


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 global gui;
    
    gui.exit();