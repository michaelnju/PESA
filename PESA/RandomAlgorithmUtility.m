%这个函数的功能是用来实现 随机算法。
%region的输入格式是：[0 x 0 y]
% device_points_set的输入格式是：[x1 y1; x2 y2;...xn yn];
% C1是用于计算充电效率的参数
% C2是用于计算辐射的参数
function [utility] = RandomAlgorithmUtility(region,d,n,Rt,alpha,beta,D,up_times,device_points,C1,C2)
%UNTITLED5 此处显示有关此函数的摘要
%   此处显示详细说明
%   先将区域region按d划分，获得所有点的坐标
    disp('random算法被调用');
    [grids_points,x_grid_num,y_grid_num]=get_charger_points(region,d);  %!!!!!!
    grid_num=x_grid_num*y_grid_num;
    Rt_grid=zeros(1,grid_num); %每个格子辐射初始值设为0.
    %下面的函数用来每次随机的放置一个charger
    utility=0;
    for charger_num=1:n
        label_exit=0;
        for times=1:up_times
            Rt_grid_copy=Rt_grid;
            label_Over=0;
            point=rand(2,1);
            p_x=point(1)*region(2);
            p_y=point(2)*region(4);
            %%计算加入这个charger之后对每个格子的辐射的增加情况
            for index_g=1:grid_num
                dis=sqrt((grids_points(index_g,1)-p_x)^2+(grids_points(index_g,2)-p_y)^2);
                if dis<=D
                    Rt_grid_copy(index_g)=Rt_grid_copy(index_g)+C2*alpha/(beta+dis)^2;
                end
                if Rt_grid_copy(index_g)>=Rt %此次划分无效，退出循环。
                    label_Over=1;
                    break;
                end
            end
            if times==up_times&&label_Over==1
                label_exit=1; 
                break;
            end
            %如果对所有的格子在布置了up_times以下均没有超出的话，要更新一下每个格子新的辐射强度以及总的充电效率
            if ~label_Over 
                Rt_grid=Rt_grid_copy; %更新一下每个格子新的辐射强度
                for index_d=1:size(device_points,1)
                    dis_=sqrt((device_points(index_d,1)-p_x)^2+(device_points(index_d,2)-p_y)^2);
                    if dis_<= D
                        utility=utility+C1*alpha/(beta+dis_)^2;
                    end
                end
                break;
            end
        end
        if label_exit
            disp('charger未完全放置，最终的charger的个数是：');
            disp(charger_num);
            break;
        end
    end
    disp('charger布满。最终的charger的个数是：');
    disp(charger_num);
end

