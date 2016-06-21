function varargout = h_compression(varargin)
% H_COMPRESSION M-file for h_compression.fig
%      H_COMPRESSION, by itself, creates a new H_COMPRESSION or raises the existing
%      singleton*.
%
%      H = H_COMPRESSION returns the handle to a new H_COMPRESSION or the handle to
%      the existing singleton*.
%
%      H_COMPRESSION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in H_COMPRESSION.M with the given input arguments.
%
%      H_COMPRESSION('Property','Value',...) creates a new H_COMPRESSION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before h_compression_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to h_compression_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help h_compression

% Last Modified by GUIDE v2.5 26-Mar-2014 17:18:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @h_compression_OpeningFcn, ...
                   'gui_OutputFcn',  @h_compression_OutputFcn, ...
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


% --- Executes just before h_compression is made visible.
function h_compression_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to h_compression (see VARARGIN)

% Choose default command line output for h_compression
handles.output = hObject;
set(handles.lbl_compress,'string','');
set(handles.lbl_decompress,'string','');
set(handles.lbl_analysis,'string','');
set(handles.txt_input,'string','');
set(handles.txt_output,'string','');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes h_compression wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = h_compression_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function txt_input_Callback(hObject, eventdata, handles)
% hObject    handle to txt_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txt_input as text
%        str2double(get(hObject,'String')) returns contents of txt_input as a double


% --- Executes during object creation, after setting all properties.
function txt_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txt_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in cmd_input.
function cmd_input_Callback(hObject, eventdata, handles)
% hObject    handle to cmd_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.output = hObject;
[filename, i_path] = uigetfile({'*.bmp';'*.*'}, 'Pick an Input Image File');
set(handles.txt_input,'string',i_path);
S = imread([i_path,filename]);
axes(handles.fig_input);
imshow(S);
handles.i_path = i_path;
handles.filename = filename;
len_file = length(filename);
len_file = len_file - 4
for i = 1 : len_file
    o_file(1,i) = filename(1,i)
end
o_path = strcat(i_path,o_file,'.vans');
handles.o_path = o_path;
handles.S = S;
guidata(hObject, handles);



function txt_output_Callback(hObject, eventdata, handles)
% hObject    handle to txt_output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txt_output as text
%        str2double(get(hObject,'String')) returns contents of txt_output as a double


% --- Executes during object creation, after setting all properties.
function txt_output_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txt_output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in cmd_output.
function cmd_output_Callback(hObject, eventdata, handles)
% hObject    handle to cmd_output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.output = hObject;
[cfilename, c_path] = uigetfile({'*.vans'}, 'Pick an Valid Compressed File');
set(handles.txt_output,'string',c_path);
handles.c_path = c_path;
handles.cfilename = cfilename;
guidata(hObject, handles);

% --- Executes on button press in cmd_compress.
function cmd_compress_Callback(hObject, eventdata, handles)
% hObject    handle to cmd_compress (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.output = hObject;
if length(get(handles.txt_input,'String')) == 0 
    msgbox(strcat('Select Input File First.'),'Notification');  %Display Notification
    return;
end
set(handles.lbl_compress,'string','Compression Done.');
S = handles.S;
o_path = handles.o_path;
i_path = handles.i_path;
compress(S,i_path,o_path)
guidata(hObject, handles);

% --- Executes on button press in cmd_decompress.
function cmd_decompress_Callback(hObject, eventdata, handles)
% hObject    handle to cmd_decompress (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.output = hObject;
if length(get(handles.txt_output,'String')) == 0 
    msgbox(strcat('Select Output File First.'),'Notification');  %Display Notification
    return;
end
set(handles.lbl_decompress,'string','Decompression Done.');
c_path = handles.c_path;
cfilename = handles.cfilename;
de_in = strcat(c_path,cfilename);
[o_image] = decompress(de_in);
handles.o_image = o_image;
axes(handles.fig_output);
imshow(o_image);
frmt = strcat(cfilename,'.jpg');
imwrite(o_image,frmt,'jpeg');
guidata(hObject, handles);

% --- Executes on button press in cmd_analysis.
function cmd_analysis_Callback(hObject, eventdata, handles)
% hObject    handle to cmd_analysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.output = hObject;

if length(get(handles.txt_input,'String')) == 0 
    msgbox(strcat('Select Input File First.'),'Notification for analysis');  %Display Notification
    return;
end
if length(get(handles.lbl_decompress,'String')) == 0 
    msgbox(strcat('Decompress the file first.'),'Notification for analysis');  %Display Notification
    return;
end
o_image = handles.o_image;
S = handles.S;
s_r = SINR(S,o_image);
s_r = mean(s_r);
s_rr=num2str(s_r)
s_r1 = strcat('SINR: ', s_rr,'DB');
set(handles.lbl_analysis,'string',s_r1);
figure(2);
subplot(211)
imhist(o_image(:,:,1));title('Reconstructed image histogram');
subplot(212)
imhist(S(:,:,1))
guidata(hObject, handles);title('Input image histogram');
