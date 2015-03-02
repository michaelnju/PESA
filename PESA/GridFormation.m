% author:Lingtao Kong
% 2014.7.14
% first version

% 这个函数的功能：对区域region按D和k进行划分形成k-grid.然后对这些区域执行相同的关闭策略，共k*k种，存储所有这些划分形成的新区域的位置。
% Input:
% region是充电的有效区域。
% D是充电的有效距离，
% k是每个区域设置的格子数目
% Output:
% 
% sub_region_num：总共的区域的数目
% location：元胞数组，存储划分之后每个k-grid子区域的地址范围
% distance_sub_area：一个k-grid区域的跨度范围；
% new_location:元胞数组，存储子区域执行相同的关闭策略之后的新形成的每个子区域的地址范围
% new_location_sub_area:元胞数组，用于存储每种划分情况对应的区域的位置，其每一个元素仍然是一个元宝数组，存储的是具体的划分
% 如
% sub_area=new_location_sub_area{1,1}是对应(1,1)划分之后的区域。sub_area{1,1}对应的是这个区域的第一块子区域的位置
function new_sub_area_location=GridFormation(region,D,k)
    d=4*D;
    x_grid_num=ceil((region(2)-region(1))/d); % x轴上格子的总数
    y_grid_num=ceil((region(4)-region(3))/d); %y轴上划分的区域的数目
    x_sub_num=ceil(x_grid_num/k);   %x轴上划分的区域的数目
    y_sub_num=ceil(y_grid_num/k);   %y轴上划分的区域的数目
    new_sub_area_location=cell(k,k);    %存储划分之后的区域,共k*k种划分，所以对应这么k*k个原包数组。
    location=cell(y_sub_num,x_sub_num); %存储没有划分之前的区域情况，作用不是很大。
    for i=1:y_sub_num
        for j=1:x_sub_num
            location{i,j}=[(j-1)*k*d,j*k*d,(i-1)*k*d,i*k*d]; 
        end
    end
    %下面的代码记录在执行第i种(k*k)种关闭策略之后对应的每一个区域的位置
    for i=1:k   %%！！！pay attention to this that i is related to the y-axis ,j is related to the 
        for j=1:k
            if i==1 %!!!!i==1的时候是从最底行开始划分
                new_location=cell(y_sub_num,x_sub_num);%新区域的个数变数
                if j==1  %这种情况下，新区域在右上角
                    for new_i=1:y_sub_num
                        for new_j=1:x_sub_num
                            new_location{new_i,new_j}=[location{new_i,new_j}(1,1)+d,location{new_i,new_j}(1,2),location{new_i,new_j}(1,3)+d,location{new_i,new_j}(1,4)];
                        end
                    end
                   % new_sub_area_location{i,j}=new_location;
                elseif j==k %这种情况下，新区域出现在左上角
                     for new_i=1:y_sub_num
                        for new_j=1:x_sub_num
                            new_location{new_i,new_j}=[location{new_i,new_j}(1,1),location{new_i,new_j}(1,2)-d,location{new_i,new_j}(1,3)+d,location{new_i,new_j}(1,4)];
                        end
                     end
                    %new_sub_area_location{i,j}=new_location;
                else %在这种情况下，x轴方向上（列方向上）会多出来一个区域形成(x_sub_num)*(y_sub_num+1) 
                     new_location=cell(y_sub_num,x_sub_num+1);
                     for new_i=1:y_sub_num
                        for new_j=1:x_sub_num+1
                            if new_j==1 %第一个区域
                                new_location{new_i,1}=[0,(j-1)*d,(new_i-1)*k*d+d,new_i*k*d];
                            elseif new_j==x_sub_num+1 %最后一个区域
                                new_location{new_i,new_j}=[(x_sub_num-1)*k*d+j*d,x_sub_num*k*d,(new_i-1)*k*d+d, new_i*k*d];
                            else %中间区域
                                new_location{new_i,new_j}=[(new_j-2)*k*d+j*d,(new_j-1)*k*d+(j-1)*d,(new_i-1)*k*d+d,new_i*k*d];
                            end
                        end
                     end
                end
            elseif i==k % !!!!i==k的时候是从第顶行开始划分
                new_location=cell(y_sub_num,x_sub_num);
                if j==1 %这种情况，原有区域个数不变新的区域出现在右下角
                    for new_i=1:y_sub_num
                        for new_j=1:x_sub_num
                            new_location{new_i,new_j}=[location{new_i,new_j}(1,1)+d,location{new_i,new_j}(1,2),location{new_i,new_j}(1,3),location{new_i,new_j}(1,4)-d];
                        end
                    end               
               elseif j==k %这种情况，原有区域个数不变新的区域出现在左下角
                    for new_i=1:y_sub_num
                        for new_j=1:x_sub_num
                            new_location{new_i,new_j}=[location{new_i,new_j}(1,1),location{new_i,new_j}(1,2)-d,location{new_i,new_j}(1,3),location{new_i,new_j}(1,4)-d];
                        end
                    end  
               else %在这种情况下，x轴方向上（列方向上）会多出来一个区域形成(y_sub_num)*(x_sub_num+1) 
                    new_location=cell(y_sub_num,x_sub_num+1);
                    for new_i=1:y_sub_num
                        for new_j=1:x_sub_num+1
                            if new_j==1 %第一个区域
                                new_location{new_i,1}=[0,(j-1)*d,(new_i-1)*k*d,new_i*k*d-d];
                            elseif new_j==x_sub_num+1 %最后一个区域
                                new_location{new_i,new_j}=[(x_sub_num-1)*k*d+j*d,x_sub_num*k*d,(new_i-1)*k*d,new_i*k*d-d];
                            else %中间区域
                                new_location{new_i,new_j}=[(new_j-2)*k*d+j*d,(new_j-1)*k*d+(j-1)*d,(new_i-1)*k*d,new_i*k*d-d];
                            end
                        end
                     end
               end
            
            else % !!!!从中间开始划分
                if j==1 % 这种情况会产生（y_sub_num+1)*(x_sub_num)
                     new_location=cell(y_sub_num+1,x_sub_num);
                     for new_i=1:y_sub_num+1
                        for new_j=1:x_sub_num
                            if new_i==1 %对应最底排的区域
                                new_location{1,new_j}=[(new_j-1)*k*d+d,new_j*k*d,0,d*(i-1)];
                            elseif new_i==y_sub_num+1 %最后一个区域
                                new_location{new_i,new_j}=[(new_j-1)*k*d+d,new_j*k*d,(y_sub_num-1)*k*d+i*d,y_sub_num*k*d];
                            else %中间区域
                                new_location{new_i,new_j}=[(new_j-1)*k*d+d,new_j*k*d,(new_i-2)*k*d+i*d,(new_i-1)*k*d+(i-1)*d];
                            end
                        end
                     end
                    
                elseif j==k % 这种情况会产生（y_sub_num+1)*(x_sub_num)
                     new_location=cell(y_sub_num+1,x_sub_num);
                     for new_i=1:y_sub_num+1
                        for new_j=1:x_sub_num
                            if new_i==1 %对应最底排的区域
                                new_location{1,new_j}=[0,new_j*k*d-d,0,d*(i-1)];
                            elseif new_i==y_sub_num+1 %最后一个区域
                                new_location{new_i,new_j}=[0,new_j*k*d-d,(y_sub_num-1)*k*d+i*d,y_sub_num*k*d];
                            else %中间区域
                                new_location{new_i,new_j}=[0,new_j*k*d-d,(new_i-2)*k*d+i*d,(new_i-1)*k*d+(i-1)*d];
                            end
                        end
                     end
                else   % !!!!从中间开始划分，因为上面我们已经考虑完极端情况所以这种情况相对简单。会产生(x_sub_num+1)*(y_sub_num+1)个
                
                    new_location=cell(y_sub_num+1,x_sub_num+1);
                    for new_i=1:y_sub_num+1 %自底向上
                        for new_j=1:x_sub_num+1 %自左向右
                            if new_i==1  % new_i==1是最底下的区域
                               if new_j==1 %第一个区域
                                    new_location{1,1}=[0,(j-1)*d,0,(i-1)*d];
                                elseif new_j==x_sub_num+1 %最后一个区域
                                    new_location{1,new_j}=[d*k*(x_sub_num-1)+j*d,d*k*x_sub_num,0,(i-1)*d];
                                else %中间区域
                                    new_location{new_i,new_j}=[(new_j-2)*k*d+j*d,(new_j-1)*k*d+(j-1)*d,0,(i-1)*d];
                                end

                            elseif new_i==y_sub_num+1 % new_i==y_sub_num+1对应的是最上面的区域
                                   if new_j==1 %第new_i,1一个区域
                                        new_location{new_i,1}=[0,(j-1)*d,(y_sub_num-1)*k*d+i*d,y_sub_num*k*d];
                                   elseif new_j==x_sub_num+1 %最后一个区域
                                         new_location{new_i,new_j}=[d*k*(x_sub_num-1)+j*d,d*k*x_sub_num,(y_sub_num-1)*k*d+i*d,y_sub_num*k*d];
                                   else %中间区域
                                        new_location{new_i,new_j}=[d*k*(new_j-2)+j*d,d*k*(new_j-1)+(j-1)*d,(y_sub_num-1)*k*d+i*d,y_sub_num*k*d];
                                   end
                            else % new_i对应的是中间的区域
                                   if new_j==1 %第new_i,1一个区域
                                        new_location{new_i,1}=[0,(j-1)*d,(new_i-2)*k*d+i*d,(new_i-1)*k*d+(i-1)*d];
                                   elseif new_j==x_sub_num+1 %最后一个区域
                                         new_location{new_i,new_j}=[d*k*(x_sub_num-1)+j*d,d*k*x_sub_num,(new_i-2)*k*d+i*d,(new_i-1)*k*d+(i-1)*d];
                                   else %中间区域
                                        new_location{new_i,new_j}=[d*k*(new_j-2)+j*d,d*k*(new_j-1)+(j-1)*d,(new_i-2)*k*d+i*d,(new_i-1)*k*d+(i-1)*d];
                                   end
                            end     
                        end
                    end
                    
                end
            end
            new_sub_area_location{i,j}=new_location;
        end
    end
end