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
addpath neural_network/minFunc/
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

%%
kchbox_nn(fv,fv,label,numClasses,hiddenLayersSize,...
    sparsityParam,lambda,beta)

%% Step 3. n-fold cross-validation. If n = number of data, it will become leave-one-out
clc;
n = 10;
[acc,sen,spec,pre,recall,f_measure,mcc,confusion_matrix] = n_fold_cross_validation_nn(fv,label,n,...
    numClasses,hiddenLayersSize,sparsityParam,lambda,beta);

disp(sprintf('confusion_matrix:'));
disp(confusion_matrix)
disp(sprintf('Accuracy:%f',acc));
disp(sprintf('Sentivity:%f',sen));
disp(sprintf('Specificity:%f',spec));
disp(sprintf('Precision:%f',pre));
disp(sprintf('Recall:%f',recall));
disp(sprintf('F-measure:%f',f_measure));
disp(sprintf('MCC:%f',mcc));




