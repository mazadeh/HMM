function output = hmm(name)
clc;

global PATH_SEPARATOR
% read sample directory
filename = strcat('data', PATH_SEPARATOR, 'train', PATH_SEPARATOR, name);
sample_list = dir(filename);
sample_list = sample_list(3:end);
sample_list_size = size(sample_list, 1);

% read sample ext files
sample_data(sample_list_size) = struct('name', [], 'feature_vector', [], 'vector_dimension', [], 'data', []);
for i = 1 : sample_list_size
    sample_path = strcat(sample_list(i).folder, PATH_SEPARATOR, sample_list(i).name);
    sample_file = fopen(sample_path);
    sample_data(i).name = sample_list(i).name;
    sample_data(i).feature_vector = fscanf(sample_file, '%d', 1);
    sample_data(i).vector_dimension = fscanf(sample_file, '%d', 1);
    sample_data(i).data = zeros(sample_data(i).feature_vector, sample_data(i).vector_dimension);
    for j = 1 : sample_data(i).feature_vector
        sample_data(i).data(j, 1:end) = fscanf(sample_file, '%f', sample_data(i).vector_dimension);
    end
    % disp(sample_data(i));
    fclose(sample_file);
end

% hmm initialization
hmm_state_length = 8;
hmm_a = zeros(hmm_state_length);
for i = 1 : hmm_state_length
    hmm_a(i, i) = 0.5;
    hmm_a(i, i+1) = 0.5;
end
hmm_a(hmm_state_length, hmm_state_length) = 0.5;
hmm_state_gaussians = 3;
hmm_gaussian_weights = zeros(hmm_state_length*hmm_state_gaussians);
hmm_gaussians(hmm_state_length) = struct('mean', [], 'variance', []);

for i = hmm_state_length : -1 : 1
    hmm_state_features(i) = struct('features', [], 'clusters', []);
end

for i = 1 : sample_list_size
    state_features_count = floor((sample_data(i).feature_vector)/hmm_state_length);
    for j = 1 : hmm_state_length
        first_index = (j-1)*state_features_count + 1;
        last_index = j*state_features_count;
        if (j == hmm_state_length)
            last_index = sample_data(i).feature_vector;
        end
        if (i == 1)
            hmm_state_features(j).features = sample_data(i).data(first_index:last_index,:);
        else
            hmm_state_features(j).features = cat(1, hmm_state_features(j).features, sample_data(i).data(first_index:last_index,:));
        end
    end
end
% disp(size(hmm_state_features(1).features));
% disp(size(hmm_state_features(2).features));
% disp(size(hmm_state_features(3).features));
% disp(size(hmm_state_features(4).features));
% disp(size(hmm_state_features(5).features));
% disp(size(hmm_state_features(6).features));
% disp(size(hmm_state_features(7).features));
% disp(size(hmm_state_features(8).features));

end