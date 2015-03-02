%author： 2014-07-06
%This function is used to give the Global Solution Construction with the
%dynamic programming
%The input is the matrix :utility =[u11,u12,u1n;,...; um1,um2,..,umn] and
%Xi_cell为{m,n}的元胞数组。 其中m是区域个数的总和，n是charger的总和。
%output：
%Max_u:最大的utility
%Xu: 多行2列的数组。其中第一列是每个区域对应的标号，第二列是此区域分配的charger的个数。

function[Max_u,Xu]=DA_GSC(utility)
    grid_num=size(utility,1); %the sum of the sub-areas
    charger_num=size(utility,2); %the  sum of the chargers
    U=utility(1,:);% at the beginning, the U(i)=utility[1][i]
    Xi=cell(charger_num,1);
    %下面的一个循环来初始化Xi；
    for index_x=1:charger_num
        Xi{index_x}=[1 index_x];
    end
    %Xu=Xi;
    %following is used to update the U(i) 
    for i=2:grid_num
        U_update=U;
        Xi_update=Xi;
        for j=1:charger_num
            %get the maximum of {U(j),U(1)+utility(i,j-1),.,.,utility(i,j)} 
            if(utility(i,j)>U_update(j))
                U_update(j)=utility(i,j);
                Xi_update{j}=[i j];
            end
            for k=1:j-1 
                if((U(k)+utility(i,j-k))>U_update(j))
                    U_update(j)=U(k)+utility(i,j-k);
                    matrix_k=Xi{k};
                    matrix_k(size(matrix_k,1)+1,:)=[i j-k]; 
                    Xi_update{j}=matrix_k;               
                end
            end
        end
        U=U_update;
        Xi=Xi_update;
    end
    Max_u=U(charger_num);
    Xu=Xi{charger_num};
end