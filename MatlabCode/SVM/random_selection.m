function [data,label] = random_selection(X,Y,m)
    [row,col] = size(X);
    data = zeros(m,col);
    label = zeros(m,1);
    for i=1:m
        index = ceil(rand(1) * (row - i + 1));
        data(i,:) = X(index,:);
        label(i,:) = Y(index,:);
        if(index == 1)
            X = X(2:end,:);
            Y = Y(2:end,:);
        elseif(index == row-i+1)
            X = X(1:end-1,:);
            Y = Y(1:end-1,:);
        else
            X = X([1:index-1,index+1:end],:);
            Y = Y([1:index-1,index+1:end],:);
        end
    end
end
