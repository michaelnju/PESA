
x=[ 0.2 0.47 1.13 0.2 0.13 0.07 0.27 0.47 0.5 0.6 ];
y=[0.15 0.2 0.65 0.85 0.95 1.15 1.10 1.0 1.18 0.93];
device_location=[x',y'];

x=[ 0.950000000000000  -0.650000000000000  -0.650000000000000  -0.050000000000000   0.650000000000000];
y=[-0.750000000000000   0.750000000000000   1.350000000000000   1.850000000000000   1.850000000000000];
PESA_charger_location=[x',y'];

x=[-0.371800000000000  -0.766700000000000   0.401100000000000   0.998000000000000   1.977800000000000];
y=[ 1.940300000000000  -0.794000000000000   2.091400000000000  -0.801900000000000   0.529100000000000];

charger_area_boundary_1=[0 0;0 3;3 3;3 0;0 0];
charger_area_boundary_2=[0.3 0.3;2.7 0.3;2.7 2.7;0.3 2.7;0.3 0.3];
rand_charger_location=[x',y'];

device_location=device_location+0.9;
PESA_charger_location=PESA_charger_location+0.9;
rand_charger_location=rand_charger_location+0.9;


clear figure;
plot(device_location(:,1),device_location(:,2),'r+','MarkerSize',8,'MarkerFaceColor','r','LineWidth',2);
hold on;
plot(PESA_charger_location(:,1),PESA_charger_location(:,2),'bd','MarkerSize',8,'MarkerFaceColor','b','LineWidth',2);
hold on;
plot(rand_charger_location(:,1),rand_charger_location(:,2),'gs','MarkerSize',8,'MarkerFaceColor','g','LineWidth',2);
hold on;
plot(charger_area_boundary_1(:,1),charger_area_boundary_1(:,2),'--k','LineWidth',2);
hold on;
plot(charger_area_boundary_2(:,1),charger_area_boundary_2(:,2),'--k','LineWidth',2);

str1='\fontsize {10}\fontname {Helvetica}Device';
str2='\fontsize {10}\fontname {Helvetica}Charger(PESA)';
str3='\fontsize {10}\fontname {Helvetica}Charger(Random)';
 hleg=legend(str1,str2,str3);
 set(hleg,'Location','West');  %%%
hold on;
set(gca,'FontSize',16);
fh=figure(1);
set(fh, 'color', 'white'); 
xlim([-0.1 3.1]);
ylim([-0.1 3.1]);
axis square;
xlabel('\fontsize {16}\fontname {Helvetica}x (m)');
ylabel('\fontsize {16}\fontname {Helvetica}y (m)');