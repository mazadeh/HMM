function output = hmm_b( state_j, observation_k)
dimension = size(observation_k, 2);
output = 0;
for i = 1 : dimension
    p = 0;
    for r = 1 : state_j.cluster_counts
        p = p + state_j.clusters(r).gaussian_weight * normpdf(observation_k(i), state_j.clusters(r).gaussian_mean(i),state_j.clusters(r).gaussian_variance(i));
    end
    output = output + log(p);
end
output = exp(output);
end