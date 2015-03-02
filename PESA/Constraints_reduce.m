function [constraints_remained,bi_remained] = Constraints_reduce(constraints,bi)
   
                        format long;
                        %先去除掉trival项
                        bi_left=sum(constraints,2);
                        xi_num=size(constraints,2);
                        lu=zeros(1,xi_num);
                        ub=ones(1,xi_num);
                        No_trivial_lines=find((bi_left-bi)>0);
                        if isempty(No_trivial_lines)
                            constraints_remained=constraints(size(constraints,1),:);
                            bi_remained=bi(size(constraints,1),:);
                            return;   
                        end
                        constraints_remained=zeros(size(No_trivial_lines,1),xi_num);
                        bi_remained=zeros(size(No_trivial_lines,1),1);
                        for index=1:size(No_trivial_lines,1)
                            line=No_trivial_lines(index,1);
                            constraints_remained(index,:)=constraints(line,:);
                            bi_remained(index,:)=bi(line,:);
                        end
%                         %再依次消去其它的一些约束项。
%                         %方法是对每一行，使用其他行进行LP得到最优解，和右边进行比较，如果右边值大的话就删除。
%                         %这里最初有一个错误需要注意就是，matlab自带的linprog对目标项是求最小，所以需要先将目标项取反，然后对z再取反即可得到值。
                        total_line=size(constraints_remained,1);

                        total_del=0;
                      
                        for index=1:total_line-1 %%保证最后一个不削减，因为最后可能就只剩一行  
            
                            index_line=index-total_del;
                            A=constraints_remained;
                            b=bi_remained;
                            c=-A(index_line,:);   %%%%注意要取反
                            b_right=b(index_line);
                            A(index_line,:)=[];
                            b(index_line,:)=[];
                            Aeq=[];
                            beq=[];
                            [x,z]=linprog(c,A,b,Aeq,beq,lu,ub); 
%                             zi(index)=z;
                            if (-z)<=b_right %再取反一次。
                                constraints_remained(index_line,:)=[];
                                bi_remained(index_line,:)=[];
                                total_del=total_del+1;
                                disp(index);
                            end
                        end
  
end

