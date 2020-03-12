function [P, sortVal, time] = DRA_Exp(uu, rr, type, k)
%type: 'rate' or 'num';
%k: = j eigenvectors with k contributed rate when type is 'rate', 0<k<=1;
%k: = k dominant eigenvectors when type is 'num', k is positive integer.

%----------Learning Stage--------------
tic;
uu=uu/max(norm(uu,'fro')); 
if norm(rr,'fro') ~= 0
    rr = rr/max(norm(rr,'fro'));
end
[Q1,D1] = eig(uu); 
[Q2,D2] = eig(rr); 
for i = 1:size(D1,1)
    D1(i,i) = exp(D1(i,i));
    D2(i,i) = exp(D2(i,i));
end
euu = Q1*D1*Q1';
err = Q2*D2*Q2';
[vector,value] = eig(euu,err);
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