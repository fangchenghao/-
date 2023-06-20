asdfeatures=cell(300,17);
tdfeatures=cell(300,15);
features=zeros(9,1);%ASD��������������9ά
%����Ϊ1ע�ӵ�켣���ȡ�2ע�ӵ��ƶ�ƽ���ٶȡ�3ע�ӵ㷽��仯��4ע�ӵ�ɢ��
%5ע�ӳ���ʱ��ɢ�ȡ�6ע�ӵ����ɢ�ȡ�7ע�ӵ�������8ע��ʱ�䷶Χ
%9ע�ӵ�֮��ƽ������
%����ASD����
for k=1:300
    for i=1:17
        kong=isempty(ASDdata{k,i});
        if(kong==0)%��ֵ
            a=ASDdata{k,i};%��k��ͼ����i������
            if(size(a,1)~=1)%�޳�ֻ��һ��ע�ӵ������
                weizhi=a(1:end,2:3);%ÿ��������λ�þ���
                duration=a(1:end,4);%ÿ��������ʱ�����
                weizhix=weizhi(1:end,1);%x����
                weizhiy=weizhi(1:end,2);%y����
                juli= sqrt(diff(weizhix).^2 + diff(weizhiy).^2);%ÿ����ע�ӵ�֮��ľ���
                totaljuli=sum(juli);
                features(1,1)=totaljuli;%���켣���ȸ�������������һά
                totaltime=sum(duration);
                sudu=totaljuli/totaltime;
                features(2,1)=sudu;%��ƽ���ٶȸ������������ڶ�ά
                %����ע�ӵ㷽��仯
                
                dx = diff(weizhix);
                dy = diff(weizhiy);
                angle = atan2(dy, dx);%������������֮��ĽǶ�
                
                angle_threshold = pi/12; % ���÷���仯��ֵ15�㣨�����ж��Ƿ���ڷ���仯��������ʵ�����������ֵ
                if(size(angle,1)~=1)
                    angle_diff = abs(diff(angle));
                    direction_change_indicator = angle_diff > angle_threshold; % ͳ�Ʒ���仯�Ĵ���
                    
                    direction_change_count = sum(direction_change_indicator)+1;
                else
                    direction_change_count=1;
                end
                features(3,1)=direction_change_count;%������仯��������������������ά
                
                %����ע�ӵ�ɢ��
                center_x = mean(weizhix);% ����ע�ӵ������λ��
                center_y = mean(weizhiy);
                
                distances = (weizhix - center_x).^2 + (weizhiy - center_y).^2; % ����ע�ӵ㵽����λ�õľ���
                
                fixation_dispersion = mean(distances);
                features(4,1)=fixation_dispersion;%��ע�ӵ�ɢ�ȸ���������������ά
                
                %����ע�ӳ���ʱ��ɢ��
                center_time = mean(duration);
                distime=(duration-center_time).^2;
                duration_dispersion=mean(distime);
                features(5,1)=duration_dispersion;%��ע�ӵ�ʱ��ɢ�ȸ���������������ά
                
                %�������켣����
                D=pdist(weizhi);
                Dmax=max(D);
                if(isempty(Dmax)==1)
                    Dmax=0;
                end
                features(6,1)=Dmax;%�����켣���븳��������������ά
                
                %����ע�ӵ����
                shuliang=size(weizhix,1);
                features(7,1)=shuliang;%��ע�ӵ��������������������ά
                
                %����ע��ʱ�䷶Χ
                shijianfanwei=max(duration)-min(duration);
                features(8,1)=shijianfanwei;%��ע��ʱ�䷶Χ�������������ڰ�ά
                
                %����ע�ӵ�֮��ƽ������
                pingjunjuli=mean(juli);
                features(9,1)=pingjunjuli;%��ƽ�����븳�����������ھ�ά
                asdfeatures{k,i}=features;
            end
        end
    end
end
%����TD����
for k=1:300
    for i=1:15
        kong=isempty(TDdata{k,i});
        if(kong==0)%��ֵ
            a=TDdata{k,i};%��k��ͼ����i������
            if(size(a,1)~=1)%�޳�ֻ��һ��ע�ӵ������
                weizhi=a(1:end,2:3);%ÿ��������λ�þ���
                duration=a(1:end,4);%ÿ��������ʱ�����
                weizhix=weizhi(1:end,1);%x����
                weizhiy=weizhi(1:end,2);%y����
                juli= sqrt(diff(weizhix).^2 + diff(weizhiy).^2);
                totaljuli=sum(juli);
                features(1,1)=totaljuli;%���켣���ȸ�������������һά
                totaltime=sum(duration);
                sudu=totaljuli/totaltime;
                features(2,1)=sudu;%��ƽ���ٶȸ������������ڶ�ά
                %����ע�ӵ㷽��仯
                
                dx = diff(weizhix);
                dy = diff(weizhiy);
                angle = atan2(dy, dx);%������������֮��ĽǶ�
                
                angle_threshold = pi/12; % ���÷���仯��ֵ15�㣨�����ж��Ƿ���ڷ���仯��������ʵ�����������ֵ
                
                if(size(angle,1)~=1)
                    angle_diff = abs(diff(angle));
                    direction_change_indicator = angle_diff > angle_threshold; % ͳ�Ʒ���仯�Ĵ���
                    
                    direction_change_count = sum(direction_change_indicator)+1;
                else
                    direction_change_count=1;
                end
                
                features(3,1)=direction_change_count;%������仯��������������������ά
                
                %����ע�ӵ�ɢ��
                center_x = mean(weizhix);% ����ע�ӵ������λ��
                center_y = mean(weizhiy);
                
                distances = (weizhix - center_x).^2 + (weizhiy - center_y).^2; % ����ע�ӵ㵽����λ�õľ���
                
                fixation_dispersion = mean(distances);
                features(4,1)=fixation_dispersion;%��ע�ӵ�ɢ�ȸ���������������ά
                
                %����ע�ӳ���ʱ��ɢ��
                center_time = mean(duration);
                distime=(duration-center_time).^2;
                duration_dispersion=mean(distime);
                features(5,1)=duration_dispersion;%��ע�ӵ�ʱ��ɢ�ȸ���������������ά
                
                %�������켣����
                D=pdist(weizhi);
                Dmax=max(D);
                if(isempty(Dmax)==1)
                    Dmax=0;
                end
                features(6,1)=Dmax;%�����켣���븳��������������ά
                
                %����ע�ӵ����
                shuliang=size(weizhix,1);
                features(7,1)=shuliang;%��ע�ӵ��������������������ά
                
                %����ע��ʱ�䷶Χ
                shijianfanwei=max(duration)-min(duration);
                features(8,1)=shijianfanwei;%��ע��ʱ�䷶Χ�������������ڰ�ά
                
                %����ע�ӵ�֮��ƽ������
                pingjunjuli=mean(juli);
                features(9,1)=pingjunjuli;%��ƽ�����븳�����������ھ�ά
                tdfeatures{k,i}=features;
            end
        end
    end
end


            
            