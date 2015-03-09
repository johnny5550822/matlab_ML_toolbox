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
train_label = xlsread('label');
train_label = train_label(:,2);

% NOTE: One possible step here is to normalize the data series for each
% patient. However, the hypoethesis is that the magnitude of the pressure
% matter relative to different type of patients. So, I did not perform this
% step
%% *********************METHOD 1 Simple knn with Euclidean distance*******

%% Step 1. Feature generation
fv = generate_features_vector(dia,systo);

%% Step 2 Define k + parameter setting
k = 5;

% parameters
num_patients = numel(train_label);
%% Step 3 & Step 4
clc;
test_d = [5.5 2.5]; % test data
test_label = kchbox_knn(k,test_d,train_d,train_label);

%% plot the test point, assuming binary classification
hold on
plot(cluster_1(:,1),cluster_1(:,2),'bo',cluster_2(:,1),cluster_2(:,2),'rx');
if (test_label==1)
   h = plot(test_d(1),test_d(2),'b+');
else
   h = plot(test_d(1),test_d(2),'r+');    
end
set(h,'linewidth',3);
hold off

%% DONE!

