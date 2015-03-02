%%%这个函数用来实现，没有只有一个区域的情况。

function [x_axis,y_axis] = FinalOutPut_insight(Region,D,d,charger_num,devices_points_set,ep1,alpha,beta,Rt,C1,C2,first,second)
    bool2=2;

    c_filename = '.\middle_data\re160_d10.mat';  %%存放的是只和区域及d,D有关的小区域划分后的约束项，一般不会变；
    c=load(c_filename);
    charger_points=c.charger_points;
    constraints = c.constraints;   
    bi = c.bi;
    if first==1
      c_num=size(constraints,1);
      constraints(c_num+1,:)=ones(1,c_num);
      bi(c_num+1)=charger_num/(1-ep1); %%%注意这里的改动
      [constraints_reduced,bi] = Constraints_reduce(constraints,bi);
      save('./middle_data/insight.mat','constraints_reduced','bi');
    else
        filename='.\middle_data\insight.mat';
        p=load(filename);
        constraints_reduced=p.constraints_reduced;
        bi=p.bi;     
    end

    if second
        pi_charger_utility=GetUtility(charger_points,Region,D,devices_points_set,d,alpha,beta,C1,bool2); %=GetUtility(charger_points,region,D,device_points,d,alpha,beta,C1,bool1_2)
        [utility,xi]=LP_approx_Random(constraints_reduced,bi,pi_charger_utility,ep1,devices_points_set,charger_points,charger_num,D,C1,alpha,beta);
        save('.\middle_data\xi_1204.mat','xi');
    else
        p=load('.\middle_data\xi_1204.mat');
        xi=p.xi;
    end
    charger_open_xi=find(xi>0);
    charger_open_location=zeros(size(charger_open_xi,1),2);
    for index=1:size(charger_open_xi,1)
        charger_open_location(index,:)=charger_points(charger_open_xi(index),:);
    end
    [x_axis,y_axis] = Insight_get_value(devices_points_set,charger_open_location,D);
end


