%% Created by King Chung Ho (Johnny Ho) in 03/09/15
% For UCLA CS260 project (Winter 2015)
% Objective: Use neural network(multi-layer) to build a model for prediction
% Feature: 2 features (Diastolic and systolic) along different time
% Number of training data: 39 patients, 20 with label 0, and 19 with label
% 1

% Train a deep neural network (2 layers) with a softmax attached to the
% output nodes

% Note: may add pre-training step to improve performance

%% Step 0 Parameters set-up

%  change the parameters below.
clear all;
clc;

% inputSize = 26 * 2; % time-series + two parameters <--define later,
% depends on the feature set
numClasses = 2;
hiddenLayersSize = [26 26]; % numel(hiddenLayersSize) = number of hidden layers

sparsityParam = 0.1;   % desired average activation of the hidden units.
                       % (This was denoted by the Greek alphabet rho, which looks like a lower-case "p",
		               %  in the lecture notes). 
lambda = 3e-3;         % weight decay parameter       
beta = 3;              % weight of sparsity penalty term       

%add functions path
addpath neural_network
%% Step 1 Load data

clc;
%read diastolic data, nxm, where m is the number of data point(feature).
%And n is the number of patients
raw_d = xlsread('combine_dia');   
dia = raw_d(:,2:end);

%read systolic data
raw_s = xlsread('combine_sys');   
systo = raw_s(:,2:end);

%read label
label = xlsread('label');
label = label(:,2);

% start label from 1, not 0
label = label + 1;

%% Step 2. Feature generation
fv = generate_features_vector(dia,systo);   % fv = feature vectors

inputSize = size(fv,2); %input size for neural network, i.e. 52
%% Step 3. NN parameters initialization
% weights include hidden layers, the softmax classifer weight, and the
% biases. The network structure is 52x26x26x2
clc;
[theta,netconfig] = initializeParameters(inputSize,hiddenLayersSize,numClasses);

%% Step 4. Train the neural network with a softmax(assume no bias in softmax)

%% Step 4.1 Check the cost function and see if it is correct
clc;
addpath neural_network/sparse_autoencoder/

[cost,grad] = stackedAECost(theta,inputSize,hiddenLayersSize,numClasses,...
     netconfig,lambda,fv,label);

DEBUG = false;
if DEBUG
    checkStackedAECost;
end

%% Step 4.2 optimize the theta using minfunc (which is a gradient descent algorithm)
clc;
addpath neural_network/minFunc/

%  Use minFunc to minimize the function
options.HessUpate = 'lbfgs'; % Here, we use L-BFGS to optimize our cost
                          % function. Generally, for minFunc to work, you
                          % need a function pointer with two outputs: the
                          % function value and the gradient. In our problem,
                          % sparseAutoencoderCost.m satisfies this.
options.MaxIter = 100;	  % Maximum number of iterations of L-BFGS to run 
options.Display = 'iter';
options.GradObj = 'on';

[optTheta, cost] = minFunc( @(p) stackedAECost(p, ...
                                   inputSize, hiddenLayersSize, ...
                                   numClasses, netconfig, ...
                                   lambda, fv, label), ...
                              theta, options);


