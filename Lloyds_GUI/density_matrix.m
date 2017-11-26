%% square density matrix with dimensions (sides)(Partition_Number)x(sides)(Partition_Number)
% arr = zeros(prod);
% count = 0;
% for i = 0:prod-1
%     for j = 0:prod-1
%         if count > 3
%             arr(i,j)=1;
%         end
%     end
% end
arr = randi([0 3],25);
%arr(:) = round(1+arr(:)*2);      
save('C:\Users\Max Berkowitz\OneDrive - Queen''s University\2nd Year\APSC 200-293\P2\strikeforce\Lloyds_GUI\density_matrix.mat','arr');