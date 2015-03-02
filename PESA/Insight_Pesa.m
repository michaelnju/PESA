clear;
clc;
Region=[0 20 0 20];
D=3;
C2=1;
C1=1;
d=1;
alpha=10;
beta=10;
Rt=0.8;
n=30;   %charger_num
second = 1;
first = 0;
epsilon=0.8;
epsilon=epsilon/2;
ep1=min(epsilon/2,1/(n+2));
p=load('.\parameter_data\gaussion_point.mat');
gaussion_point=p.point_in;
[x,y]=FinalOutPut_insight(Region,D,d,n,gaussion_point,ep1,alpha,beta,Rt,C1,C2,first,second);
    del_set=find(y<0);
    if ~isempty(del_set)
        for del=1:size(del_set,2)
            x(del_set(del)-(del-1))=[];
            y(del_set(del)-(del-1))=[];
        end
    end
save('.\result_data\insight_PESA_3.mat','x','y');
plot(x,y,'-b');
xlabel('\fontsize {16}\fontname {Helvetica}PESA');
%%把xi对应的坐标求出来

