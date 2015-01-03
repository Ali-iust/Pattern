function main_svm
load('MNIST.mat');
data = Dt;
label = labels;

iterations = 1;
%m = [0.001,0.01,0.1,0.5,1.5,10];
m = [0.0000001,1,10,1000,100000,10];
k = 5;

train_size = [200,1000,2000];

error_1 = zeros(iterations,6);
error_2 = zeros(iterations,6);
error_3 = zeros(iterations,6);

error_4 = zeros(iterations,6);
error_5 = zeros(iterations,6);
error_6 = zeros(iterations,6);

for i=1:iterations
    for j=1:3
        [x,y] = random_selection(data,label,train_size(1,j));
        for l=1:2
            e = svm_train(x,y,m,k,l);
            if(j == 1)
                if(l == 1)
                    error_1(i,:) = e;
                else
                    error_4(i,:) = e;
                end
            elseif(j == 2)
                if(l == 1)
                    error_2(i,:) = e;
                else
                    error_5(i,:) = e;
                end
            else
                if(l == 1)
                    error_3(i,:) = e;
                else
                    error_6(i,:) = e;
                end
            end
        end
    end
end
T1 = table(error_1);
T2 = table(error_2);
T3 = table(error_3);
T4 = table(error_4);
T5 = table(error_5);
T6 = table(error_6);
writetable(T1,'Result_svm_linear.xlsx','Sheet',1,'Range','A1');
writetable(T2,'Result_svm_linear.xlsx','Sheet',2,'Range','A1');
writetable(T3,'Result_svm_linear.xlsx','Sheet',3,'Range','A1');
writetable(T4,'Result_svm_RBF.xlsx','Sheet',1,'Range','A1');
writetable(T5,'Result_svm_RBF.xlsx','Sheet',2,'Range','A1');
writetable(T3,'Result_svm_RBF.xlsx','Sheet',3,'Range','A1');
end
