function [uu, rr, time] = DRA_residual_matrix(TrainFea,TrainG,ValidFea,ValidG,type)
%type: only-right model with type=0, all-in model with type = 1.
lambda = 0.01;

tic;
if type==0
    LX = TrainFea';
    clear TrainFea
    N_Count = 1;
    for i = unique(ValidG)
        LY = ValidFea(ValidG==i,:)';
        m = size(LY,2);
        LY(:,1:m-1) = LY(:,1:m-1) - LY(:,m)*ones(1,m-1);
        
        LUC = LX(:,TrainG~=i);
        n2 = size(LUC,2);
        LUC(:,1:n2-1) = LUC(:,1:n2-1) - LUC(:,n2)*ones(1,n2-1);
        LSuC = [LUC(:,1:n2-1),-LY(:,1:m-1)];
        Lsuc = LY(:,m) - LUC(:,n2);
        clear LUC
        Lgama = (LSuC'*LSuC+lambda*eye(size(LSuC,2)))\(LSuC'*Lsuc);
        u(:,N_Count) = Lsuc-LSuC*Lgama;
        
        LXC = LX(:,TrainG==i);
        n1 = size(LXC,2);
        LXC(:,1:n1-1) = LXC(:,1:n1-1) - LXC(:,n1)*ones(1,n1-1);
        LSrC = [LXC(:,1:n1-1),-LY(:,1:m-1)];
        Lsrc = LY(:,m) - LXC(:,n1);
        clear LXC
        Lbeta = (LSrC'*LSrC+lambda*eye(size(LSrC,2)))\(LSrC'*Lsrc);
        r(:,N_Count) = Lsrc-LSrC*Lbeta;
        
        N_Count = N_Count + 1;
    end
    uu = u*u'; rr = r*r';
elseif type==1
    LX = TrainFea'; clear TrainFea
    count = 1;
    for i = unique(ValidG)
        LY = ValidFea(ValidG==i,:)';
        m = size(LY,2);
        LY(:,1:m-1) = LY(:,1:m-1) - LY(:,m)*ones(1,m-1);
        
        for j = unique(TrainG)
            LUC = LX(:,TrainG~=j);
            n2 = size(LUC,2);
            LUC(:,1:n2-1) = LUC(:,1:n2-1) - LUC(:,n2)*ones(1,n2-1);
            LSuC = [LUC(:,1:n2-1),-LY(:,1:m-1)];
            Lsuc = LY(:,m) - LUC(:,n2);
            clear LUC
            Lgama = (LSuC'*LSuC+lambda*eye(size(LSuC,2)))\(LSuC'*Lsuc);

            LXC = LX(:,TrainG==j);
            n1 = size(LXC,2);
            LXC(:,1:n1-1) = LXC(:,1:n1-1) - LXC(:,n1)*ones(1,n1-1);
            LSrC = [LXC(:,1:n1-1),-LY(:,1:m-1)];
            Lsrc = LY(:,m) - LXC(:,n1);
            clear LXC
            Lbeta = (LSrC'*LSrC+lambda*eye(size(LSrC,2)))\(LSrC'*Lsrc);
            
            if i==j
                A(:,count) = Lsuc-LSuC*Lgama; % residuals of interest
                B(:,count) = Lsrc-LSrC*Lbeta; % residuals of interest
                count = count + 1;
            else
                B(:,count) = Lsuc-LSuC*Lgama; 
                A(:,count) = Lsrc-LSrC*Lbeta;  
                count = count + 1;
            end
        end
        
    end
    uu=A*A'; rr=B*B'; 
else
    disp('Invalid Input')
end
time = toc;
end