%准备数据
a1=size(asdyouhua,2);%a1为ASD数据个数
t1=size(tdyouhua,2);%t1为TD数据个数
Yasd=ones(1,a1);
Ytd=zeros(1,t1);
Ytrain=[Yasd,Ytd];
% %绘图
% asdx=Xtrain(1,1:a1);
% asdy=Xtrain(2,1:a1);
% asdz=Xtrain(3,1:a1);
% tdx=Xtrain(1,(a1+1):end);
% tdy=Xtrain(2,(a1+1):end);
% tdz=Xtrain(3,(a1+1):end);
%构建神经网络
net = patternnet(4,'trainlm','mse');  % 隐含层4个神经元

net = train(net,Xtrain,Ytrain);

% %绘图，三维时
% grid on;
% scatter3(asdx,asdy,asdz,'.','red');
% hold on;
% scatter3(tdx,tdy,tdz,'.','blue');
% xlabel('X')
% ylabel('Y')
% zlabel('Z')

