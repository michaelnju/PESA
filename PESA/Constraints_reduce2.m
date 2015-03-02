function [constraints_remained,bi_remained, charger_points_remained] = Constraints_reduce2(constraints,bi,charger_points)
   
                          
                        format long;
                        %先去除掉trival项
                        bi_left=sum(constraints,2);
                        xi_num=size(constraints,2);
                        lu=zeros(1,xi_num);
                        ub=ones(1,xi_num);
                        
                        
                        No_trivial_lines=find((bi_left-bi)>0);
                        charger_points_new=charger_points;
                        charger_points_new(size(charger_points,1)+1,:)=[0 0];
                        constraints_remained=zeros(size(No_trivial_lines,1),xi_num);
                        charger_points_remained=zeros(size(No_trivial_lines,1),2);
                        bi_remained=zeros(size(No_trivial_lines,1),1);
                        for index=1:size(No_trivial_lines,1)
                            line=No_trivial_lines(index,1);
                            constraints_remained(index,:)=constraints(line,:);
                            bi_remained(index,:)=bi(line,:);
                            charger_points_remained(index,:)=charger_points_new(line,:);
                        end
                        %再依次消去其它的一些约束项。
                        %方法是对每一行，使用其他行进行LP得到最优解，和右边进行比较，如果右边值大的话就删除。
                        %这里最初有一个错误需要注意就是，matlab自带的linprog对目标项是求最小，所以需要先将目标项取反，然后对z再取反即可得到值。
                        repeate=0;
                        total_line=size(constraints_remained,1);
                        index_line=0;
                        zi=zeros(1,index_line);
                        for index=1:total_line-1 %%保证最后一个不削减，因为最后可能就只剩一行  
                            if ~repeate
                                index_line=index_line+1;
                            else
                                repeate=0;
                            end
                            A=constraints_remained;
                            b=bi_remained;
                            c=-A(index_line,:);   %%%%注意要取反
                            b_right=b(index_line);
                            A(index_line,:)=[];
                            b(index_line,:)=[];
                            Aeq=[];
                            beq=[];
                            [x,z]=linprog(c,A,b,Aeq,beq,lu,ub); 
                            zi(index)=z;
                            if (-z)<=b_right %再取反一次。
                                constraints_remained(index_line,:)=[];
                                bi_remained(index_line,:)=[];
                                charger_points_remained(index_line,:)=[];
                                repeate=1;
                                disp(index);
                            end
                        end
%    end
end

