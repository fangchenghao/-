youhuaweishu=4;%�Ż�ά��
%ASD����ϲ�
asdhebing=zeros(9,1);
tdhebing=zeros(9,1);
for k=1:300
    for i=1:17
        kong=isempty(asdfeatures{k,i});
        if(kong==0)%��ֵ
            asdhebing=[asdhebing,asdfeatures{k,i}];
        end
    end
end
asdhebing=asdhebing(1:end,2:end);
%TD����ϲ�
for k=1:300
    for i=1:15
        kong=isempty(tdfeatures{k,i});
        if(kong==0)%��ֵ
            tdhebing=[tdhebing,tdfeatures{k,i}];
        end
    end
end
tdhebing=tdhebing(1:end,2:end);

%ASD��ֵ����
asdcenter=mean(asdhebing,2);
%ASD��ֵ����
tdcenter=mean(tdhebing,2);

swasd=zeros(9,9);
swtd=zeros(9,9);
%asd������ɢ�Ⱦ���
for i=1:size(asdhebing,2)
    swasd=swasd+((asdhebing(1:9,i)-asdcenter)*(asdhebing(1:9,i)-asdcenter)');
end
%td������ɢ�Ⱦ���
for i=1:size(tdhebing,2)
    swtd=swtd+((tdhebing(1:9,i)-tdcenter)*(tdhebing(1:9,i)-tdcenter)');
end
%��������ɢ�Ⱦ���
sw=swasd+swtd;
%�����ɢ�Ⱦ���
sb=(asdcenter-tdcenter)*(asdcenter-tdcenter)';
%�����������sw^-1*sb
chansheng=sw\sb;
[V,D1] = eig(chansheng);
V=real(V);
D1=real(D1);
[d,ind] = sort(diag(D1),'descend');%ind��¼d��D1�е�λ��
Ds = D1(ind,ind);%DS��Ϊ�ź��������ֵ
Vs = V(:,ind);%VS��ΪΪ�ź������������

%������ѹ����4ά,����任��W
W=Vs(1:end,1:youhuaweishu);

%ASD�����Ż�
asdyouhua=zeros(youhuaweishu,1);
for i=1:(size(asdhebing,2))
    temp=W'*asdhebing(1:end,i);
    asdyouhua=[asdyouhua,temp];
end
asdyouhua=asdyouhua(1:end,2:end);
%TD�����Ż�
tdyouhua=zeros(youhuaweishu,1);
for i=1:(size(tdhebing,2))
    temp=W'*tdhebing(1:end,i);
    tdyouhua=[tdyouhua,temp];
end
tdyouhua=tdyouhua(1:end,2:end);
Xyouhua=[asdyouhua,tdyouhua];
%���������Ż�--------------------------------
Xyouhua=[asdhebing,tdhebing];
%---------------------------------------------
%ASD��TD��һ��
Xtrain=mapminmax(Xyouhua,0,1);%ѵ������������ֵ