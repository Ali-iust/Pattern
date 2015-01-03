
function text_classify_NaiveBayes()

load('reduced');
load('dataset');

train_data = data_1000_dim(1:2000,:);
test_data = data_1000_dim(2001:end,:);
%train_data = data(1:2000,:);
%test_data = data(2001:end,:);

train_label = label(1:2000,:);
test_label = label(2001:end,:);

distribution = cell(1,2);
distribution{1} = 'normal';
distribution{2} = 'kernel';

prior = cell(1,2);

prior{1} = 'empirical';
prior{2} = 'uniform';

for i=1:2
    for j=1:2
        obj = NaiveBayes.fit(train_data,train_label,'dist',distribution{i},'prior',prior{j});

        predicted = obj.predict(test_data);
        %m = confusionmat(test_label,predicted);

        %disp(m);

        error = 0;
        [row col] = size(predicted);
        for t=1:row
            if(predicted(t) ~= test_label(t))
                error = error + 1;
            end
        end

        error = error / row;
        result = ['distribution : ',distribution{i},' prior : ',prior{j},' error : ',num2str(error)];
        disp(result);
    end
end



end
