%Test multi features

%featureset12 using day milestones to segment users and using milestonejobs per day
%data = 1: "user_id",2: "sun_m",3: "mon_m",4: "tue_m",5: "wed_m",6: "thu_m",7: "fri_m",
%8: "sat_m",9: "sun_num", 10: "mon_num",11: "tue_num",12: "wed_num",13: "thur_num",
%14: "fri_num",15: "sat_num",16: "all_num"

clear ; close all; clc

data = csvread('featureset12');
dz = data(:, 1);
indicate = data(:, [2:8]);
dataun = data(:, [9:15]);
olddata = data(:, [9:15]);
for n = 1:size(dataun)(1)
    ind = find(indicate(n, :) == 1)-1;
    if size(ind)(end) == 0
      ind = 0;
    end
    dataun(n, :) = rotatebynum((ind(end)+1),olddata(n, :));
end

X = [dataun data(:, end)];
XwithID = [dz X];

%% ================== Part 2: Estimate the dataset statistics ===================
%  For this exercise, we assume a Gaussian distribution for the dataset.
%
%  We first estimate the parameters of our assumed Gaussian distribution, 
%  then compute the probabilities for each of the points and then visualize 
%  both the overall distribution and where each of the points falls in 
%  terms of that distribution.
%
fprintf('Visualizing Gaussian fit.\n\n');

%  Estimate mu and sigma2
[mu sigma2] = estimateGaussian(X);

%  Returns the density of the multivariate normal at each data point (row) 
%  of X
p = multivariateGaussian(X, mu, sigma2);

% Set threshold
epsilon = 1.38e-30;

% Find the outliers in the training set and plot the
outliers = find(p < epsilon);

% Draw a red circle around those outliers
%hold on
%plot(X(outliers, 1), X(outliers, 2), 'ro', 'LineWidth', 2, 'MarkerSize', 10);
%hold off


fprintf('Best epsilon found using cross-validation: %e\n', epsilon);
fprintf('# Outliers found: %d\n', sum(p < epsilon));
all = [dz p];
all_fail = [dz(outliers) p(outliers)];
disp('# Outliers:: ID, P');
disp(all_fail);
