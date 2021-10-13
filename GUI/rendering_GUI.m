function varargout = rendering_GUI(varargin)
% RENDERING_GUI MATLAB code for rendering_GUI.fig
%      RENDERING_GUI, by itself, creates a new RENDERING_GUI or raises the existing
%      singleton*.
%
%      H = RENDERING_GUI returns the handle to a new RENDERING_GUI or the handle to
%      the existing singleton*.
%
%      RENDERING_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RENDERING_GUI.M with the given input arguments.
%
%      RENDERING_GUI('Property','Value',...) creates a new RENDERING_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before rendering_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to rendering_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help rendering_GUI

% Last Modified by GUIDE v2.5 17-May-2018 17:07:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @rendering_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @rendering_GUI_OutputFcn, ...
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


% --- Executes just before rendering_GUI is made visible.
function rendering_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to rendering_GUI (see VARARGIN)

% Choose default command line output for rendering_GUI
handles.output = hObject;

 bh = axes('unit', 'normalized', 'position',[0.07 0.07 0.55 0.8]);
bg = imread('rendering.png'); imagesc(bg);
 set(bh,'handlevisibility','off', 'visible','off')
%   uistack(bh,'bottom');
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes rendering_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = rendering_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over text3.
function text3_ButtonDownFcn(hObject, eventdata, handles) 

% hObject    handle to text3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
global input;
global Fs;
[file,path] = uigetfile({'*.wav'},'Load data file');
if file ~= 0
    if strcmp(file(length(file)-2:end),'wav')   
        [input,fs1] = audioread([path file]);
       input=input(:,1);
        Fs = fs1;
     
    elseif strcmp(file(length(file)-2:end),'mp3')   
    [input,fs1] = audioread([path file]);
     input=input(:,1);
        Fs = fs1;
else
    return;
end
end
 input=input';
% input=input(1:Fs*30,1)';

% handles.axes1; plot(input);
% targetaxis = handles.axes1;

% uicontrol('Style', 'text', 'String', [num2str(file)], 'Position', [690 349 113 32]);
% uicontrol('Style', 'text', 'String', [num2str(Fs),'Hz'], 'Position', [690 292 88 25]); % Samplling Rate 표시
handles.text7.String = num2str(Fs);
handles.text5.String = num2str(file);


% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in popupmenu3.
function popupmenu3_Callback(hObject, eventdata, handles)
global v;
switch hObject.Value
    case 1 
        v=2;
    case 2
        v=4;
    case 3
        v=6;
    case 4
        v=8;
    case 5 
        v=10;
    case 6 
        v=20;
end
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu3


% --- Executes during object creation, after setting all properties.
function popupmenu3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu4.
function popupmenu4_Callback(hObject, eventdata, handles)
global select;
switch hObject.Value
    case 1
       select = 1;%적용안       
    case 2 
     select=2;
 
end

% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu4


% --- Executes during object creation, after setting all properties.
function popupmenu4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.


% hObject    handle to axes5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes5


% --- Executes during object deletion, before destroying properties.


% hObject    handle to axes5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
global v;
global input;
global Fs;
global select;
global player;
Nfft=2048;
Nfrm=Nfft/2;
switch select%movingtarget_windowing
      case 1%counterclock
          a=-1;
          m=99;
        renderingsound=windowrendering_STFT(Nfrm,m,v,a);
        
    case 2 %clock
        a=1;
        m=1;
       renderingsound=windowrendering_STFT(Nfrm,m,v,a);

end

player=audioplayer(renderingsound,Fs);
play(player);
global pauseflag;
pauseflag = 0;

% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
global pauseflag;
global player;
if pauseflag == 0 && strcmp(player.Running, 'on')
    pause(player);
    pauseflag = 1;
else if pauseflag ==1
    resume(player);
    pauseflag = 0;
    end
end

% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
global pauseflag;
global player;
if pauseflag == 0 && strcmp(player.Running, 'on')
    stop(player);
else if pauseflag ==1
    stop(player);
    end
end
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
