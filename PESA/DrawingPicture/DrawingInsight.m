clear;
clc;
p_pesa=load('.\result_data\insight_PESA_3.mat');
x=p_pesa.x;
y=p_pesa.y;
%     del_set=find(y<0);
%     if ~isempty(del_set)
%         for del=1:size(del_set,2)
%            x(del_set(del)-(del-1))=[];
%             y(del_set(del)-(del-1))=[];
%         end
%     end
%     save('.\result_data\insight_PESA_n70_rt08.mat','y');
%     
% save('.\result_data\insight_PESA_n70_rt08.mat','x','-append');
% p_r=load('.\result_data\insight_random_n70.mat');
p_r=load('.\result_data\insight_random.mat');
r_x=p_r.x;
r_y=p_r.y;
% p_a=load('.\result_data\insight_angle_n70.mat');
p_a=load('.\result_data\insight_angle.mat');
a_x=p_a.x;
a_y=p_a.y;
plot(x,y,'-b.',r_x,r_y,'-g*',a_x,a_y,'-r+');
str1='\fontsize {16}\fontname {Helvetica}PESA';
 str2='\fontsize {16}\fontname {Helvetica}Random';
 str3='\fontsize {16}\fontname {Helvetica}Triangle';
 hleg=legend(str1,str2,str3);
% hleg=legend(str2,str3);
set(hleg,'Location','NorthWest');
hold on;
set(gca,'FontSize',16);
fh=figure(1);xlabel('\fontsize {16}\fontname {Helvetica}Device Number');
% ylabel('\fontsize {16}\fontname {Helvetica} Charger Number');




