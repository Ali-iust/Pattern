function net = NN_training(trainX,trainY,m)
%trainX: d*N input vector where N denotes the number of the training data
%and d shows the dimensionality of the feature vector

%trainY: C*N output vector

%m: number of hidden units


rand('seed',0) % Initialization of the random number generators
randn('seed',0) % for reproducibility of net initial conditions

% Neural network definition
net = newff(trainX,trainY,[m],{'tansig','tansig'},'traingd');

% Neural network initialization
net = init(net);

% Setting parameters
net.trainParam.epochs = 1000; 
net.trainParam.lr = 0.05; % learning rate 
net.trainParam.goal = 1e-5; % stop if the cost function drops below the specified value 

%training
net = train(net,trainX,trainY);
