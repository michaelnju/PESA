    
D=10;
p=load('.\middle_data\xi_1.mat');
xi_=p.xi;
q=load('.\parameter_data\gaussion_point.mat');
devices_points_set=q.point;
charger_open_xi=find(xi_>0);
charger_open_location=zeros(size(charger_open_xi,1),2);
for index=1:size(charger_open_xi,1)
    charger_open_location(index,:)=xi_(charger_open_xi(index),:);
end
[x_axis,y_axis] = Insight_get_value(devices_points_set,charger_open_location,D);