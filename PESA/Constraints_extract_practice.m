
%新增 Input 参数： device的坐标，和限制距离。
%%%增加一个判断功能，判断距离所有有的device在一个范围之外。
function [charger_remained,constraints,bi]=Constraints_extract_practice(region,d,D,alpha,beta,Rt,C2)
     format long;
     [charger_points,x_grid_num,y_grid_num]=get_charger_points(region,d);
     k=y_grid_num*x_grid_num;
     constraints=eye(k)*(C2*alpha/(beta^2)); %主对角线上的d=0;
     %将sum(xi)<n加入
     bi=ones(k,1)*Rt;
     effective_len=(D+2*sqrt(2)*d)^2;  %这个是真实的用于判断是否存在影响的有效距离。
     effective_num=floor(D/d+2*sqrt(2)); %这个用于判断垂直和水平方向上方格的个数。
     for index=1:k
         if rem(index,x_grid_num)==0
             y_index=index/x_grid_num-1;
         else
              y_index=floor(index/x_grid_num);  %y轴(竖直）上的具体坐标，其下面有y_index个元素，所以y_index是从0开始
         end
         x_index=index-y_index*x_grid_num-1; %x轴(水平)方向上的位置，在这个位置的左边有x_index个元素，x_index也是从0开始。
         left=min(x_index,effective_num);
         right=min(x_grid_num-x_index-1,effective_num);
         down=min(y_index,effective_num);
         up=min(y_grid_num-y_index-1,effective_num);
         %下面分别从四个方向上进行约束条件的提取
         %先从下面开始，因为下面存在格子和上面存在格子肯定有一个满足
         if ~(down==0)
              for i=1:down %收集和index在同一竖行的下面的元素。
                 constraints(index,index-i*x_grid_num)=C2*alpha/((i-1)*d+beta)^2;
              end
              if ~(left==0)  
                 for l=1:left %收集和index在同一横行的左边的元素。
                     constraints(index,index-l)=C2*alpha/((l-1)*d+beta)^2;
                 end
                 for i=1:down   %收集第三象限的元素。
                     for l=1:left
                         index_now=index-i*x_grid_num-l;
                         dis_judge=(charger_points(index,1)-charger_points(index_now,1))^2+(charger_points(index,2)-charger_points(index_now,2))^2;
                         dis_compute=sqrt((i-1)^2+(l-1)^2)*d;
                         if dis_judge<=effective_len
                             constraints(index,index_now)=C2*alpha/(dis_compute+beta)^2;
                         end 
                     end
                 end
              end
              if ~(right==0) %此时收集第四象限的元素
                 for r=1:right
                     constraints(index,index+r)=C2*alpha/((r-1)*d+beta)^2;
                 end
                 for i=1:down
                     for r=1:right
                         index_now=index-i*x_grid_num+r;
                         dis_judge=(charger_points(index,1)-charger_points(index_now,1))^2+(charger_points(index,2)-charger_points(index_now,2))^2;
                         dis_compute=sqrt((i-1)^2+(r-1)^2)*d;
                         if dis_judge<=effective_len
                             constraints(index,index_now)=C2*alpha/(dis_compute+beta)^2;
                         end 
                     end
                 end
              end
         end
         if ~(up==0) %对称的上半部分
              for u=1:up
                 constraints(index,index+u*x_grid_num)=C2*alpha/((u-1)*d+beta)^2;
              end
              if ~(left==0)  %此时收集第二象限的元素
                 for l=1:left
                     constraints(index,index-l)=C2*alpha/((l-1)*d+beta)^2;
                 end
                 for u=1:up
                     for l=1:left
                         index_now=index+u*x_grid_num-l;
                         dis_judge=(charger_points(index,1)-charger_points(index_now,1))^2+(charger_points(index,2)-charger_points(index_now,2))^2;
                         dis_compute=sqrt((u-1)^2+(l-1)^2)*d;
                         if dis_judge<=effective_len
                             constraints(index,index_now)=C2*alpha/(dis_compute+beta)^2;
                         end 
                     end
                 end
              end
              if ~(right==0) %此时收集第一象限的元素
                 for r=1:right
                     constraints(index,index+r)=C2*alpha/((r-1)*d+beta)^2;
                 end
                 for u=1:up
                     for r=1:right
                         index_now=index+u*x_grid_num+r;
                         dis_judge=(charger_points(index,1)-charger_points(index_now,1))^2+(charger_points(index,2)-charger_points(index_now,2))^2;
                         dis_compute=sqrt((u-1)^2+(r-1)^2)*d;
                         if dis_judge<=effective_len
                             constraints(index,index_now)=C2*alpha/(dis_compute+beta)^2;
                         end 
                     end
                 end
              end
              
         end
     end
     %%%为了实际试验做的
     %%%保证开的区域不在[-0.6 1.8 -0.6 1.8]; 行和列要同时消去；
     charger_remained=charger_points;
     del_count=0;
     for column=1:k
         x=charger_points(column,1);
         y=charger_points(column,2);
         bool_del=0;
         if x>0.3&&x<3.3&&y>0.3&&y<3.3
             bool_del=1;
         end
         if bool_del
             del_column_row=column-(del_count);
             
             
             constraints(:,del_column_row)=[];   %%消去列
%              constraints(del_column_row,:)=[];   %消去行
%              bi(del_column_row,:)=[];
             charger_remained(del_column_row,:)=[];
             del_count=del_count+1;
         end
     end
     %%下面要做的就是把距离device_point小于tr_length的那些xi关掉，消去整列
%      
%      charger_remained=charger_points;
%      del_set=zeros(1,k);
%      device_num=size(device_point,1);
%      tr_length_p=tr_length^2;
%      del_count=0;
%      for column=1:k
%          x=charger_points(column,1);
%          y=charger_points(column,2);
%          bool_del=0;
%          for row=1:device_num
%              if (x-device_point(row,1))^2+(y-device_point(row,2))^2<tr_length_p
%                  bool_del=1;
%                  break;
%              end
%          end
%          if bool_del
%              del_column=column-(del_count);
%              constraints(:,del_column)=[];
%              charger_remained(del_column,:)=[];
%              del_count=del_count+1;
%              del_set(del_count)=column;   %%把删除的那个记录下来
%          end
%      end
     
     
     
     
end