function text_classify_knn()

load('reduced');
load('dataset');

k = [1,10,20,30,40,50,60,70,80,90,100];

distance = cell(1,4);

distance{1} = 'euclidean';
distance{2} = 'cityblock';
distance{3} = 'cosine';
distance{4} = 'correlation';


%train_data = data_1000_dim(1:2000,:);
%test_data = data_1000_dim(2001:end,:);
train_data = data(1:2000,:);
test_data = data(2001:end,:);

train_label = label(1:2000,:);
test_label = label(2001:end,:);

[temp,k_col] = size(k);
[temp,d_col] = size(distance);

for i=1:d_col
    e = zeros(1,11);
    for j=1:k_col
        
        predicted = knnclassify(test_data,train_data,train_label,k(1,j),distance{i});
        
        error = 0;
        [row col] = size(predicted);
        for t=1:row
            if(predicted(t) ~= test_label(t))
                error = error + 1;
            end
        end

        error = error / row;
        %res = ['k : ',num2str(k(1,j)),' , distance : ',distance{i},' , error : ',num2str(error)];
        %disp(res);
        
        e(1,j) = error;
    end
    
    disp(e);
    plot(k,e);
    title_text = ['Distance : ',distance{i}];
    title(title_text);
    xlabel('k');
    ylabel('error');
    filename = ['knn_dis_',distance{i}];
    saveas(gcf,filename,'bmp')
end
%predicted = knnclassify(test_data,train_data,train_label,50,'cosine');
end
