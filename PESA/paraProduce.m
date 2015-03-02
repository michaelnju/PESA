%%！！！在实现控制变量进行比较的时候，主要的就是执行下面的一些操作：
% Rt_set=[0.01 0.015 0.02 0.025 0.03 0.035 0.04];
% chargerNum_set=[20 40 60 80 100 120];
% elpsilon_set=[0.3 0.4 0.5 0.6 0.7 0.8];
% save('.\parameter_data\points.mat','Rt_set','chargerNum_set','elpsilon_set');
% cs_n_1=ones(1,961);
% save('.\result_data\con_reduce.mat','cs_n_1');
% bi_n_1=[1];
% save('.\result_data\bi_reduce.mat','bi_n_1');
% utility_ij=[ 1 1.3 2.1 2.5 3.3;1.1 1.2 1.9 2.1 3.7; 0.9 1.5 2.5 2.7 3;1.3 1.38 1.41 2.57 4.2];
% save('.\parameter_data\utility_differ.mat','utility_ij');
%%%%
% p=load('.\parameter_data\utility_differ.mat');
% utility=p.utility_ij;
% [Max_u,Xu]=DA_GSC(utility);

%%%%！！！产生边长是200的devices坐标，个数是200；
% D=3;
% d=7;
% num=floor(D/d+sqrt(2));
% ep2=0.3667;
% % beta=88.1835;
% % d=sqrt(2)/4*beta*(1/(sqrt(1-ep2))-1);
% bata=d*2*sqrt(2)/(1/sqrt(1-ep2)-1);
% d=sqrt(2)/4*beta*(1/(sqrt(1-ep2))-1);
% emr=C2*alpha/(beta^2);

%%！！下面用于产生device number分别是50,100,150,200,250,300

% device_300=rand(50,2)*160;
% p=load('.\parameter_data\device_differ_num.mat');
% device_250=p.device_250;
% device_300=[device_250;device_300];
% save('.\parameter_data\device_differ_num.mat','device_300','-append');


%%产生100个点，区域是320的一个区域。


%%%下面产生的是0-4.2这样区域的10个device；

% device_points_10_4_2=rand(10,2)*4.2;
% save('.\parameter_data\points.mat','device_points_10_4_2','-append');


%%%%%%%%%%%%%%%%%产生 0 20 0 20 50个charger
% device_point_20_50=rand(50,2)*20;
% save('.\parameter_data\points.mat','device_point_20_50','-append');
p=load('.\parameter_data\730_Device_Points_10step.mat');
point=p.device_50;
index=floor(rand(1,25)*50);
device_25=zeros(25,2);
for i=1:25
    if index(i)==0
        index(i)=index(i)+1;
    end
    device_25(i,:)=point(index(i),:);
end
save('.\parameter_data\730_Device_Points_10step.mat','device_25','-append');























% device_points_100_160=rand(100,2)*160;
% save('.\parameter_data\points.mat','device_points_100_160','-append');