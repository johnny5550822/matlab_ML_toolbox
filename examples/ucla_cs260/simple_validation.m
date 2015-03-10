% Simple validation. Split the data into two parts depend on the training
% ratio. Generate training set and validation set.

% Output: evaluation measurements, such as accuracy 

function accuracy = simple_validation(fv, label, split_ratio, k)
    % parameters
    accuracy = 0;
    num_patients = numel(label);
    
    % split data (randomly arranged) based on ratio
    breakpoint = round(num_patients * split_ratio)
    rand_pos = randperm(num_patients);
    
    train_data = fv(rand_pos(1:breakpoint),:);
    train_label = label(rand_pos(1:breakpoint));
    validation_data = fv(rand_pos(breakpoint+1:end),:);
    validation_label = label(rand_pos(breakpoint+1:end));
    
    % prediction
    [num_validation] = size(validation_data,1);
    pred_validation = zeros(1,num_validation);
    for i = 1:num_validation
        pred_validation(i) = kchbox_knn(k,validation_data(i,:),train_data,train_label);        
    end
    
    % Generate evaluation matrice, such as accuracy
    validation_label
    pred_validation
    [accuracy,sensitivity,specificity,preicsion,recall,...
        f_measure,confusion_matrix] = evaluation_matrice(validation_label,pred_validation);


end