
n=10;   %%有10个charger
side_length=160;
region=[0 side_length 0 side_length];
alpha=100;
D=10;
d=10;
epsilon=0.9;
epsilon=epsilon/2;

ep1=min(epsilon/2,1/(n+2));
ep2=epsilon-ep1;
C2=1; %EMR model
C1=1; %utility model
beta=d*2*sqrt(2)/(1/(sqrt(1-ep2))-1);
rt=C2*alpha/(beta^2);
p=load('.\parameter_data\points.mat');
device_points=p.device_points_100_160;
Rt=4*rt;
error=0.05;
d=1; %%!!!!
[utility,num_n] = TriangleAlgorithm(region,d,Rt,alpha,beta,D,device_points,C1,C2,error,n);
disp('充电效率是：');
disp(utility);
disp('布置的个数：');
disp(num_n);