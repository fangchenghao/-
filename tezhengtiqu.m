asdfeatures=cell(300,17);
tdfeatures=cell(300,15);
features=zeros(9,1);%ASD特征向量，共有9维
%依次为1注视点轨迹长度、2注视点移动平均速度、3注视点方向变化、4注视点散度
%5注视持续时间散度、6注视点的扩散度、7注视点数量、8注视时间范围
%9注视点之间平均距离
%计算ASD特征
for k=1:300
    for i=1:17
        kong=isempty(ASDdata{k,i});
        if(kong==0)%有值
            a=ASDdata{k,i};%第k幅图，第i个数据
            if(size(a,1)~=1)%剔除只有一个注视点的样本
                weizhi=a(1:end,2:3);%每个样本的位置矩阵
                duration=a(1:end,4);%每个样本的时间矩阵
                weizhix=weizhi(1:end,1);%x坐标
                weizhiy=weizhi(1:end,2);%y坐标
                juli= sqrt(diff(weizhix).^2 + diff(weizhiy).^2);%每两个注视点之间的距离
                totaljuli=sum(juli);
                features(1,1)=totaljuli;%将轨迹长度赋给特征向量第一维
                totaltime=sum(duration);
                sudu=totaljuli/totaltime;
                features(2,1)=sudu;%将平均速度赋给特征向量第二维
                %计算注视点方向变化
                
                dx = diff(weizhix);
                dy = diff(weizhiy);
                angle = atan2(dy, dx);%计算相邻两点之间的角度
                
                angle_threshold = pi/12; % 设置方向变化阈值15°（用于判断是否存在方向变化），根据实际情况调整阈值
                if(size(angle,1)~=1)
                    angle_diff = abs(diff(angle));
                    direction_change_indicator = angle_diff > angle_threshold; % 统计方向变化的次数
                    
                    direction_change_count = sum(direction_change_indicator)+1;
                else
                    direction_change_count=1;
                end
                features(3,1)=direction_change_count;%将方向变化次数赋给特征向量第三维
                
                %计算注视点散度
                center_x = mean(weizhix);% 计算注视点的中心位置
                center_y = mean(weizhiy);
                
                distances = (weizhix - center_x).^2 + (weizhiy - center_y).^2; % 计算注视点到中心位置的距离
                
                fixation_dispersion = mean(distances);
                features(4,1)=fixation_dispersion;%将注视点散度赋给特征向量第四维
                
                %计算注视持续时间散度
                center_time = mean(duration);
                distime=(duration-center_time).^2;
                duration_dispersion=mean(distime);
                features(5,1)=duration_dispersion;%将注视点时间散度赋给特征向量第五维
                
                %计算最大轨迹距离
                D=pdist(weizhi);
                Dmax=max(D);
                if(isempty(Dmax)==1)
                    Dmax=0;
                end
                features(6,1)=Dmax;%将最大轨迹距离赋给特征向量第六维
                
                %计算注视点个数
                shuliang=size(weizhix,1);
                features(7,1)=shuliang;%将注视点个数赋给特征向量第七维
                
                %计算注视时间范围
                shijianfanwei=max(duration)-min(duration);
                features(8,1)=shijianfanwei;%将注视时间范围赋给特征向量第八维
                
                %计算注视点之间平均距离
                pingjunjuli=mean(juli);
                features(9,1)=pingjunjuli;%将平均距离赋给特征向量第九维
                asdfeatures{k,i}=features;
            end
        end
    end
end
%计算TD特征
for k=1:300
    for i=1:15
        kong=isempty(TDdata{k,i});
        if(kong==0)%有值
            a=TDdata{k,i};%第k幅图，第i个数据
            if(size(a,1)~=1)%剔除只有一个注视点的样本
                weizhi=a(1:end,2:3);%每个样本的位置矩阵
                duration=a(1:end,4);%每个样本的时间矩阵
                weizhix=weizhi(1:end,1);%x坐标
                weizhiy=weizhi(1:end,2);%y坐标
                juli= sqrt(diff(weizhix).^2 + diff(weizhiy).^2);
                totaljuli=sum(juli);
                features(1,1)=totaljuli;%将轨迹长度赋给特征向量第一维
                totaltime=sum(duration);
                sudu=totaljuli/totaltime;
                features(2,1)=sudu;%将平均速度赋给特征向量第二维
                %计算注视点方向变化
                
                dx = diff(weizhix);
                dy = diff(weizhiy);
                angle = atan2(dy, dx);%计算相邻两点之间的角度
                
                angle_threshold = pi/12; % 设置方向变化阈值15°（用于判断是否存在方向变化），根据实际情况调整阈值
                
                if(size(angle,1)~=1)
                    angle_diff = abs(diff(angle));
                    direction_change_indicator = angle_diff > angle_threshold; % 统计方向变化的次数
                    
                    direction_change_count = sum(direction_change_indicator)+1;
                else
                    direction_change_count=1;
                end
                
                features(3,1)=direction_change_count;%将方向变化次数赋给特征向量第三维
                
                %计算注视点散度
                center_x = mean(weizhix);% 计算注视点的中心位置
                center_y = mean(weizhiy);
                
                distances = (weizhix - center_x).^2 + (weizhiy - center_y).^2; % 计算注视点到中心位置的距离
                
                fixation_dispersion = mean(distances);
                features(4,1)=fixation_dispersion;%将注视点散度赋给特征向量第四维
                
                %计算注视持续时间散度
                center_time = mean(duration);
                distime=(duration-center_time).^2;
                duration_dispersion=mean(distime);
                features(5,1)=duration_dispersion;%将注视点时间散度赋给特征向量第五维
                
                %计算最大轨迹距离
                D=pdist(weizhi);
                Dmax=max(D);
                if(isempty(Dmax)==1)
                    Dmax=0;
                end
                features(6,1)=Dmax;%将最大轨迹距离赋给特征向量第六维
                
                %计算注视点个数
                shuliang=size(weizhix,1);
                features(7,1)=shuliang;%将注视点个数赋给特征向量第七维
                
                %计算注视时间范围
                shijianfanwei=max(duration)-min(duration);
                features(8,1)=shijianfanwei;%将注视时间范围赋给特征向量第八维
                
                %计算注视点之间平均距离
                pingjunjuli=mean(juli);
                features(9,1)=pingjunjuli;%将平均距离赋给特征向量第九维
                tdfeatures{k,i}=features;
            end
        end
    end
end


            
            