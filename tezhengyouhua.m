youhuaweishu=4;%优化维数
%ASD矩阵合并
asdhebing=zeros(9,1);
tdhebing=zeros(9,1);
for k=1:300
    for i=1:17
        kong=isempty(asdfeatures{k,i});
        if(kong==0)%有值
            asdhebing=[asdhebing,asdfeatures{k,i}];
        end
    end
end
asdhebing=asdhebing(1:end,2:end);
%TD矩阵合并
for k=1:300
    for i=1:15
        kong=isempty(tdfeatures{k,i});
        if(kong==0)%有值
            tdhebing=[tdhebing,tdfeatures{k,i}];
        end
    end
end
tdhebing=tdhebing(1:end,2:end);

%ASD均值向量
asdcenter=mean(asdhebing,2);
%ASD均值向量
tdcenter=mean(tdhebing,2);

swasd=zeros(9,9);
swtd=zeros(9,9);
%asd类内离散度矩阵
for i=1:size(asdhebing,2)
    swasd=swasd+((asdhebing(1:9,i)-asdcenter)*(asdhebing(1:9,i)-asdcenter)');
end
%td类内离散度矩阵
for i=1:size(tdhebing,2)
    swtd=swtd+((tdhebing(1:9,i)-tdcenter)*(tdhebing(1:9,i)-tdcenter)');
end
%总类内离散度矩阵
sw=swasd+swtd;
%类间离散度矩阵
sb=(asdcenter-tdcenter)*(asdcenter-tdcenter)';
%计算产生矩阵sw^-1*sb
chansheng=sw\sb;
[V,D1] = eig(chansheng);
V=real(V);
D1=real(D1);
[d,ind] = sort(diag(D1),'descend');%ind记录d在D1中的位置
Ds = D1(ind,ind);%DS中为排好序的特征值
Vs = V(:,ind);%VS中为为排好序的特征向量

%将特征压缩至4维,计算变换阵W
W=Vs(1:end,1:youhuaweishu);

%ASD特征优化
asdyouhua=zeros(youhuaweishu,1);
for i=1:(size(asdhebing,2))
    temp=W'*asdhebing(1:end,i);
    asdyouhua=[asdyouhua,temp];
end
asdyouhua=asdyouhua(1:end,2:end);
%TD特征优化
tdyouhua=zeros(youhuaweishu,1);
for i=1:(size(tdhebing,2))
    temp=W'*tdhebing(1:end,i);
    tdyouhua=[tdyouhua,temp];
end
tdyouhua=tdyouhua(1:end,2:end);
Xyouhua=[asdyouhua,tdyouhua];
%不做特征优化--------------------------------
Xyouhua=[asdhebing,tdhebing];
%---------------------------------------------
%ASD、TD归一化
Xtrain=mapminmax(Xyouhua,0,1);%训练集样本特征值