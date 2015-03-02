% 这个函数用来获得一块区域在使用d划分之后得到的每一块区域的中心点的位置
% charger_points=ones(k,2);  
% region为扩充之后的区域
function [charger_points,x_grid_num,y_grid_num]=get_charger_points(region,d)
        x_grid_num=floor((region(2)-region(1))/d);  %在x轴方向上的格子数
        y_grid_num=floor((region(4)-region(3))/d);  %在y轴方向上的格子数
        k=y_grid_num*x_grid_num;
        charger_points=ones(k,2);  
        for i__=1:y_grid_num
            for j__=1:x_grid_num
                charger_points((i__-1)*x_grid_num+j__,1)=region(1)+(j__-1)*d+d/2;
                charger_points((i__-1)*x_grid_num+j__,2)=region(3)+(i__-1)*d+d/2;
            end
        end
end

