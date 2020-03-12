function [P, sortVal, time] = DRA_Reg(uu, rr, type, k, lambda1)
%type: 'rate' or 'num';
%k: = j eigenvectors with k contributed rate when type is 'rate', 0<k<=1;
%k: = k dominant eigenvectors when type is 'num', k is positive integer.

%----------Learning Stage--------------
tic;

[vector,value] = eig(uu,rr+lambda1*eye(size(rr,1)));
value = abs(value);
SumValue = sum(diag(value));
[sortVal,I] = sort(diag(value),'descend');
if strcmp(type,'rate')
    LValue = 0; j = 1;
    while LValue <= SumValue*k
        LValue = LValue + sortVal(j);
        j=j+1;
    end
    P = vector(:,I(1:j-1));
elseif strcmp(type,'num')
    P = vector(:,I(1:k));
else
    disp('Invalid Input: Type')
end
time = toc;
end