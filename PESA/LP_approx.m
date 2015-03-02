
%这个函数的功能是：
%1.先将 constraints，bi近似取整；
%2.使用近似算法计算。最后输出此种情况下最大的Utility。
function [Z_max,Xi_max] = LP_approx(constraints,bi,pi_charger_utility,epsilon)
%UNTITLED11 此处显示有关此函数的摘要
%   此处显示详细说明
   % epsilon_ap=0.9; %%为
    format long;
    n=size(constraints,2); %charger数量
    for i=1:size(constraints,1)
        constraints(i,:)=floor((constraints(i,:)/bi(i))*(n/epsilon))+1;  %%%%修改：忘记加1
    end
    bi=ones(size(bi,1),1)*(floor(n/epsilon)); %%修改，ones(sizes(bi,1)) checked 7.22
    m=size(bi,1);%也是约束条件的个数。
    %k=min(n,ceil(m*(1-epsilon_ap)/epsilon_ap));
    k=2;
    N=ones(1,n); % N=[1 2 3 4...n;]
    for i=1:n
        N(i)=i;
    end
    Z_max=0; %使用此方法输出的最大的值
    Xi_max=zeros(m,1);
    error=0;
    %%依次遍历S中元素为1到k时候的情况。
    for elem_num=1:k
        disp('S中元素的个数是：');
        disp(elem_num);
        S_set=nchoosek(N,elem_num); %得到S中元素为elem_num的所有的情况
        for index_Set=1:size(S_set,1) %遍历每一种情况。
            disp(index_Set);
            S=S_set(index_Set,:); %S中的元素,对应的X中的xi置1
            X=ones(n,1)*2; %初始值设为2，方便比较
            aij=constraints;
          %  Xi_max=zeros(m,1);
            cj=pi_charger_utility;
            bi_=bi;
            minCj=cj(S(1));
            %把S中元素，对应的X中的元素，置1
            for index_i=1:elem_num
                X(S(index_i))=1;
                minCj=min(minCj,cj(S(index_i)));
            end
            %下面寻找Ts中的元素，并将X中对应的元素置0
            Ts=setdiff(N,S);
            index_line=1;
            for t=1:size(Ts,2)
                if cj(Ts(index_line))<=minCj; %%%%这边还是出错了。
                    Ts(index_line)=[];
                else
                    X(Ts(index_line))=0; %让Ts对应的xi设为0
                    index_line=index_line+1;
                end
            end
            %判断bi(s)=bi-sun(aij)(j属于S)是否大于0，必须要所有的值均大于0才可以
             label=1;
            for index_m=1:m
                sum_bi=0;
                for index_s_=1:elem_num
                    sum_bi=sum_bi+aij(index_m,S(index_s_));
                end
                if sum_bi>bi_(index_m) %退出循环不进行计算
                    label=0;
                    break;
                end
            end
            if label %满足继续计算的条件，求解此时的LP(s)
                %求解x中xi不等于0,1的那些未知数的最优解

                ZS=0; %保存S中元素的cj和值。
                for index_S=1:elem_num   %%%%出错检查。注意S中保存的才是index
                    index=S(index_S);
                    bi_=bi_-aij(:,index);
                    aij(1,index)=-1;   %%%%-1是用例标识
                    ZS=ZS+cj(index);
                    cj(index)=-1;
                end
                for index_T=1:size(Ts,2)  %%出错检查。Ts和index.....终于调出这个bug了。。。。。因为上面已经删过几个了。
                    index_t=Ts(index_T);
                    aij(1,index_t)=-1;
                    cj(index_t)=-1;
                end
                %%%%下面将aij和cij中-1的消去。
               % [row,key]=find(aij==-1);
               aij_column=1;
               for time=1:size(aij,2)
                   if aij(1,aij_column)==-1
                       aij(:,aij_column)=[];
                   else
                       aij_column=aij_column+1;
                   end
               end
              cj_column=1;
              for time=1:size(cj,2)
                   if cj(cj_column)==-1
                       cj(cj_column)=[];
                   else
                       cj_column=cj_column+1;
                   end
              end
                %下面开始求解：
                Aeq=[];
                beq=[];
                lu=zeros(1,size(aij,2));
                ub=ones(1,size(aij,2));
                bbbbb=size(bi_,1);
                disp('xiangxixinxi:');
                disp(size(aij,1));
                disp(size(bi_,1));
                [x,z]=linprog(-cj,aij,bi_,Aeq,beq,lu,ub);  %%出错检查：这里用不到z，算法的计算公式是：
                
                if ~isempty(find(x>1))||~isempty(find(x<0))
                    error=error+1;
                    continue;
                   
                end
                ceshi_max=z;
                x=floor(x); %计算这里面的值
                Zx=0;
                for index_x=1:size(x,1)
                    Zx=Zx+cj(index_x)*x(index_x);
                end
                if Z_max<ZS+Zx                  
                    X_2=find(X==2);
                    for index_X2=1:size(X_2,1)
                        X(X_2(index_X2))=x(index_X2);
                    end
                    Xi_max=X;
                    Z_max=ZS+Zx;
                end
            end 
        end
    end
end

