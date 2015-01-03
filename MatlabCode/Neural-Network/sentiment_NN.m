function sentiment_NN
load('dataset');
load('reduced');

label = map_labels(label);

train_data = data_1000_dim(1:2000,:)';
train_label = label(1:2000,:)';

test_data = data_1000_dim(2001:end,:)';
test_label = label(2001:end,:)';

%net = NN_training(d,l,1000);
%[err, out] = NN_evaluation(net,test,label_test);


m = [5,10,20,50,100,200,500,1000];
%k = 5;

%e = NN_k_fold(train_data,train_label,k,m);


%[t,index] = min(e);
for i=1:8
    net = NN_training(train_data,train_label,m(1,i));
    [error, out] = NN_evaluation(net,test_data,test_label);
    result = ['m : ',num2str(m(1,i)),' error : ',num2str(error)];
    disp(result);
    
end

       
end
