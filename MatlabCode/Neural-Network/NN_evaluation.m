function [mis,error] = NN_evaluation(net,X,Y)
Output = sim(net,X); %Computation of the network outputs

%compute the error rate
[row,col] = size(X);
error = 0;
mis = 0;
for i=1:col
    [temp,real_value] = max(Y(:,i));
    [temp,estimated_value] = max(Output(:,i));
    if(real_value ~= estimated_value)
       error = error + 1;
       mis = mis + (map_to_number(Y(:,i)') - map_to_number(map_to_output(Output(:,i)'))) ^ 2;
    end
end

error = (error / col) * 100;

mis = (mis / col) * 100;
temp = error;
error = mis;
mis = temp;
