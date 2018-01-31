function Density = iteration_variation_fun(Density,iteration_number,...
    delay,Partition_Number,Agent_Positions,r_o)
% This function will run through the Density matrix every
% iteration. Since the Density matrix is discretized depending on the
% Partition Number chosen, the (x,y) values of the (i,j) entry of the
% Density matrix are: x = i/Partition_Number, and y = j/Partition_Number.
% Hence, to change a density value at position (x,y) we calculate first the
% (x,y) position as above, then change the Density value according to the
% function which takes in position and iteration number.
arrayLength = 50;
xmove = randi([-1 1],arrayLength);
ymove = randi([-1 1],arrayLength);
change = mod(iteration_number,delay); %Checks if iteration_number divides delay.
if change == 0
    for i = 1:size(Density,1)
        for j = 1:size(Density,1)
            x = i/Partition_Number;
            y = j/Partition_Number;
            if Density(i,j) ~= 0
                if (1 <= i + xmove(i,j)) && (i  + xmove(i,j)<= arrayLength) && (xmove(i,j) ~= 0) && (Density(i+xmove(i,j),j) == 0)
                    Density(i+xmove(i,j),j)= Density(i,j);
                    Density(i,j)= 0;
                    xmoveInt = xmove(i,j);
                end
            else xmoveInt = 0;
            end
            if Density(i+xmoveInt,j) ~= 0
                if (1 <= j + ymove(i,j)) && (j  + ymove(i,j)<= arrayLength) && (ymove(i,j) ~= 0) && (Density(i+xmoveInt,j+ymove(i,j)) == 0)
                    Density(i+xmoveInt,j+ymove(i,j)) = Density(i+xmoveInt,j);
                    Density(i+xmoveInt,j)=0;
                    ymoveInt = ymove(i,j);
                end
            else ymoveInt = 0;
            end
        end
        threatL = 0;
        threatL = Density(i + xmoveInt,j + ymoveInt);
        if (i + xmoveInt +1)<=arrayLength
            threatL = threatL + Density(i + xmoveInt + 1,j + ymoveInt);
        end
        if 1<=(i + xmoveInt - 1)
            threatL = threatL + Density(i + xmoveInt - 1,j + ymoveInt);
        end
        if (j + ymoveInt + 1)<=arrayLength
            threatL = threatL + Density(i + xmoveInt,j + ymoveInt + 1);
        end
        if 1<=(j + ymoveInt - 1)
            threatL = threatL + Density(i + xmoveInt,j + ymoveInt - 1);
        end
        if threatL > 5
            fprintf('Threat occuring at cooridinate (%d,%d)',(i + xmoveInt),(j + ymoveInt));
        end
            
            if i > 1
                Density(i,j) = Density(i-1,j);
            elseif i == 1
                Density(i,j) = 0;
            end
        end
    end
end