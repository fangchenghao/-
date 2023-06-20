clear all;
clc;
casd=cell(1,300);
ctd=cell(1,300);

Path1 = 'D:\ASD DS-ICME2019_300\ASD\';  % �������ݴ�ŵ��ļ���·��
Path2 = 'D:\ASD DS-ICME2019_300\TD\';

File1 = dir(fullfile(Path1,'*.txt'));  % ��ʾ�ļ��������з��Ϻ�׺��Ϊ.txt�ļ���������Ϣ
File2 = dir(fullfile(Path2,'*.txt'));

Length_Names1 = size(File1,1);    % ��ȡ����ȡ�����ļ��ĸ���
Length_Names2 = size(File2,1);

%��ȡASD����
for k = 1 : Length_Names1
    Lum_FileName1=File1(k).name; %��ȡ�ļ���
    filename1=[Path1,Lum_FileName1]% ; �����ļ���
    ASD = importdata(filename1); % ��ȡtxt�ļ��е�����
    casd{1,k}=ASD.data;
end
%��ȡTD����
for k = 1 : Length_Names2
    Lum_FileName2=File2(k).name; %��ȡ�ļ���
    filename2=[Path2,Lum_FileName2]% ; �����ļ���
    TD = importdata(filename2); % ��ȡtxt�ļ��е�����
    ctd{1,k}=TD.data;
end
%���ݲ��

ASDdata=cell(300,12); %ASDdata����300*12(��һ��)��ÿҳ����ASDdata�����ݣ�ASDdataΪԪ������
TDdata=cell(300,12);
for k = 1 : Length_Names1
    
   len=size(casd{1,k},1);%����k��ͼ�ľ�������
   temp=casd{1,k};%��ʱ�洢ctd{1,k}����,��k��ͼ

   cnt=0;%��¼��k��ͼ�еĵڼ���
   %����k��ͼ��12�����ݾ���������ȡ����
        for i =1:(len-1)
            if (temp(i,1)==0)
                start=i;%��¼����Ŀ�ʼλ��
            end
            if(temp(i+1,1)==0)
                jieshu=i;
                cnt=cnt+1;
                ASDdata{k,cnt}=temp(start:jieshu,:);
            end
            if(i==len-1)
                jieshu=i+1;
                if (temp(i+1,1)==0)
                    start=len;
                end
                cnt=cnt+1;
                ASDdata{k,cnt}=temp(start:jieshu,:);
            end
        end
        
end
for k = 1 : Length_Names2
    
   len=size(ctd{1,k},1);%����k��ͼ�ľ�������
   temp=ctd{1,k};%��ʱ�洢ctd{1,k}����,��k��ͼ

   cnt=0;%��¼��k��ͼ�еĵڼ���
   %����k��ͼ��12�����ݾ���������ȡ����
        for i =1:(len-1)
            if (temp(i,1)==0)
                start=i;%��¼����Ŀ�ʼλ��
            end
            if(temp(i+1,1)==0)
                jieshu=i;
                cnt=cnt+1;
                TDdata{k,cnt}=temp(start:jieshu,:);
            end
            if(i==len-1)
                jieshu=i+1;
                if (temp(i+1,1)==0)
                    start=len;
                end
                cnt=cnt+1;
                TDdata{k,cnt}=temp(start:jieshu,:);
            end
        end
        
end
