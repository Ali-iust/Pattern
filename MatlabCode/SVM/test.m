function test

load('MNIST.mat');
data = Dt(1:1000,:);
label = labels(1:1000,:);
test = Dt(200:250,:);
tlabel = labels(200:250,:);

svmopts=['-c 2 -g 1'];
model=svmtrain(label, data, svmopts);
[tYout, tAcc, tYext]=svmpredict(tlabel,test,model,'-v 3');
e = 0;
for i=1:51
    if(tlabel(i,:) ~= tYout(i,:))
        e = e + 1;
    end
end
e = (e / 51) * 100;
disp(e);
end
