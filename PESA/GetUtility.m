%
% 作用：
% 1.将区域扩展D，通过get_charger_points获得方格的坐标。
% 2.计算这些区域内有哪些devices。
% 3.计算每一块小方格对这些devices的充电效用cj。返回的值k*1的行向量；
function[pi_charger_utility]=GetUtility(charger_points,region,D,device_points,d,alpha,beta,C1,bool1_2)

    if bool1_2==1
       region=region+[-D D -D D];%将区域扩充D
    end
   
    devices_in_region=select_deivices(device_points,region);%区域内所有设备的坐标二维数组，n*2
    %charger_points,区域内所有充电器的坐标，也就是每个格子中间位置的坐标，k*2的数组
    pi_charger_utility=count_pi(charger_points,devices_in_region,D,alpha,beta,C1); %每个格子产生的充电效能，k*1的列向量
    
    %
    %select_deivices函数用来获得某个区域里包含的device的坐标
    %
    function devices_in_region=select_deivices(device_points,region)
        devices_in_=zeros(size(device_points,1),2);
        num=0;
        for i_=1:size(device_points,1)
            if device_points(i_,1)>region(1) && device_points(i_,1)<region(2)
                if device_points(i_,2)>region(3) && device_points(i_,2)<region(4)
                    num=num+1;
                    devices_in_(num,:)=device_points(i_,:);
                end
            end
        end
        if num==0
            devices_in_region=[];
        else
             devices_in_region=devices_in_(1:num,:);
        end
   end
    %
    %函数 dividing_grids用来获得将区域使用d进行划分之后所有格子的坐标,返回k*2的数组
    %

    %下面函数用于计算每个区域的小方格内的充电效用p,返回k*1的列向量
    function p=count_pi(charger_points,devices_points,D,alpha,beta,C1)
        p=zeros(1,size(charger_points,1)); %%修改过一次。这个目标项设成行向量
        if ~isempty(devices_points)
            for charger_i=1:size(charger_points,1)
                for devices_i=1:size(devices_points,1)
                    dis=sqrt((charger_points(charger_i,1)-devices_points(devices_i,1))^2+(charger_points(charger_i,2)-devices_points(devices_i,2))^2);
                    if dis<=D
                        p(charger_i)= p(charger_i)+C1*alpha/(beta+dis)^2;
                    end
                end
            end   
        end
    end
    %用来获得每个约束条件 目标是得到k*k的约束项数组
end




