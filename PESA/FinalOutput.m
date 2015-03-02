% author:Lingtao Kong
% 2014.7.17
% first version
% Input:
% Region,充电区域的有效范围，输入格式是[x1 x2 y1 y2]
% D是有效的充电半径
% d是第二次划分区间时的长度
% k是划分k-grid时候的参数
% charger_num是充电器的数量
% devices_points_set是设备的坐标的集合
% epsilon是用于近似的参数
% alpha，beat是充电效用的参数
% Rt是充电辐射的阈值。
% Output:
% U_output表示的此区域最大的充电效用
% Yk_output,Xk_output表示采用的关闭方案，Y..是在Y轴上的坐标
% X_subregion_num表示此种划分方案对应的x轴上的个数，Y_subregion_num表示y轴上的个数。
% Charger_allocation,充电器在每个区域的分配情况，
% Charger_placement, 充电器在每个区域的放置方案即Xi

function [U_output,Yk_output,Xk_output,Charger_allocation,Charger_placement,X_subregion_num,Y_subregion_num]=FinalOutput(Region,D,d,k,charger_num,devices_points_set,ep1,alpha,beta,Rt,C1,C2)
    % 外层循环，循环每一种划分策略(i,j)，得到对应的划分最好的布置策略以及最大效率。；共k*k种
    bool_1=1;%%和FinalOutput2区分开来
    bool_2=2;
    U_output=0;
    Yk_output=1;
    Xk_output=1;
    Charger_allocation=[]; %充电器的分配策略
    Charger_placement=[];  %充电器在每一个区域的开关策略。
    X_subregion_num=0;
    Y_subregion_num=0;
    new_sub_area_location=GridFormation(Region,D,k);  %new_sub_area_location是2层元胞数组，存储k*k种区域划分分别对应的情况。
    lable_exit=0;
    
     for index_y=1:k %竖直方向上
        for index_x=1:k %水平方向上
            
            lable_exit=0;
            disp('index_x是：');
            disp(index_x);
            region=new_sub_area_location{index_y,index_x};
            utility=zeros(size(region,1)*size(region,2),charger_num); %存储某个区域对应的utility(i,j)
            Xi=cell(size(region,1)*size(region,2),charger_num); %存储 某个区域对应的xi
            
            
            for index_sub_y=1:size(region,1)
                for index_sub_x=1:size(region,2)
                    %对于每一块子区域计算分别放置1-devices_num个charger的情况
                    index_k=(index_sub_y-1)*size(region,2)+index_sub_x;
                    sub_region=region{index_sub_y,index_sub_x}; %得到 [x1 x2 y1 y2]
                    new_region_label=1;
                    [charger_points,constraints,bi]=Constraints_extract(sub_region,d,D,alpha,beta,Rt,C2,bool_1);
                    filename=strcat('.\middle_data\constraints_',num2str(index_k),'.mat');
                    save(filename,'charger_points','constraints','bi');
                    if size(constraints,1)<charger_num
                        lable_exit=1;
                        break;
                       
                    end
                    for n=1:charger_num
                        p=load(filename);
                        charger_points=p.charger_points;
                        constraints=p.constraints;
                        bi=p.bi;
                        c_num=size(constraints,1);
                        constraints(c_num+1,:)=ones(1,c_num);
                        bi(c_num+1)=n/(1-ep1); %%%注意这里的改动
%                       [charger_points,constraints,bi]=Constraints_extract(sub_region,d,D,alpha,beta,Rt,n,C2,ep1);  %%%%这部分程序还可以改进。
                        [constraints,bi] = Constraints_reduce(constraints,bi);   %%%bug修改，要考虑charger_num多于格子的
                        bbb=size(bi,1);
                        pi_charger_utility=GetUtility(charger_points,sub_region,D,devices_points_set,d,alpha,beta,C1,bool_1);
                        
                disp('元素是:');
                disp(size(constraints,1));
                disp(size(bi,1));
                        
                        
                

                    [z,xi]=LP_approx(constraints,bi,pi_charger_utility,ep1);
                    utility(index_k,n)=z;
                    Xi{index_k,n}=xi;
                    end
                end
                if  lable_exit
                    break;
                    
                end
            end
            %%% 找到这种划分对应的这个区域里最大的U和I，调用DA_GSC函数 Xu
     
            if ~lable_exit
                    [Max_u,Xu]=DA_GSC(utility);
            %当出现新的更大的utility的时候进行更新
                    if U_output<Max_u
                        U_output=Max_u;
                        Yk_output=index_y;
                        Xk_output=index_x;
                        Charger_allocation=Xu;
                        X_subregion_num=size(region,2); 
                        Y_subregion_num=size(region,2);
                        Charger_placement=cell(size(Xu,1),1);
                        for index_Xu=1:size(Xu,1)
                            Charger_placement{index_Xu,1}=Xi{Xu(index_Xu,1),Xu(index_Xu,2)}';
                        end
                    end
            end
        end
    end
end