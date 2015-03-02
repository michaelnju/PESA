clear;
side_length=20;
region=[0 side_length 0 side_length];
device_num=100;
dimension=2;
sensor=normrnd(side_length/2,side_length/4,100,dimension);
% point_in=zeros(100,2);
point_in_index=0;
sensor=sensor(:,1:2);   
for index=1:100
    if sensor(index,1)>0&&sensor(index,1)<20
        if sensor(index,2)>0&&sensor(index,2)<20
              point_in_index=point_in_index+1;
            point_in(point_in_index,:)=sensor(index,:);
          
        end
    end
end
point_in=point_in(1:point_in_index,:);
% p=load('.\parameter_data\gaussion_point.mat');
save('.\parameter_data\gaussion_point.mat','point_in');
axis([0 50 0 50],'square');
plot(point_in(:,1),point_in(:,2),'*b');





%%5













