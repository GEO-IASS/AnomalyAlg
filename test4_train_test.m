%this trains, ie generates gausian for features, with one data set and
%runs test on a different set of data.
%the coulmns of features should be the same and correspond between the test data and
%training data. First column should be user ids.


clear ; close all; clc

%% Train set
train_data = csvread('featureset11_train');
%rotate data to have day 0 in first column
indicate = train_data(:, [2:8]);
dataun = train_data(:, [9:22]);
olddata = train_data(:, [9:22]);
for n = 1:size(dataun)(1)
    ind = find(indicate(n, :) == 1)-1;
    if size(ind)(end) == 0
      ind = 0;
    end
    dataun(n, :) = rotatebynum((ind(end) *2),olddata(n, :));
end
train_set = dataun;


%%Test set
test_data  = csvread('featureset11_test');
%rotate data to have day 0 in first column
indicate = test_data(:, [2:8]);
dataun = test_data(:, [9:22]);
olddata = test_data(:, [9:22]);
for n = 1:size(dataun)(1)
    ind = find(indicate(n, :) == 1)-1;
    if size(ind)(end) == 0
      ind = 0;
    end
    dataun(n, :) = rotatebynum((ind(end) *2),olddata(n, :));
end
test_set = train_set .+ train_set;




ids = test_data(:, 1);
%% ================== Training ===================

%  Estimate mu and sigma2
[mu sigma2] = estimateGaussian(train_set);

%% ================== Testing ===================

%  Returns the density of the multivariate normal at each data point (row) 

p = multivariateGaussian(test_set, mu, sigma2);


% Set threshold
epsilon = 3.38e-1;

% Find the outliers in the training set and plot the
outliers = find(p < epsilon);

fprintf('Best epsilon found using cross-validation: %e\n', epsilon);
fprintf('# Outliers found: %d\n', sum(p < epsilon));
all = [ids p];
all_fail = [ids(outliers) p(outliers)];
disp('# Outliers:: ID, P');
disp(all_fail);


