%% square density matrix with dimensions (sides)(Partition_Number)x(sides)(Partition_Number)
sides = 5;
partitionNumber = 5;
prod = sides * partitionNumber;
arr = zeros(prod);
count = 0;
for i = 0:prod-1
    for j = 0:prod-1
        if count > 3
            arr(i,j)=1;
        end
    end
end