%%%这个函数用来实现，没有只有一个区域的情况。

function [utility,xi] = FinalOutput2(Region,D,d,charger_num,devices_points_set,ep1,alpha,beta,Rt,C1,C2,first)
    bool2=2;
    filename='.\middle_data\ChargerNumber_differ_test.mat';
    %%%  num2str((Rt-0.14)/0.03)  for Rt
    %%% num2str(charger_num)  for charger_num
    constraints_filename = strcat('.\middle_data\ChargerNum\constraints_',num2str(charger_num),'.mat');
    if first==1
                [charger_points,constraints,bi]=Constraints_extract(Region,d,D,alpha,beta,Rt,C2,bool2);
                c_num=size(constraints,1);
                constraints(c_num+1,:)=ones(1,c_num);
                bi(c_num+1)=charger_num/(1-ep1); %%%注意这里的改动
                [constraints,bi] = Constraints_reduce(constraints,bi);
                 save(constraints_filename,'constraints','bi');              
    else
                p=load(filename);
                charger_points=p.charger_points;
                p2=load(constraints_filename);
                constraints=p2.constraints;
                bi=p2.bi;
    end
    pi_charger_utility=GetUtility(charger_points,Region,D,devices_points_set,d,alpha,beta,C1,bool2); %=GetUtility(charger_points,region,D,device_points,d,alpha,beta,C1,bool1_2)
    [utility,xi]=LP_approx_Random(constraints,bi,pi_charger_utility,ep1,devices_points_set,charger_points,charger_num,D,C1,alpha,beta);
end


