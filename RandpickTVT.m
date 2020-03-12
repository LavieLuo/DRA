function [TestFea,TestG,TrainFea,TrainG,ValidFea,ValidG]=RandpickTVT(fea,gnd,num_train,num_valid,num_test,j,percent)
%percent: percent class are included in validation set. Default 100%.

if nargin < 7
    flag = 0;
elseif nargin == 7
    flag = 1;
end

%n=sum(gnd==1);
k=length(unique(gnd));
count = 0;
i = 1; p = 1; q = 1;
L = num_train; V = num_valid; N = num_test;
if flag == 0
    while i<=k
        numi=sum(gnd==i);
        rand('state',j);
        r=randperm(numi);
        TrainG((i-1)*L+1:i*L)=i;
        TrainFea((i-1)*L+1:i*L,:)=fea(count*ones(1,L)+r(1:L),:);
        if numi>=N+L
            TestFea((p-1)*N+1:p*N,:)=fea(count*ones(1,N)+r(L+1:N+L),:);
            TestG((p-1)*N+1:p*N)=i;
            p = p + 1;
            if numi>=N+L+V
                ValidFea((q-1)*V+1:q*V,:)=fea(count*ones(1,V)+r(N+L+1:N+L+V),:);
                ValidG((q-1)*V+1:q*V)=i;
                q = q + 1;
            end
        end
        count=count+numi;
        i=i+1;
    end
elseif flag == 1
    while i<=k
        numi=sum(gnd==i);
        rand('state',j);
        r=randperm(numi);
        TrainG((i-1)*L+1:i*L)=i;
        TrainFea((i-1)*L+1:i*L,:)=fea(count*ones(1,L)+r(1:L),:);
        if numi>=N+L
            TestFea((p-1)*N+1:p*N,:)=fea(count*ones(1,N)+r(L+1:N+L),:);
            TestG((p-1)*N+1:p*N)=i;
            p = p + 1;
            if numi>=N+L+V
                ValidFea((q-1)*V+1:q*V,:)=fea(count*ones(1,V)+r(N+L+1:N+L+V),:);
                ValidG((q-1)*V+1:q*V)=i;
                q = q + 1;
            end
        end
        count=count+numi;
        i=i+1;
    end
    
    unValid = unique(ValidG);
    Val_class = round(percent*k);
    r = randperm(k);
    for i = 1:(k-Val_class)
        ValidFea(ValidG==unValid(r(i)),:) = [];
        ValidG(ValidG==unValid(r(i))) = [];
    end   
end
end