clear;
clc;
region=[0 3.6 0 3.6];
d=0.1;
[grid_points,x_grid_num,y_grid_num]=get_charger_points(region,d);
alpha=4.3246;
beta=0.34;
Rt = 47.968140070826117;
D=4.2;
%%%%
bool_pesa=1;
Rt_grid=zeros(1,size(grid_points,1));
if bool_pesa  
    p=load('.\result_data\Practice_Exp\practice_pesa_1.mat');
    charger_location=p.charger_point;
    for index_p=1:size(charger_location,1)
        p_x=charger_location(index_p,1);
        p_y=charger_location(index_p,2);
        for index_g=1:size(grid_points,1)
              dis=sqrt((grid_points(index_g,1)-p_x)^2+(grid_points(index_g,2)-p_y)^2);
              if dis<=D
                 Rt_grid(index_g)=Rt_grid(index_g)+alpha/(beta+dis)^2;
              end
        end
    end
    save('.\result_data\emr_pesa_d01.mat','Rt_grid');
else
    p=load('.\result_data\Practice_Exp\practice_random_2.mat');
    charger_location=p.charger_point;
    for index_p=1:size(charger_location,1)
        p_x=charger_location(index_p,1);
        p_y=charger_location(index_p,2);
        for index_g=1:size(grid_points,1)
              dis=sqrt((grid_points(index_g,1)-p_x)^2+(grid_points(index_g,2)-p_y)^2);
              if dis<=D
                 Rt_grid(index_g)=Rt_grid(index_g)+alpha/(beta+dis)^2;
              end
        end
    end
    save('.\result_data\emr_random.mat','Rt_grid');
end
















