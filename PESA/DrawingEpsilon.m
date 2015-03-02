x=[0.65	0.675	0.700	0.725	0.750	0.775	0.800	0.825	0.850	0.875 0.900 ];
y_pe=[0.081896884285796	0.0805788652591842	0.0800626797124603  0.078702234757091 0.077563038505309 0.0765970406174014	0.0752604072645917 	0.0750615018596897   	0.074851127167196	0.0745371989387479 0.0708935586451524	];
y_ra=ones(1,size(x,2))*0.0544;
y_tri=ones(1,size(x,2))*0.05288;
plot(x,y_pe,'-b.',x,y_ra,'-g*',x,y_tri,'-r+');
str1='\fontsize {16}\fontname {Helvetica}PESA';
str2='\fontsize {16}\fontname {Helvetica}Random';
str3='\fontsize {16}\fontname {Helvetica}Triangle';
 hleg=legend(str1,str2,str3);
 set(hleg,'Location','West');  %%%
hold on;
set(gca,'FontSize',16);
fh=figure(1);
set(fh, 'color', 'white'); 
xlabel('\fontsize {16}\fontname {Helvetica}The Value of Epsilon');
ylabel('\fontsize {16}\fontname {Helvetica} Utility');