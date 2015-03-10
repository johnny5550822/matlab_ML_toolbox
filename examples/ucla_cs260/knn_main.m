%% Created by King Chung Ho (Johnny Ho) in 030515
% For UCLA CS260 project (Winter 2015)
% Objective: Use kchbox-knn to build a model for prediction
% Feature: 2 features (Diastolic and systolic) along different time
% Number of training data: 39 patients, 20 with label 0, and 19 with label
% 1

% WIll attempt different method and see which one give the best result.
% Have a feature generation function to generate different features
%% Step 0 Creating training data (random) for 2 clusters using gaussian distribution.
clear all;
clc;
addpath data/

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

% NOTE: One possible step here is to normalize the data series for each
% patient. However, the hypoethesis is that the magnitude of the pressure
% matter relative to different type of patients. So, I did not perform this
% step
%% *********************METHOD 1 Simple knn with Euclidean distance*******

%% Step 1. Feature generation
fv = generate_features_vector(dia,systo);   % fv = feature vectors

%% Step 2 Define k + parameter setting
k = 5;

%% Step 3 & Step 4
clc;
split_ratio = 0.7;
[accuracy,] = simple_validation(fv,label,split_ratio,k);
%% n-fold cross-validation. If n = number of data, it will become leave-one-out
clc;
n = 10;
[a_avg,a_std,sen_avg,sen_std,spec_avg,spec_std,p_avg,p_std,...
    r_avg,r_std,f_avg,f_std,confusion_matrix] = n_fold_cross_validation(fv,label,k,n);

disp(sprintf('Accuracy:%f +-%f',a_avg,a_std));
disp(sprintf('Sentivity:%f +-%f',sen_avg,sen_std));
disp(sprintf('Specificity:%f +-%f',spec_avg,spec_std));
disp(sprintf('Precision:%f +-%f',p_avg,p_std));
disp(sprintf('Recall:%f +-%f',r_avg,r_std));
disp(sprintf('F-measure:%f +-%f',f_avg,f_std));
disp(sprintf('confusion_matrix:'));
disp(confusion_matrix)

%% DONE!

