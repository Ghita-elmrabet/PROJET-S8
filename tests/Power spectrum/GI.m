function varargout = GI(varargin)
% GI MATLAB code for GI.fig
%      GI, by itself, creates a new GI or raises the existing
%      singleton*.
%
%      H = GI returns the handle to a new GI or the handle to
%      the existing singleton*.
%
%      GI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GI.M with the given input arguments.
%
%      GI('Property','Value',...) creates a new GI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GI

% Last Modified by GUIDE v2.5 17-Mar-2021 20:48:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GI_OpeningFcn, ...
                   'gui_OutputFcn',  @GI_OutputFcn, ...
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


% --- Executes just before GI is made visible.
function GI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GI (see VARARGIN)
% Choose default command line output for GI
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double



% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox3.
function checkbox3_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox3


% --- Executes on button press in checkbox4.
function checkbox4_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox4


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1


% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton6.
function [p_ar]=pushbutton6_Callback(hObject, eventdata, handles)
addpath('../../src/Power spectrum/');
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
N=5000; %nombre d'echantillions
p=4; %ordre du processus AR
sigma=0.5; %variance du BBGC
m=0; %centré
% axe des frequences
n=2^nextpow2(N);
f=-1/2:1/n:1/2-1/n;
%géneration des poles
 theta=[7*pi/9,2*pi/9];
 R=[0.9 0.9 0.98 ];
 p1=R(1)*exp(1j*theta(1));
 p2=R(2)*exp(1j*theta(2));
 P=[p1,p2,conj(p1),conj(p2)];
 % génération du signal
 nom=[1,0,0,0,0];
 denom=poly(P);
 b=m+sigma*randn(1,N);% bruit blanc gaussien
 p_ar=filter(nom,denom,b); % processus AR ( signal à traiter)
 axes(handles.axes5);
 hold on
 title('Représentation temporelle du processus')
 xlabel('Axe des temps');
 ylabel('Amplitudes');
 plot(p_ar);
 
% saisie de l'intervalle des fréquneces
f1=str2double(get(handles.edit1,'string')); 
f2=str2double(get(handles.edit2,'string'));
if get(handles.checkbox1,'Value') && get(handles.checkbox4,'Value') 
     dsp=LPC(f,p_ar,sigma,p,1);
     axes(handles.axes6);
     hold on
     xline(f1,'r')
     xline(f2,'r')
     title('Densité spectrale de puissance du processus autoregressif')
     xlabel('Axe des fréquences');
     ylabel('Amplitudes');
     plot(f,dsp,'r');
    %Calcul d'air meth des rectangles
     pw=aire_rec(f,dsp,f1,f2);
end
if get(handles.checkbox1,'Value') && get(handles.checkbox3,'Value') 
    dsp=wiener(f,p_ar,n);
    axes(handles.axes6);
     hold on
     xline(f1,'r')
     xline(f2,'r')
     title('spectre de puissance du processus ')
     xlabel('Axe des fréquences');
     ylabel('Amplitudes');
     plot(f,dsp,'b');
     %Calcul d'air meth des rectangles
     pw=aire_rec(f,dsp,f1,f2);
end

if get(handles.checkbox2,'Value') && get(handles.checkbox3,'Value') 
    dsp=wiener(f,p_ar,n);
    axes(handles.axes6);
     hold on
     xline(f1,'r')
     xline(f2,'r')
     title('spectre de puissance du processus ')
     xlabel('Axe des fréquences');
     ylabel('Amplitudes');
     plot(f,dsp,'b');
     %Calcul d'air meth des trapezes
     pw=aire_trapeze(f,dsp,f1,f2);
end

if get(handles.checkbox2,'Value') && get(handles.checkbox4,'Value') 
     dsp=LPC(f,p_ar,sigma,p,1);
     axes(handles.axes6);
     hold on
     xline(f1,'r')
     xline(f2,'r')
     title('Densité spectrale de puissance du processus autoregressif')
     xlabel('Axe des fréquences');
     ylabel('Amplitudes');
     plot(f,dsp,'r');
    %Calcul d'air meth des trapezes
     pw=aire_trapeze(f,dsp,f1,f2);
end

set(handles.edit3,'string',pw);


% --- Executes during object creation, after setting all properties.
function axes5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes5


% --- Executes during object creation, after setting all properties.
function axes6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes6
