%׼������
a1=size(asdyouhua,2);%a1ΪASD���ݸ���
t1=size(tdyouhua,2);%t1ΪTD���ݸ���
Yasd=ones(1,a1);
Ytd=zeros(1,t1);
Ytrain=[Yasd,Ytd];
% %��ͼ
% asdx=Xtrain(1,1:a1);
% asdy=Xtrain(2,1:a1);
% asdz=Xtrain(3,1:a1);
% tdx=Xtrain(1,(a1+1):end);
% tdy=Xtrain(2,(a1+1):end);
% tdz=Xtrain(3,(a1+1):end);
%����������
net = patternnet(4,'trainlm','mse');  % ������4����Ԫ

net = train(net,Xtrain,Ytrain);

% %��ͼ����άʱ
% grid on;
% scatter3(asdx,asdy,asdz,'.','red');
% hold on;
% scatter3(tdx,tdy,tdz,'.','blue');
% xlabel('X')
% ylabel('Y')
% zlabel('Z')

