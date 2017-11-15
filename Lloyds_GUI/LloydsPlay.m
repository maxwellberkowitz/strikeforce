  function LloydsPlay(Number_of_Agents,sides,Partition_Number,Agent_Positions,...
    Density,r_o,Density_Type,velocity,Velocity_Type,MOVEMENTSCALE,...
    max_velocity,handles,reset_pressed,stop_pressed_before,r_c,p,...
    Percent_Covered_stopped,distance_travelled_stopped,History,...
    Density_variation_type,delay,algorithm_type,y_axis_name,...
    cost_function_name,E_stopped,colours_energy,final_iteration) 
%% Setup
arena_dimensions = 5; % Dimension of arena in meters
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
axes(handles.com_figure)
set(handles.com_figure,'XLim',[0,sides],'YLim',[0,sides]);
xlabel('x', 'FontSize', 8);
ylabel('y', 'FontSize', 8);
title('Communication Graph','FontSize',10);

syms x y z
[yy,xx] = meshgrid(linspace(0,sides,sides*Partition_Number)); %If you want contours, then you need variable density!!
Agent_Positions = Fixing_Starting_Positions(Agent_Positions,Partition_Number,sides);


%% Stop/Reset
%% Reset Pressed
if reset_pressed == 1 
    axes(handles.agent_figure)
    cla;
    axes(handles.coverage_figure)
    cla;
    axes(handles.distance_figure)
    cla;
    j = 1;
    Percent_Covered = [];
    distance_travelled = zeros(1);
    if Density_Type == 1 
        Density = fun_to_arr(Density,sides,Partition_Number);
    end
    Total_Mass = sum(sum(Density));
    %% Power/Energy Example
    % Here the agents are assigned their energy contents (in percentage) at the
    % start of the program. Agents 2 and 3 (arbitrarily chosen) have a lower
    % energy value. Note that there are two sections where you need to make
    % changes since stop and reset all act differently need to save the
    % contents of E in different ways (if stop is pressed, E must be the
    % same as right before stop was pressed, if reset is pressed, E is set
    % to initial values, if none is pressed, E is also set to inital
    % values (see the different if's))
    E = zeros(1,Number_of_Agents);
    for i = 1:Number_of_Agents
        E(i) = 100; % Assume agents have 100% of energy at the start
    end
    E(2) = 40;
    E(3) = 20;
%% Stop Pressed
elseif reset_pressed == 0 && stop_pressed_before == 1
    j = p;
    Percent_Covered = Percent_Covered_stopped;
    distance_travelled = distance_travelled_stopped;
    Total_Mass = sum(sum(Density));
    %% Energy
    % Don't change this!
    E = E_stopped; % This is saved at the end of the loop is stop is pressed
%% Neither Reset nor Stop Pressed
else
    j = 1;
    Percent_Covered = [];
    distance_travelled = zeros(1);
    if Density_Type == 1
        Density = fun_to_arr(Density,sides,Partition_Number);
    end
    Total_Mass = sum(sum(Density));
    %% Energy
    E = zeros(1,Number_of_Agents);
    for i = 1:Number_of_Agents
        E(i) = 100; % Assume agents have 100% of energy at the start
    end
    E(2) = 40; %Just to make it different, allow other agents to have less energy
    E(3) = 20;
end
stop_button_pressed = 0;


Density_cumulative = Density;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Loop %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Loop
    while stop_button_pressed == 0
        [coms com_mat] = communication_fun(Agent_Positions,r_c,...
            Number_of_Agents,algorithm_type);
        axes(handles.com_figure)
        set(handles.com_figure,'XLim',[0,sides],'YLim',[0,sides]);
        xlabel('x', 'FontSize', 8);
        ylabel('y', 'FontSize', 8);
        title('Communication Graph','FontSize',10);
        Com_Graph(Agent_Positions,coms,com_mat,handles,sides);
        Agent_Points = assign_points(Agent_Positions,coms,sides,...
            Partition_Number,r_o,algorithm_type,E);
        Mass = mass_calc(Agent_Points, Density, Number_of_Agents, ...
            Partition_Number,algorithm_type);
        covered_mass = covered_mass_fun(Agent_Positions,Density,r_o,...
            Partition_Number,Number_of_Agents,algorithm_type);
        if covered_mass >= Total_Mass
            Percent_Covered = horzcat(Percent_Covered, 100);
        else
            Percent_Covered = horzcat(Percent_Covered, 100*covered_mass/Total_Mass);
        end
        independent = 1:j; % for plotting the coverage figure
        axes(handles.coverage_figure);
        set(handles.coverage_figure, 'YLim', [0,101]);
        xlabel('Iteration Number', 'FontSize', 8);
        ylabel('Percent Covered', 'FontSize', 8);
        title('Coverage','FontSize',10)
        plot(handles.coverage_figure,independent, Percent_Covered, 'r');
        hold on
        Centroids = centroid_finder(Agent_Points,Mass,Density,...
            Number_of_Agents,Agent_Positions,Partition_Number);
        [Agent_Positions,distance_travelled,E] = move_agents(Agent_Positions,...
            Centroids,distance_travelled,Velocity_Type,velocity,...
            max_velocity,MOVEMENTSCALE,algorithm_type,E);
        
        for k = 1 : Number_of_Agents % for saving to Excel
            Latest_History(1:1,(2*k-1):2*k) = Agent_Positions(k,1:2);
        end
        History = vertcat(History,Latest_History); % for saving to Excel
        for i = 1:Number_of_Agents % Plot Agents and centroids
            axes(handles.agent_figure);
            set(handles.agent_figure,'XLim',[0,sides],'YLim',[0,sides])
            xlabel('x', 'FontSize', 15);
            ylabel('y', 'FontSize', 15);
            title('Arena','FontSize',15)
            hold on
            scatter(handles.agent_figure,Agent_Positions(i,1),...
                Agent_Positions(i,2),90,'blue','filled');
            label_agent_index = num2str(i);
            t.FontSize = 20;
            text(Agent_Positions(i,1) + sides/65, Agent_Positions(i,2) + sides/65,...
                label_agent_index);
            hold on
            scatter(handles.agent_figure,Centroids(i,1),Centroids(i,2),50,'red','filled');  
            hold on
            circle_Maker(Agent_Positions(i,1), Agent_Positions(i,2),r_o,handles);
        end
        axes(handles.agent_figure);
        hold on
        voronoi(handles.agent_figure,Agent_Positions(:,1),Agent_Positions(:,2));
        hold on 
        [contour_plot h] = contour(handles.agent_figure,xx,yy,Density,4); % h is used for line width
        set(h,'linewidth',2);
        independent = 1:j+1; % for plotting cost function 2 (distance travelled)
        axes(handles.distance_figure);
        xlabel('Iteration Number', 'FontSize', 8);
        ylabel(y_axis_name, 'FontSize', 8);
        title(cost_function_name,'FontSize',10)
        plot(handles.distance_figure,independent, distance_travelled, 'r');
        hold on
        Plot_Assigned_Points(Agent_Points,Number_of_Agents,colours_energy,...
            Agent_Positions,sides);
        hold on
        pause(0.1);
        if final_iteration > 0 && j >= final_iteration
            stop_button_pressed = 1
        end
        j = j + 1;
        stop_button_data = get(handles.stop_button,'UserData');
        reset_button_data = get(handles.reset_button,'UserData');
        if ~isempty(stop_button_data) && final_iteration <= 0%Stop was pressed
            stop_button_data = [];
            stop_button_pressed = 1;
            p = j;
            Stopped_Agent_Positions = Agent_Positions;
            save('p_value','p');
            save('Percent_Covered_stopped','Percent_Covered');
            save('Distance_travelled_stopped','distance_travelled');
            save('Stopped_Agent_Positions','Stopped_Agent_Positions');
            save('Density','Density');
            save('Energy_stopped','E');
        elseif ~isempty(reset_button_data) && final_iteration <= 0%Reset was pressed
            reset_button_data = [];
            stop_button_pressed = 1;
        
        elseif j <= final_iteration || final_iteration <= 0
            axes(handles.agent_figure)
            cla;
            axes(handles.agent_figure);
            set(handles.agent_figure,'XLim',[0,sides],'YLim',[0,sides])
            xlabel('x', 'FontSize', 15);
            ylabel('y', 'FontSize', 15);
            title('Arena','FontSize',15);
            axes(handles.com_figure)
            cla;
            clf(1);
            if Density_variation_type == 2
                Density = iteration_variation_fun(Density,j,delay,...
                    Partition_Number,Agent_Positions,r_o);
                Total_Mass = sum(sum(Density));
                Density_cumulative = vertcat(Density_cumulative, Density);
            end
        end
        
    end
    History2 = History*(arena_dimensions/sides); 
    xlswrite('agentData.xlsx',History,1)
    xlswrite('agentData.xlsx',History2,2);
    xlswrite('agentData.xlsx',Percent_Covered',3);
    xlswrite('agentData.xlsx',distance_travelled',4);
    xlswrite('agentData.xlsx',Density_cumulative, 5);
    Extra_info_matrix = zeros(1,3);
    Extra_info_matrix(1,1) = r_o;
    Extra_info_matrix(1,2) = r_c;
    Extra_info_matrix(1,3) = Density_variation_type;
    xlswrite('agentData.xlsx', Extra_info_matrix, 6);
end
    
