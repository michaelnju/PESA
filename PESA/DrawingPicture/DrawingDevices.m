
data = load('./result_data/1127/device.mat');

y_pe = data.F2_utility;
y_ra = data.Random_utility;
y_tri = data.Triangle_utility;
x = data.devicenum_set;
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
xlabel('\fontsize {16}\fontname {Helvetica}The Number of Device');
ylabel('\fontsize {16}\fontname {Helvetica} Utility');
