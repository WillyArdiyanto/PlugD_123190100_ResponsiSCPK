function varargout = spksaw(varargin)
% SPKSAW MATLAB code for spksaw.fig
%      SPKSAW, by itself, creates a new SPKSAW or raises the existing
%      singleton*.
%
%      H = SPKSAW returns the handle to a new SPKSAW or the handle to
%      the existing singleton*.
%
%      SPKSAW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SPKSAW.M with the given input arguments.
%
%      SPKSAW('Property','Value',...) creates a new SPKSAW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before spksaw_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to spksaw_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help spksaw

% Last Modified by GUIDE v2.5 25-Jun-2021 20:15:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @spksaw_OpeningFcn, ...
                   'gui_OutputFcn',  @spksaw_OutputFcn, ...
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


% --- Executes just before spksaw is made visible.
function spksaw_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to spksaw (see VARARGIN)

% Choose default command line output for spksaw
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes spksaw wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = spksaw_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btn_tampil.
function btn_tampil_Callback(hObject, eventdata, handles)
% hObject    handle to btn_tampil (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%output data dengan tombol, proses import data dibawah
data = readmatrix('DATA RUMAH edited.xlsx');
set(handles.uitable1,'data',data);

% --- Executes on button press in btn_proses.
function btn_proses_Callback(hObject, eventdata, handles)
% hObject    handle to btn_proses (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%import data untuk proses
data = readmatrix('DATA RUMAH edited.xlsx');
No=data(:,1);
sisa=data(:,2:7);
x = [No sisa];
%no rumah saya masukan atribut supaya ikut diproses :)
%nilai atribut, dimana 0= atribut biaya &1= atribut keuntungan
k=[1,0,1,1,1,1,1];
% bobot untuk masing-masing kriteria
w=[0.00,0.30,0.20,0.23,0.10,0.07,0.10];
%tahapan 1. normalisasi matriks
%matriks m x n dengan ukuran sebanyak variabel x (input)
[m n]=size (x); 
%membuat matriks R, yang merupakan matriks kosong
R=zeros (m,n); 
%membuat matriks Y, yang merupakan titik kosong
Y=zeros (m,n);
for j=1:n
    %statement untuk kriteria dengan atribut keuntungan
     if k(j)==1 
  R(:,j)=x(:,j)./max(x(:,j));
 else
  R(:,j)=min(x(:,j))./x(:,j);
     end
end
%tahapan 2. perangkingan
for i=1:m
 V(i,:)= sum(w.*R(i,:));
end
V=[No V];
%pengurutan data dengan parameter kolom ke2
result=sortrows(V,2,'descend');
%pemilihan 20 terbaik
selected_result=result(1:20,:);
%penampilan data di uitable2
set(handles.uitable2,'data',selected_result);
