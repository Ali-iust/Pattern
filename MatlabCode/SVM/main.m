function main()
load('reduced');
load('dataset');

train_data_100 = data_100_dim(1:2000,:);
train_data_500 = data_500_dim(1:2000,:);
train_data_1000 = data_1000_dim(1:2000,:);
train_label = label(1:2000);

validate_data_100 = data_100_dim(2001:end,:);
validate_data_500 = data_500_dim(2001:end,:);
validate_data_1000 = data_1000_dim(2001:end,:);
validate_label = label(2001:end,:);

k = 5; % number of folds
c = [0.0001,0.001];

[row,col] = size(c);
error_linear = zeros(1,col);
error_rbf = zeros(1,col);
for i=1:col
    error_linear(1,i) = svm_train(train_data_1000,train_label,c(1,i),k,1);
    error_rbf(1,i) = svm_train(train_data_1000,train_label,c(1,i),k,2);
end

disp(error_linear);
disp(error_rbf);

[temp index1] = min(error_linear);
[temp2 index2] = min(error_rbf);

if(temp<temp2)
    opt = ['-t 0 -c',' ',num2str(c(1,index1))];
else
    opt = ['-t 2 -c',' ',num2str(c(1,index2))];
end
    model = svmtrain(train_label,train_data_1000,opt);
    [tYout, tAcc, tYext]=svmpredict(validate_label,validate_data_1000,model,'');
    error = eval(tYout,validate_label);
    disp(error);
    

end
