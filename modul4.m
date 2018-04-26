function varargout = modul4(varargin)
% MODUL4 MATLAB code for modul4.fig
%      MODUL4, by itself, creates a new MODUL4 or raises the existing
%      singleton*.
%
%      H = MODUL4 returns the handle to a new MODUL4 or the handle to
%      the existing singleton*.
%
%      MODUL4('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MODUL4.M with the given input arguments.
%
%      MODUL4('Property','Value',...) creates a new MODUL4 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before modul4_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to modul4_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help modul4

% Last Modified by GUIDE v2.5 26-Apr-2018 19:25:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @modul4_OpeningFcn, ...
                   'gui_OutputFcn',  @modul4_OutputFcn, ...
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


% --- Executes just before modul4 is made visible.
function modul4_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to modul4 (see VARARGIN)

% Choose default command line output for modul4
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes modul4 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = modul4_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btn_open.
function btn_open_Callback(hObject, eventdata, handles)
% hObject    handle to btn_open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    [filename, pathname] = uigetfile({'*.jpg';'*.bmp';'*.png'},'File Selector');
    handles.gambar = imread(strcat(pathname, filename));    
    axes(handles.axes1);
    imshow(handles.gambar);
    setappdata(handles.btn_open,'gambar_saved',handles.gambar);
    
    guidata(hObject, handles);

% --- Executes on button press in dilasi_btn.
function dilasi_btn_Callback(hObject, eventdata, handles)
% hObject    handle to dilasi_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    gambar = getappdata(handles.btn_open,'gambar_saved');
    bin = im2bw(gambar,graythresh(gambar));
    sq = ones(3,3);
    citra_hasil = imdilate(gambar,sq);    
    axes(handles.axes2);
    imshow(citra_hasil);
    
    
% --- Executes on button press in erosi.
function erosi_Callback(hObject, eventdata, handles)
% hObject    handle to erosi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    gambar = getappdata(handles.btn_open,'gambar_saved');
    bin = im2bw(gambar,graythresh(gambar));
    sq = ones(3,3);
    citra_hasil = imerode(gambar,sq);    
    axes(handles.axes3);
    imshow(citra_hasil);

% --- Executes on button press in opening_btn.
function opening_btn_Callback(hObject, eventdata, handles)
% hObject    handle to opening_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    gambar = getappdata(handles.btn_open,'gambar_saved');
    bin = im2bw(gambar,graythresh(gambar));
    sq = ones(3,3);
    citra_erosi = imerode(bin,sq);
    citra_hasil = imdilate (citra_erosi, sq);
    axes(handles.axes2);
    imshow(citra_hasil);

% --- Executes on button press in closing_btn.
function closing_btn_Callback(hObject, eventdata, handles)
% hObject    handle to closing_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    gambar = getappdata(handles.btn_open,'gambar_saved');
    bin = im2bw(gambar,graythresh(gambar));
    sq = ones(3,3);
    citra_dilasi = imdilate(bin,sq);
    citra_hasil = imerode (citra_dilasi, sq);
    axes(handles.axes3);
    imshow(citra_hasil);

% --- Executes on button press in thining_btn.
function thining_btn_Callback(hObject, eventdata, handles)
% hObject    handle to thining_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    gambar = getappdata(handles.btn_open,'gambar_saved');
    bin = im2bw(gambar,graythresh(gambar));
    citra_hasil = bwmorph(bin,'thin',Inf);
    axes(handles.axes2);
    imshow(citra_hasil);

% --- Executes on button press in sobel_btn.
function sobel_btn_Callback(hObject, eventdata, handles)
% hObject    handle to sobel_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    gambar = getappdata(handles.btn_open,'gambar_saved');
    bin = im2bw(gambar,graythresh(gambar));
    sHor = edge(bin,'sobel','horizontal');
        axes(handles.axes2);
        imshow(sHor);
    sVer = edge(bin,'sobel','vertical');
        axes(handles.axes3);
        imshow(sVer);
    sGmag = imgradient(bin,'sobel');
        axes(handles.axes4);
        imshow(sGmag);

% --- Executes on button press in prewitt_btn.
function prewitt_btn_Callback(hObject, eventdata, handles)
% hObject    handle to prewitt_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    gambar = getappdata(handles.btn_open,'gambar_saved');
    bin = im2bw(gambar,graythresh(gambar));
    pHor = edge(bin,'prewitt','horizontal');
        axes(handles.axes2);
        imshow(pHor);
    pVer = edge(bin,'prewitt','vertical');
        axes(handles.axes3);
        imshow(pVer);
    pGmag = imgradient(bin,'prewitt');
        axes(handles.axes4);
        imshow(pGmag);

% --- Executes on button press in robert_btn.
function robert_btn_Callback(hObject, eventdata, handles)
% hObject    handle to robert_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    gambar = getappdata(handles.btn_open,'gambar_saved');
    bin = im2bw(gambar,graythresh(gambar));
    rHor = edge(bin,'roberts','horizontal');
        axes(handles.axes2);
        imshow(rHor);
    rVer = edge(bin,'roberts','vertical');
        axes(handles.axes3);
        imshow(rVer);
    rGmag = imgradient(bin,'roberts');
        axes(handles.axes4);
        imshow(rGmag);


% --- Executes on button press in canny_btn.
function canny_btn_Callback(hObject, eventdata, handles)
% hObject    handle to canny_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    gambar = getappdata(handles.btn_open,'gambar_saved');
    bin = im2bw(gambar,graythresh(gambar));
    canny = edge(bin,'canny');
    axes(handles.axes2);
    imshow(canny);

% --- Executes on button press in log_btn.
function log_btn_Callback(hObject, eventdata, handles)
% hObject    handle to log_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    gambar = getappdata(handles.btn_open,'gambar_saved');
    bin = im2bw(gambar,graythresh(gambar));
    log = edge(bin,'log');
    axes(handles.axes3);
    imshow(log);

% --- Executes on button press in region_btn.
function region_btn_Callback(hObject, eventdata, handles)
% hObject    handle to region_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in water_btn.
function water_btn_Callback(hObject, eventdata, handles)
% hObject    handle to water_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    
% --- Executes on button press in exit_btn.
function exit_btn_Callback(hObject, eventdata, handles)
% hObject    handle to exit_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    close;
