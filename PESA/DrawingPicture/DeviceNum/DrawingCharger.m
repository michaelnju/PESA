p_pe = load('E:\ทยีๆ_final\result_data\1127\chargernum.mat');
% y_pe=p_pe.chargernum_F2_utility;
y_pe = p_pe.chargernum_f2 ;
y_tri=p_pe.chargernum_triangle;
y_ra=p_pe.chargernum_random; 
x=p_pe.chargernum_set;

% chargernum_f2 = y_pe(3:end);
% chargernum_random = y_ra(3:end);
% chargernum_triangle = y_tri(3:end);
% chargernum_set = x(3:end);
% save('E:\ทยีๆ_final\result_data\1127\chargernum.mat','chargernum_set','chargernum_f2','chargernum_random','chargernum_triangle');


plot(x,y_pe,'-b.',x,y_ra,'-g*',x,y_tri,'-r+');
str1='\fontsize {16}\fontname {Helvetica}PESA';
str2='\fontsize {16}\fontname {Helvetica}Random';
str3='\fontsize {16}\fontname {Helvetica}Triangle';
hleg=legend(str1,str2,str3);
set(hleg,'Location','NorthWest');
hold on;
set(gca,'FontSize',16);
fh=figure(1);
set(fh, 'color', 'white'); 
xlabel('\fontsize {16}\fontname {Helvetica}The Number of Charger');
ylabel('\fontsize {16}\fontname {Helvetica} Utility');
