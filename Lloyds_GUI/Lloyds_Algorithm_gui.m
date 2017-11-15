function varargout = Lloyds_Algorithm_gui(varargin)
% LLOYDS_ALGORITHM_GUI MATLAB code for Lloyds_Algorithm_gui.fig
%      LLOYDS_ALGORITHM_GUI, by itself, creates a new LLOYDS_ALGORITHM_GUI or raises the existing
%      singleton*.
%
%      H = LLOYDS_ALGORITHM_GUI returns the handle to a new LLOYDS_ALGORITHM_GUI or the handle to
%      the existing singleton*.
%
%      LLOYDS_ALGORITHM_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LLOYDS_ALGORITHM_GUI.M with the given input arguments.
%
%      LLOYDS_ALGORITHM_GUI('Property','Value',...) creates a new LLOYDS_ALGORITHM_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Lloyds_Algorithm_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop_button.  All inputs are passed to Lloyds_Algorithm_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Lloyds_Algorithm_gui

% Last Modified by GUIDE v2.5 24-Aug-2017 16:33:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Lloyds_Algorithm_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @Lloyds_Algorithm_gui_OutputFcn, ...
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


% --- Executes just before Lloyds_Algorithm_gui is made visible.
function Lloyds_Algorithm_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Lloyds_Algorithm_gui (see VARARGIN)

% Choose default command line output for Lloyds_Algorithm_gui
handles.output = hObject;


% Update handles structure
guidata(hObject, handles);


axes(handles.agent_figure);
xlabel('x', 'FontSize', 15);
ylabel('y', 'FontSize', 15);
title('Arena','FontSize',15)
axes(handles.coverage_figure);
set(handles.coverage_figure, 'YLim', [0,101]);
xlabel('Iteration Number', 'FontSize', 8);
ylabel('Percent Covered', 'FontSize', 8);
title('Coverage','FontSize',10)
axes(handles.distance_figure);
xlabel('Iteration Number', 'FontSize', 8);
axes(handles.com_figure);
xlabel('x', 'FontSize', 8);
ylabel('y', 'FontSize', 8);
title('Communication Graph','FontSize',10);
if exist('agentData.xlsx') ~= 0
   delete('agentData.xlsx')
end
if exist('p_value.mat') ~= 0
    delete('p_value.mat');
end
if exist('Percent_Covered_stopped.mat') ~= 0
    delete('Percent_Covered_stopped.mat');
end
if exist('Stopped_Agent_Positions.mat') ~= 0
    delete('Stopped_Agent_Positions.mat');
end
if exist('Distance_travelled_stopped.mat') ~= 0
    delete('Distance_travelled_stopped.mat');
end
if exist('Density.mat') ~= 0
    delete('Density.mat');
end
if exist('E_stopped.mat') ~= 0
    delete('E_stopped.mat');
end


% UIWAIT makes Lloyds_Algorithm_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Lloyds_Algorithm_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function Number_of_Agents_Callback(hObject, eventdata, handles)
% hObject    handle to Number_of_Agents (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Number_of_Agents as text
%        str2double(get(hObject,'String')) returns contents of Number_of_Agents as a double
Number_of_Agents = str2num(get(hObject,'String'));
set(handles.uitable1,'Data',cell(Number_of_Agents,2));


% --- Executes during object creation, after setting all properties.
function Number_of_Agents_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Number_of_Agents (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sides_Callback(hObject, eventdata, handles)
% hObject    handle to sides (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sides as text
%        str2double(get(hObject,'String')) returns contents of sides as a double


% --- Executes during object creation, after setting all properties.
function sides_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sides (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Partition_Number_Callback(hObject, eventdata, handles)
% hObject    handle to Partition_Number (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Partition_Number as text
%        str2double(get(hObject,'String')) returns contents of Partition_Number as a double


% --- Executes during object creation, after setting all properties.
function Partition_Number_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Partition_Number (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function radius_Callback(hObject, eventdata, handles)
% hObject    handle to radius (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of radius as text
%        str2double(get(hObject,'String')) returns contents of radius as a double


% --- Executes during object creation, after setting all properties.
function radius_CreateFcn(hObject, eventdata, handles)
% hObject    handle to radius (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function velocity_Callback(hObject, eventdata, handles)
% hObject    handle to velocity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of velocity as text
%        str2double(get(hObject,'String')) returns contents of velocity as a double


% --- Executes during object creation, after setting all properties.
function velocity_CreateFcn(hObject, eventdata, handles)
% hObject    handle to velocity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Velocity_Type.
function Velocity_Type_Callback(hObject, eventdata, handles)
% hObject    handle to Velocity_Type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Velocity_Type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Velocity_Type


% --- Executes during object creation, after setting all properties.
function Velocity_Type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Velocity_Type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in random_positions.
function random_positions_Callback(hObject, eventdata, handles)
% hObject    handle to random_positions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
d = 2;
Number_of_Agents = str2num(get(handles.Number_of_Agents,'String'));
sides = str2num(get(handles.sides,'String'));
Partition_Number = str2num(get(handles.Partition_Number,'String'));
[Agent_Positions] = Density_Position_Generator(Number_of_Agents,2,sides,Partition_Number);
set(handles.uitable1,'data',Agent_Positions);

% --- Executes on button press in stop_button.
function stop_button_Callback(hObject, eventdata, handles)
global data
% hObject    handle to stop_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
setter = true;
set(handles.stop_button, 'UserData',setter);

% --- Executes on button press in start.
function start_Callback(hObject, eventdata, handles)
global Density_mat
% hObject    handle to start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%handles.stop_button = [];
%% Get initial inputs
syms x y z
Number_of_Agents = str2num(get(handles.Number_of_Agents,'String'));
sides = str2num(get(handles.sides,'String'));
Partition_Number = str2num(get(handles.Partition_Number,'String'));
r_o = str2num(get(handles.radius,'String')); %this is the radius of observation
r_c = str2num(get(handles.radius_com,'String'));
Density_Type = get(handles.Density_Type,'Value');
Density_variation_type = get(handles.iteration_vary_button,'Value'); % 1 means constant, 2 means iteration varying density
max_velocity = str2num(get(handles.max_velocity,'String'));
delay = str2num(get(handles.delay_button,'String'));
algorithm_type = get(handles.algorithm_type_button,'Value');
final_iteration = str2num(get(handles.final_iteration,'String'));
for i = 1:Number_of_Agents
    colours_energy(i,:) = rand(1,3); % Generate colours for energy example
end
%% Determine Velocity Type
Velocity_Type = get(handles.Velocity_Type,'Value');
if Velocity_Type == 1
    velocity = str2num(get(handles.velocity,'String'));
    MOVEMENTSCALE = 1;
elseif Velocity_Type == 2
    velocity = 1;
    MOVEMENTSCALE = str2num(get(handles.velocity,'String'));
end

%% Check Stop/Reset
if ~isempty(get(handles.stop_button,'UserData')) && isempty(get(handles.reset_button,'UserData')) %Stope was pressed, but reset was not.
    set(handles.stop_button, 'UserData',[]);
    stop_pressed_before = 1;
    Agent_Positions = saved_file2mat('Stopped_Agent_Positions');
    p = saved_file2mat('p_value');
    Percent_Covered_stopped = saved_file2mat('Percent_Covered_stopped');
    distance_travelled_stopped = saved_file2mat('Distance_travelled_stopped');
    reset_pressed = 0;
    History = xlsread('agentData.xlsx',1);
    Density = saved_file2mat('Density');
    E_stopped = saved_file2mat('Energy_stopped');
    
elseif isempty(get(handles.stop_button,'UserData')) && isempty(get(handles.reset_button,'UserData')) %Neither stop nor reset were pressed.
    stop_pressed_before = 0;
    Agent_Positions = get(handles.uitable1,'data');
    p = 1;
    Percent_Covered_stopped = [0];
    distance_travelled_stopped = 0;
    E_stopped = zeros(1,Number_of_Agents);
    reset_pressed = 0;
    History = [];
    for i = 1 : Number_of_Agents
        History(1:1,(2*i-1):2*i) = Agent_Positions(i,1:2);
    end
    
    if Density_Type == 1
        Density = sym(get(handles.density_function,'String'));
        disp(Density)
    elseif Density_Type == 2
        Density = Density_mat;
    end
elseif ~isempty(get(handles.reset_button,'UserData')) %Reset was pressed
    set(handles.reset_button,'UserData',[]);
    reset_pressed = 1;
    stop_pressed_before = 0;
    Agent_Positions = get(handles.uitable1,'data');
    p = 1;
    Percent_Covered_stopped = [0];
    distance_travelled_stopped = 0;
    E_stopped = zeros(1,Number_of_Agents);
    if exist('p_value.mat') ~= 0
        delete('p_value.mat');
    end
    if exist('Percent_Covered_stopped.mat') ~= 0
        delete('Percent_Covered_stopped.mat');
    end
    if exist('Stopped_Agent_Positions.mat') ~= 0
        delete('Stopped_Agent_Positions.mat');
    end
    if exist('Distance_travelled_stopped.mat') ~= 0
        delete('Distance_travelled_stopped.mat');
    end
    if exist('Density.mat') ~= 0
        delete('Density.mat');
    end
    if exist('E_stopped.mat') ~= 0
        delete('E_stopped.mat');
    end
    History = [];
    for i = 1 : Number_of_Agents
        History(1:1,(2*i-1):2*i) = Agent_Positions(i,1:2);
    end
    if exist('agentData.xlsx') ~= 0
        delete('agentData.xlsx')
    end
    if Density_Type == 1
        Density = sym(get(handles.density_function,'String'));
        disp(Density)
    elseif Density_Type == 2
        Density = Density_mat;
    end
end
%% Set axes (again)
disp(handles)
y_axis_name = get(handles.y_axis_cost_function_name,'String');
cost_function_name = get(handles.cost_function_name,'String');
axes(handles.agent_figure);
set(handles.agent_figure,'XLim',[0,sides],'YLim',[0,sides])
xlabel('x', 'FontSize', 15);
ylabel('y', 'FontSize', 15);
title('Arena','FontSize',15)
axes(handles.coverage_figure);
set(handles.coverage_figure, 'YLim', [0,101]);
xlabel('Iteration Number', 'FontSize', 8);
ylabel('Percent Covered', 'FontSize', 8);
title('Coverage','FontSize',10)
axes(handles.distance_figure);
xlabel('Iteration Number', 'FontSize', 8);
ylabel(y_axis_name, 'FontSize', 8);
title(cost_function_name,'FontSize',10)
axes(handles.com_figure);
set(handles.agent_figure,'XLim',[0,sides],'YLim',[0,sides])
xlabel('x', 'FontSize', 8);
ylabel('y', 'FontSize', 8);
title('Communication Graph','FontSize',10);
%% Run Lloyd's Algorithm
LloydsPlay(Number_of_Agents,sides,Partition_Number,Agent_Positions,Density,...
    r_o,Density_Type,velocity,Velocity_Type,MOVEMENTSCALE,...
    max_velocity,handles,reset_pressed,stop_pressed_before,r_c,p,...
    Percent_Covered_stopped,distance_travelled_stopped,History,...
    Density_variation_type,delay,algorithm_type,y_axis_name,...
    cost_function_name,E_stopped,colours_energy,final_iteration);







% --- Executes when entered data in editable cell(s) in uitable1.
function uitable1_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to uitable1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)
%Agent_Positions = get(hObject,'data');


% --- Executes when selected cell(s) is changed in uitable1.
function uitable1_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to uitable1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)



function density_function_Callback(hObject, eventdata, handles)
% hObject    handle to density_function (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of density_function as text
%        str2double(get(hObject,'String')) returns contents of density_function as a double


% --- Executes during object creation, after setting all properties.
function density_function_CreateFcn(hObject, eventdata, handles)
% hObject    handle to density_function (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Density_Type.
function Density_Type_Callback(hObject, eventdata, handles)
% hObject    handle to Density_Type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Density_Type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Density_Type


% --- Executes during object creation, after setting all properties.
function Density_Type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Density_Type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in reset_button.
function reset_button_Callback(hObject, eventdata, handles)
% hObject    handle to reset_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
setter = true;
set(handles.reset_button, 'UserData',setter);



function max_velocity_Callback(hObject, eventdata, handles)
% hObject    handle to max_velocity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of max_velocity as text
%        str2double(get(hObject,'String')) returns contents of max_velocity as a double


% --- Executes during object creation, after setting all properties.
function max_velocity_CreateFcn(hObject, eventdata, handles)
% hObject    handle to max_velocity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in browse_button.
function browse_button_Callback(hObject, eventdata, handles)
global Density_mat
% hObject    handle to browse_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Density_file = uigetfile({'*.*','All Files'},...
  'Select Density File');
Density_mat = load(Density_file);
Density_mat = struct2cell(Density_mat);
Density_mat = cell2mat(Density_mat);



function radius_com_Callback(hObject, eventdata, handles)
% hObject    handle to radius_com (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of radius_com as text
%        str2double(get(hObject,'String')) returns contents of radius_com as a double


% --- Executes during object creation, after setting all properties.
function radius_com_CreateFcn(hObject, eventdata, handles)
% hObject    handle to radius_com (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in iteration_vary_button.
function iteration_vary_button_Callback(hObject, eventdata, handles)
% hObject    handle to iteration_vary_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns iteration_vary_button contents as cell array
%        contents{get(hObject,'Value')} returns selected item from iteration_vary_button


% --- Executes during object creation, after setting all properties.
function iteration_vary_button_CreateFcn(hObject, eventdata, handles)
% hObject    handle to iteration_vary_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in algorithm_type_button.
function algorithm_type_button_Callback(hObject, eventdata, handles)
% hObject    handle to algorithm_type_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns algorithm_type_button contents as cell array
%        contents{get(hObject,'Value')} returns selected item from algorithm_type_button


% --- Executes during object creation, after setting all properties.
function algorithm_type_button_CreateFcn(hObject, eventdata, handles)
% hObject    handle to algorithm_type_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function delay_button_Callback(hObject, eventdata, handles)
% hObject    handle to delay_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of delay_button as text
%        str2double(get(hObject,'String')) returns contents of delay_button as a double


% --- Executes during object creation, after setting all properties.
function delay_button_CreateFcn(hObject, eventdata, handles)
% hObject    handle to delay_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cost_function_name_Callback(hObject, eventdata, handles)
% hObject    handle to cost_function_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cost_function_name as text
%        str2double(get(hObject,'String')) returns contents of cost_function_name as a double


% --- Executes during object creation, after setting all properties.
function cost_function_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cost_function_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function y_axis_cost_function_name_Callback(hObject, eventdata, handles)
% hObject    handle to y_axis_cost_function_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of y_axis_cost_function_name as text
%        str2double(get(hObject,'String')) returns contents of y_axis_cost_function_name as a double


% --- Executes during object creation, after setting all properties.
function y_axis_cost_function_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to y_axis_cost_function_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function final_iteration_Callback(hObject, eventdata, handles)
% hObject    handle to final_iteration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of final_iteration as text
%        str2double(get(hObject,'String')) returns contents of final_iteration as a double


% --- Executes during object creation, after setting all properties.
function final_iteration_CreateFcn(hObject, eventdata, handles)
% hObject    handle to final_iteration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
