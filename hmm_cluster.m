function [ output ] = hmm_cluster( data, k )
count = size(data, 1);
dimension = size(data, 2);

output(k) = struct('data', [], 'mean', [], 'variance', []);
length = floor(count/k);
for i = 1 : k
    if (i == k)
        output(i).data = data((i-1)*length+1 : count,:);
    else
        output(i).data = data((i-1)*length+1 : i*length,:);
    end
    for j = 1 : dimension 
        output(i).mean(j) = mean(output(i).data(:,j));
        output(i).variance(j) = var(output(i).data(:,j));
    end
end
end

