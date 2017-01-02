function output = hmm(name)
clc;
global PATH_SEPARATOR

%% read samples from train directory
% creating sample list
filename = strcat('data', PATH_SEPARATOR, 'train', PATH_SEPARATOR, name);
sample_list = dir(filename);
sample_list = sample_list(3:end);
sample_counts = size(sample_list, 1);
state_counts = 8;

%creating empty model
samples(sample_counts) = struct('feature_counts', [], 'features_dimension', [], 'observations', []);
states(state_counts) = struct('cluster_counts', [], 'features', []);
model = struct('name', name, 'sample_counts', sample_counts, 'samples', samples, 'state_counts', state_counts, 'states', states);

% read samples (ext files)
for i = 1 : sample_counts
    sample_path = strcat(sample_list(i).folder, PATH_SEPARATOR, sample_list(i).name);
    sample_file = fopen(sample_path);
    model.samples(i).name = sample_list(i).name;
    model.samples(i).feature_counts = fscanf(sample_file, '%d', 1);
    model.samples(i).features_dimension = fscanf(sample_file, '%d', 1);
    model.samples(i).observations = zeros(model.samples(i).feature_counts, model.samples(i).features_dimension);
    for j = 1 : model.samples(i).feature_counts
        model.samples(i).observations(j, 1:end) = fscanf(sample_file, '%f', model.samples(i).features_dimension);
    end
    fclose(sample_file);
end

%% hmm model initialization
for i = 1 : model.state_counts
    model.states(i).cluster_counts = 3;
    for j = 1 : model.states(i).cluster_counts
        model.states(i).clusters(j) = struct('gaussian_mean', [], 'gaussian_variance', [], 'gaussian_weight', [], 'features', []);
    end
end

%%% initial clustering
% divide observations between states
for i = 1 : sample_counts
    state_feature_counts = floor((model.samples(i).feature_counts)/model.state_counts);
    for j = 1 : model.state_counts
        first_index = (j-1)*state_feature_counts + 1;
        last_index = j*state_feature_counts;
        if (j == model.state_counts)
            last_index = model.samples(i).feature_counts;
        end
        if i == 1
            model.states(j).features = model.samples(i).observations(first_index:last_index,:);
        else
            model.states(j).features = cat(1, model.states(j).features, model.samples(i).observations(first_index:last_index,:));
        end
    end
end

% clustering
for i = 1 : model.state_counts
    model.states(i) = hmm_clustering(model.states(i));
end

%%% initial matrix a
model.a = zeros(model.state_counts);
for i = 1 : model.state_counts - 1
    model.a(i, i) = 0.5;
    model.a(i, i+1) = 0.5;
end
model.a(model.state_counts, model.state_counts) = 0.5;

disp(hmm_b(model.states(1), model.samples(1).observations(1,:)));

%% Restimation


end