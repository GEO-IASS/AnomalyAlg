%This is just to visualize the data after its fitted with a gaussian.
%This can only do two features at a time.


clear ; close all; clc

data = csvread('featureset0');
dx= data(:, 6) + 1.5;
dy= (data(:, 3) ./ (data(:, 4)+1))+20;
dz = data(:, 1);
X = [dx dy];
XwithID = [dx dy dz];


%  Visualize the example dataset
plot(X(:, 1), X(:, 2), 'bx');
xlabel('TOTAL MESSAGES');
ylabel('INCOMING/OUTGOING MES');
%
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
xlabel('TOTAL MESSAGES');
ylabel('INCOMING/OUTGOING MES');