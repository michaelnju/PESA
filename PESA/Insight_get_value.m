function [x_axis,y_axis] = Insight_get_value(device_points,charger_open_points,D)
%UNTITLED7 此处显示有关此函数的摘要
%   此处显示详细说明
    %先获得某一个每一个device周边的device_number和charger_open_points_number
    device_p=device_points;
    charger_o_p=charger_open_points;
    radius_length=D*D;
    device_number=size(device_points,1);
    charger_number=size(charger_open_points,1);
    index_device_charger_relation=zeros(device_number,3);
    for index_d=1:device_number
        num_device=0;
        for index_d_d=1:device_number
            if (device_p(index_d,1)-device_p(index_d_d,1))^2+(device_p(index_d,2)-device_p(index_d_d,2))^2<radius_length
                num_device=num_device+1;
            end
        end
        num_charger=0;
        for index_c=1:charger_number
            if (device_p(index_d,1)-charger_o_p(index_c,1))^2+(device_p(index_d,2)-charger_o_p(index_c,2))^2<radius_length
                num_charger=num_charger+1;
            end
        end
       index_device_charger_relation(index_d,1)=index_d;
       index_device_charger_relation(index_d,2)=num_device;
       index_device_charger_relation(index_d,3)=num_charger;
    end
    %找到x轴上最大的那个值
    m=max(index_device_charger_relation,[],1);
    upper=m(2);
    %%%依次求平均的方式找到y轴上的
    x_axis=zeros(1,upper);
    y_axis=zeros(1,upper);
    for u=1:upper
        y_charger=0;
        x_axis(u)=u;
        row=find(index_device_charger_relation(:,2)==u);  %%得到的是行号的集合
        total_line=size(row,1);
        %考虑下极端情况，就是没有这个点，是个断点：
       if total_line==0
           y_axis(u)=-1;
           continue;
       end
       for l=1:total_line
           line_no=row(l); %得到行号
           y_charger=y_charger+ index_device_charger_relation(line_no,3);
       end
       y_axis(u)=y_charger/total_line;
    end
    %%剔除掉-1的点
    del_set=find(y_axis==-1);
    if ~isempty(del_set)
        for del=1:size(del_set)
            x_axis(del_set(del)-(del-1))=[];
            y_axis(del_set(del)-(del-1))=[];
        end
    end
    
end

