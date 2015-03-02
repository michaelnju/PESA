

function [utility,xi,charger_points,emr] = FinalOutPut_Practice(Region,D,d,charger_num,devices_points_set,ep1,alpha,beta,Rt,C1,C2)
   %constraints_extract_practice的改动。把不能放charger的地方直接去掉,所以这里的charger_points也是被关上了的。
%     
bool=0;

if bool
    
     [charger_points,constraints,bi]=Constraints_extract_practice(Region,d,D,alpha,beta,Rt,C2);  %%得到的是charger remained
      save('.\middle_data\practice_pesa_final.mat','charger_points','constraints','bi');
else
         p=load('.\middle_data\practice_pesa_final.mat');
         constraints=p.constraints;
         bi=p.bi;
         charger_points=p.charger_points;

    
end
   
    


%     row_num=size(constraints,1);
%     column_num=size(constraints,2);
%     constraints(row_num+1,:)=ones(1,column_num);
%     bi(row_num+1)=charger_num/(1-ep1); %%%注意这里的改动
%     [constraints,bi] = Constraints_reduce(constraints,bi);
%     save('.\middle_data\practice_pesa_final.mat','constraints','bi','-append');
%     pi_charger_utility=GetUtility(charger_points,Region,D,devices_points_set,d,alpha,beta,C1,bool2); %=GetUtility(charger_points,region,D,device_points,d,alpha,beta,C1,bool1_2)
    [utility,xi,emr]=LP_approx_Random(ep1,constraints,bi,devices_points_set,charger_points,charger_num,D,C1,alpha,beta);
end




