function [error] = svm_train(data,label,C,k,kernel)
[r,c] = size(C);
error = zeros(1,c);
[row,col] = size(data);
index = floor(row/k);
iteration = 1;
for i=1:k
    start_index = ((i-1)*index) + 1;
    finish_index = start_index + index - 1;
    test_set = data(start_index:finish_index,:);
    test_label = label(start_index:finish_index,:);
    if(i == 1)
        train_set = data(finish_index+1:end,:);
        train_label = label(finish_index+1:end,:);
    elseif(i == k)
        train_set = data(1:start_index-1,:);
        train_label = label(1:start_index-1,:);
    else
        train_set = data([1:start_index-1,finish_index+1:end],:);
        train_label = label([1:start_index-1,finish_index+1:end],:);
    end
    for j=1:c
        if(kernel == 1) %linear kernel
            %opt = [strcat('-t 0 ','-c ',int2str(C(1,j)))];
            opt = ['-t 0 -c',' ',num2str(C(1,j))];
        else % RBF kernel
            %opt = [strcat('-t 2 ','-c ',int2str(C(1,j)))];
            opt = ['-t 2 -c',' ',num2str(C(1,j))];
        end
        disp(iteration);
        iteration = iteration + 1;
        model=svmtrain(train_label, train_set, opt);
        [tYout, tAcc, tYext]=svmpredict(test_label,test_set,model,'');
        %e = (100 - tAcc(1,1)) / 100;
        e = eval(test_label,tYout);
        error(1,j) = error(1,j) + e;
    end
end
error = error / k;    

end
