function [Drc, Duc, time] = DRA_d(TrainSample,TestSample,TrainLable)
X = TrainSample'; Y = TestSample'; lambda=0.01; m=size(Y,2);
clear TrainSample TestSample
tic;
%----------Recognition Stage------------
%Unrelated and Related Metric
Y(:,1:m-1) = Y(:,1:m-1) - Y(:,m)*ones(1,m-1);
count = 1;
for c = unique(TrainLable)
    %Related Metric
    XC = X(:,TrainLable==c);
    n1 = size(XC,2);
    XC(:,1:n1-1) = XC(:,1:n1-1) - XC(:,n1)*ones(1,n1-1);
    SrC = [XC(:,1:n1-1),-Y(:,1:m-1)];
    src = Y(:,m) - XC(:,n1);
    clear XC
%     if size(SrC,2) <= size(SrC,1)
%         beta = (SrC'*SrC+lambda*eye(size(SrC,2)))\(SrC'*src);
%     else
%         [Q,R] = qr(SrC',0);
%         beta = Q*(R'\src);
%     end
    beta = (SrC'*SrC+lambda*eye(size(SrC,2)))\(SrC'*src);
    Drc(:,count) = src-SrC*beta;
    
    %Unrelated Metric
    UC = X(:,TrainLable~=c);
    n2 = size(UC,2);
    UC(:,1:n2-1) = UC(:,1:n2-1) - UC(:,n2)*ones(1,n2-1);
    SuC = [UC(:,1:n2-1),-Y(:,1:m-1)];
    suc = Y(:,m) - UC(:,n2);
    clear UC
%     if size(SuC,2) <= size(SuC,1)
%         gama = (SuC'*SuC+lambda*eye(size(SuC,2)))\(SuC'*suc);
%     else
%         [Q,R] = qr(SuC',0);
%         gama = Q*(R'\suc);
%     end
    gama = (SuC'*SuC+lambda*eye(size(SuC,2)))\(SuC'*suc);
    Duc(:,count) = suc-SuC*gama;
    count = count + 1;
end
time = toc;
end