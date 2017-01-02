function state = hmm_clustering(state)
count = size(state.features, 1);
dimension = size(state.features, 2);
k = state.cluster_counts;

length = floor(count/k);

for i = 1 : k
    if (i == k)
        state.clusters(i).features = state.features((i-1)*length+1 : count,:);
    else
        state.clusters(i).features = state.features((i-1)*length+1 : i*length,:);
    end
    for j = 1 : dimension 
        state.clusters(i).gaussian_mean(j) = mean(state.clusters(i).features(:,j));
        state.clusters(i).gaussian_variance(j) = var(state.clusters(i).features(:,j));
        if (state.clusters(i).gaussian_variance(j) < 0.1)
            state.clusters(i).gaussian_variance(j) = 0.1;
        end
    end
    state.clusters(i).gaussian_weight = 1/k;
end
end