%incoming messages/out going messages against total messages
%with featureset4 which is featureset3 without testers and stuff check out the sql file
%data = "user_id","timesince","sent_messages","received_messages","total_messages","total_per_day"

clear ; close all; clc

data = csvread('featureset4');
dx= data(:, 6) + 1.5;
dy= (data(:, 3) ./ (data(:, 4)+1))+20;
dz = data(:, 1);
X = [dx dy];
XwithID = [dx dy dz];


%  Visualize the example dataset
plot(X(:, 1), X(:, 2), 'bx');
axis([0 15 0 35]);
xlabel('Messages/Day');
ylabel('SENT/RECEIVED MES');

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

%  Visualize the fit
visualizeFit(X,  mu, sigma2);
axis([0 15 0 35]);
xlabel('TOTAL MESSAGES');
ylabel('INCOMING/OUTGOING MES');


% Set threshold
epsilon = 1.38e-18;
%epsilon = 1.38e-5;

% Find the outliers in the training set and plot the
outliers = find(p < epsilon);

% Draw a red circle around those outliers
hold on
plot(X(outliers, 1), X(outliers, 2), 'ro', 'LineWidth', 2, 'MarkerSize', 10);
hold off


fprintf('Best epsilon found using cross-validation: %e\n', epsilon);
fprintf('# Outliers found: %d\n', sum(p < epsilon));
all = [XwithID p];
disp('# Outliers:: X, Y, ID, P');
disp([all(outliers,1), all(outliers,2), all(outliers,3), all(outliers,4)]);
