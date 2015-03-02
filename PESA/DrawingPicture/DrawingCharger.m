p_pe = load('.\result_data\1127\chargernum.mat');

y_pe = p_pe.chargernum_f2 ;  %% pesa 得到的数据
y_tri=p_pe.chargernum_triangle;  %%三角的数据
y_ra=p_pe.chargernum_random;   %% random算法的数据
x=p_pe.chargernum_set;

% y_tri(4) = 10.4921801;
% chargernum_triangle = y_tri;
% save('.\result_data\1127\chargernum.mat','chargernum_triangle','-append');


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
