function [prediction, time] = NFS(TrainSample,TestSample,TrainLable)
X = TrainSample'; Y = TestSample'; m=size(Y,2); lambda=0.01;
clear TrainSample TestSample
Class = unique(TrainLable);
tic;

%Unrelated and Related Metric
Y(:,1:m-1) = Y(:,1:m-1) - Y(:,m)*ones(1,m-1);
count = 1;
for c = Class
    %Related Metric
    XC = X(:,TrainLable==c);
    n1 = size(XC,2);
    XC(:,1:n1-1) = XC(:,1:n1-1) - XC(:,n1)*ones(1,n1-1);
    SrC = [XC(:,1:n1-1),-Y(:,1:m-1)];
    src = Y(:,m) - XC(:,n1);
    clear XC
    beta = (SrC'*SrC+lambda*eye(size(SrC,2)))\(SrC'*src);
    drc = norm(src-SrC*beta,2);
    
    %Unrelated Metric
    UC = X(:,TrainLable~=c);
    n2 = size(UC,2);
    UC(:,1:n2-1) = UC(:,1:n2-1) - UC(:,n2)*ones(1,n2-1);
    SuC = [UC(:,1:n2-1),-Y(:,1:m-1)];
    suc = Y(:,m) - UC(:,n2);
    clear UC
    gama = (SuC'*SuC+lambda*eye(size(SuC,2)))\(SuC'*suc);
     duc = norm(suc-SuC*gama,2);
    
    %Combined Distance Metric
    CD(count) = drc/duc;
    count = count + 1;
end
time = toc;
[~,prediction] = sort(CD);
prediction = Class(prediction(1));
end