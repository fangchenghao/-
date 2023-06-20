clear all;
clc;
casd=cell(1,300);
ctd=cell(1,300);

Path1 = 'D:\ASD DS-ICME2019_300\ASD\';  % 设置数据存放的文件夹路径
Path2 = 'D:\ASD DS-ICME2019_300\TD\';

File1 = dir(fullfile(Path1,'*.txt'));  % 显示文件夹下所有符合后缀名为.txt文件的完整信息
File2 = dir(fullfile(Path2,'*.txt'));

Length_Names1 = size(File1,1);    % 获取所提取数据文件的个数
Length_Names2 = size(File2,1);

%读取ASD数据
for k = 1 : Length_Names1
    Lum_FileName1=File1(k).name; %获取文件名
    filename1=[Path1,Lum_FileName1]% ; 完整文件名
    ASD = importdata(filename1); % 读取txt文件中的数据
    casd{1,k}=ASD.data;
end
%读取TD数据
for k = 1 : Length_Names2
    Lum_FileName2=File2(k).name; %获取文件名
    filename2=[Path2,Lum_FileName2]% ; 完整文件名
    TD = importdata(filename2); % 读取txt文件中的数据
    ctd{1,k}=TD.data;
end
%数据拆分

ASDdata=cell(300,12); %ASDdata共有300*12(不一定)，每页上是ASDdata的数据，ASDdata为元胞数组
TDdata=cell(300,12);
for k = 1 : Length_Names1
    
   len=size(casd{1,k},1);%看第k幅图的矩阵行数
   temp=casd{1,k};%暂时存储ctd{1,k}矩阵,第k幅图

   cnt=0;%记录第k幅图中的第几组
   %将第k幅图的12组数据矩阵依次提取出来
        for i =1:(len-1)
            if (temp(i,1)==0)
                start=i;%记录这组的开始位置
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
    
   len=size(ctd{1,k},1);%看第k幅图的矩阵行数
   temp=ctd{1,k};%暂时存储ctd{1,k}矩阵,第k幅图

   cnt=0;%记录第k幅图中的第几组
   %将第k幅图的12组数据矩阵依次提取出来
        for i =1:(len-1)
            if (temp(i,1)==0)
                start=i;%记录这组的开始位置
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
