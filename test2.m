%sunday users and thier messages on different days
%"user_id";"sun_num_out";"sun_num_in";"mon_num_out";"mon_num_in";
%"tue_num_out";"tue_num_in";"wed_num_out";"wed_num_in";"thur_num_out";
%"thur_num_in";"fri_num_out";"fri_num_in";"sat_num_out";"sat_num_in";"all_num"
clear ; close all; clc

data = csvread('featureset7');
dz = data(:, 1);
X = data(:,[2:end]);
XwithID = [X dz];


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
epsilon = 3.38e-15;

% Find the outliers in the training set and plot the
outliers = find(p < epsilon);

fprintf('Best epsilon found using cross-validation: %e\n', epsilon);
fprintf('# Outliers found: %d\n', sum(p < epsilon));
all = [XwithID p];
disp('# Outliers:: X, Y, ID, P');
disp([dz(outliers) p(outliers)]);
