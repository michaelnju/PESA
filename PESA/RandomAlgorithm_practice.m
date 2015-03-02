

%%%这个函数增加的功能是，在一个点放下charger的时候，同时要判断他与所有device距离是否有超过阈值；
function [utility,charger_points,Device_EMR] = RandomAlgorithm_practice(region,d,n,Rt,alpha,beta,D,device_points,C1,C2)
    disp('random算法被调用');
    [grids_points,x_grid_num,y_grid_num]=get_charger_points(region,d);  %!!!!!!
    grid_num=x_grid_num*y_grid_num;
    Rt_grid=zeros(1,grid_num); %每个格子辐射初始值设为0.
    Device_EMR=zeros(1,size(device_points,1));
    %下面的函数用来每次随机的放置一个charger
    charger_points=zeros(n,2);
    utility=0;
    for charger_num=1:n
        disp(charger_num);
        while 1
%             disp('In while loop:');


            label_put_2=1;
            Rt_grid_copy=Rt_grid;
            point=rand(2,1);
            p_x=point(1)*(region(2)-region(1))+region(1);
            p_y=point(2)*(region(4)-region(3))+region(3);
            %%计算加入这个charger之后对每个格子的辐射的增加情况
            if  p_x>-0.9&&p_x<2.1&&p_y>-0.9&&p_y<2.1
                continue;
            end
            for index_g=1:grid_num
                dis=sqrt((grids_points(index_g,1)-p_x)^2+(grids_points(index_g,2)-p_y)^2);
                if dis<=D
                    Rt_grid_copy(index_g)=Rt_grid_copy(index_g)+C2*alpha/(beta+dis)^2;
                end
                if Rt_grid_copy(index_g)>=Rt %此次划分无效，退出循环。
                    label_put_2=0;
                    break;
                end
            end
            if ~label_put_2
                continue;
            end
            
            
            

            %如果对所有的格子在布置了up_times以下均没有超出的话，要更新一下每个格子新的辐射强度以及总的充电效率
            charger_points(charger_num,1)=p_x;
            charger_points(charger_num,2)=p_y;
            Rt_grid=Rt_grid_copy; %更新一下每个格子新的辐射强度
            for index_d=1:size(device_points,1)
                dis_=sqrt((device_points(index_d,1)-p_x)^2+(device_points(index_d,2)-p_y)^2);
                if dis_<= D
                    utility=utility+C1*alpha/(beta+dis_)^2;
                    Device_EMR(index_d)=Device_EMR(index_d)+C2*alpha/(dis_+beta)^2;
                end
            end
            break;
        end
    end
    disp('charger布满。最终的charger的个数是：');
end

