%Test multi features

%featureset5 using day milestones to segment users and still using smses for EX_BC_M1
%1 = "user_id",2 = "sun_m",3 = "mon_m",4 = "tue_m",5 = "wed_m",6 = "thu_m",7 = "fri_m",8 = "sat_m",9 = "sun_num_out",
%10 = "sun_num_in",11 = "mon_num_out",12 = "mon_num_in",13 = "tue_num_out",14 = "tue_num_in",15 = "wed_num_out",
%16 = "wed_num_in",17 = "thur_num_out",18 = "thur_num_in",19 = "fri_num_out",20 = "fri_num_in",21 = "sat_num_out",
%23 = "sat_num_in","all_num"

clear ; close all; clc

data = csvread('featureset10');
dz = data(:, 1);
indicate = data(:, [2:8]);
dataun = data(:, [9:22]);
olddata = data(:, [9:22]);
for n = 1:size(dataun)(1)
    ind = find(indicate(n, :) == 1)-1;
    if size(ind)(end) == 0
      ind = 0;
    end
    dataun(n, :) = rotatebynum((ind(end) *2),olddata(n, :));
end

X = dataun;
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
%epsilon = 1.38e-30;
epsilon = 1.38e-40;

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
disp('# Outliers:: X, Y, ID, P');
disp(all_fail);
