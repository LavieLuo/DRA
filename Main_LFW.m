%% --------------------------------------------------- Illusration ------------------------
% E1DRA and R1DRA: Partial-Error models with different regularizations
% E2DRA and R2DRA: Total-Error models with different regularizations
addpath('DRA')

%--------------------------------------- Gray Scale 10x10 -------------------------
load database\LFW_10x10.mat
fea = double(fea);
for i=1:size(fea,1)
    fea(i,:) = fea(i,:)/norm(fea(i,:));
end

t1 = clock;
num_train = 3; num_test = 3; num_valid = 3; Exp_times = 30; k = 62;
for j=1:Exp_times
    disp(['LFW Database: Setting',num2str(1),' -- Experiments ',num2str(j),' Start!']); t2 = clock;
    [TestFea,TestG,TrainFea,TrainG,ValidFea,ValidG] = RandpickTVT(fea,gnd,num_train,num_valid,num_test,j);
    %-----Learning----
    [uu1, rr1, RMT1] = DRA_residual_matrix(TrainFea,TrainG,ValidFea,ValidG,0); 
    [uu2, rr2, RMT2] = DRA_residual_matrix(TrainFea,TrainG,ValidFea,ValidG,1); 
    
    [P1, ~, E1DRA_T1] = DRA_Exp(uu1, rr1, 'num', k);
    [P2, ~, R1DRA_T2] = DRA_Reg(uu1, rr1, 'num', k, 1e-3);
    [P3, ~, E2DRA_T3] = DRA_Exp(uu2, rr2, 'num', k); 
    [P4, ~, R2DRA_T4] = DRA_Reg(uu2, rr2, 'num', k, 1e-3);
    
    %--------Testing-------------------------------------------------------
    i = 1; N_low = 0;
    for label=unique(TestG)
        %[i,j]
        N_up = N_low + sum(TestG==label);
        
        [Drc, Duc, DRAtime_d(i)] = DRA_d(TrainFea,TestFea(N_low+1:N_up,:),TrainG);
        
        [NFSprediction(i), NFStime(i)] = NFS(TrainFea,TestFea(N_low+1:N_up,:),TrainG);
        [E1DRAprediction(i), E1DRAtime_p(i)] = DRA_p(Drc,Duc,TrainG,P1);
        [R1DRAprediction(i), R1DRAtime_p(i)] = DRA_p(Drc,Duc,TrainG,P2);
        [E2DRAprediction(i), E2DRAtime_p(i)] = DRA_p(Drc,Duc,TrainG,P3);
        [R2DRAprediction(i), R2DRAtime_p(i)] = DRA_p(Drc,Duc,TrainG,P4);
        
        i=i+1; N_low = N_low + sum(TestG==label);
    end
    TestLable = unique(TestG);
    
    [NFSAccuracy(j)] = Judge(NFSprediction, TestLable); NFST(j)=mean(NFStime);    
    [E1DRAAccuracy(j)] = Judge(E1DRAprediction, TestLable); E1DRAT(j)=mean(DRAtime_d)+mean(E1DRAtime_p); L1T(j) = E1DRA_T1+RMT1;
    [R1DRAAccuracy(j)] = Judge(R1DRAprediction, TestLable); R1DRAT(j)=mean(DRAtime_d)+mean(R1DRAtime_p); L2T(j) = R1DRA_T2+RMT1;
    [E2DRAAccuracy(j)] = Judge(E2DRAprediction, TestLable); E2DRAT(j)=mean(DRAtime_d)+mean(E2DRAtime_p); L3T(j) = E2DRA_T3+RMT2;
    [R2DRAAccuracy(j)] = Judge(R2DRAprediction, TestLable); R2DRAT(j)=mean(DRAtime_d)+mean(R2DRAtime_p); L4T(j) = R2DRA_T4+RMT2;

    mins = idivide(etime(clock,t1),int32(60));
    disp(['LFW Experiments ',num2str(j),' Finished!']);
    disp(['[Current iteration time: ',num2str(etime(clock,t2)),'secs] [Total time: ',num2str(idivide(mins,int32(60))),'h ',num2str(mod(mins,60)),'m ',num2str(mod(etime(clock,t1),60)),'s]']);
    disp('=======================================================================');
end
NFSACC = mean(NFSAccuracy);      NFSStd = std(NFSAccuracy,1);
E1DRAACC = mean(E1DRAAccuracy);    E1DRAStd = std(E1DRAAccuracy,1);
R1DRAACC = mean(R1DRAAccuracy);    R1DRAStd = std(R1DRAAccuracy,1);
E2DRAACC = mean(E2DRAAccuracy);    E2DRAStd = std(E2DRAAccuracy,1);
R2DRAACC = mean(R2DRAAccuracy);    R2DRAStd = std(R2DRAAccuracy,1);
LFWResult(:,1:3)=[
    NFSACC,mean(NFST),NFSStd;
    E1DRAACC,mean(E1DRAT)+mean(L1T),E1DRAStd;
    R1DRAACC,mean(R1DRAT)+mean(L2T),R1DRAStd;
    E2DRAACC,mean(E2DRAT)+mean(L3T),E2DRAStd;
    R2DRAACC,mean(R2DRAT)+mean(L4T),R2DRAStd;
    ];

%--------------------------------------- Gray Scale 15x10 -------------------------
load database\LFW_15x10.mat
fea = double(fea);
for i=1:size(fea,1)
    fea(i,:) = fea(i,:)/norm(fea(i,:));
end

t1 = clock;
num_train = 3; num_test = 3; num_valid = 3; Exp_times = 30; k = 62;
for j=1:Exp_times
    disp(['LFW Database: Setting',num2str(1),' -- Experiments ',num2str(j),' Start!']); t2 = clock;
    [TestFea,TestG,TrainFea,TrainG,ValidFea,ValidG] = RandpickTVT(fea,gnd,num_train,num_valid,num_test,j);
    %-----Learning----
    [uu1, rr1, RMT1] = DRA_residual_matrix(TrainFea,TrainG,ValidFea,ValidG,0); 
    [uu2, rr2, RMT2] = DRA_residual_matrix(TrainFea,TrainG,ValidFea,ValidG,1); 
    
    [P1, ~, E1DRA_T1] = DRA_Exp(uu1, rr1, 'num', k);
    [P2, ~, R1DRA_T2] = DRA_Reg(uu1, rr1, 'num', k, 1e-3);
    [P3, ~, E2DRA_T3] = DRA_Exp(uu2, rr2, 'num', k); 
    [P4, ~, R2DRA_T4] = DRA_Reg(uu2, rr2, 'num', k, 1e-3);
    
    %--------Testing-------------------------------------------------------
    i = 1; N_low = 0;
    for label=unique(TestG)
        %[i,j]
        N_up = N_low + sum(TestG==label);
        
        [Drc, Duc, DRAtime_d(i)] = DRA_d(TrainFea,TestFea(N_low+1:N_up,:),TrainG);
        
        [NFSprediction(i), NFStime(i)] = NFS(TrainFea,TestFea(N_low+1:N_up,:),TrainG);
        [E1DRAprediction(i), E1DRAtime_p(i)] = DRA_p(Drc,Duc,TrainG,P1);
        [R1DRAprediction(i), R1DRAtime_p(i)] = DRA_p(Drc,Duc,TrainG,P2);
        [E2DRAprediction(i), E2DRAtime_p(i)] = DRA_p(Drc,Duc,TrainG,P3);
        [R2DRAprediction(i), R2DRAtime_p(i)] = DRA_p(Drc,Duc,TrainG,P4);
        
        i=i+1; N_low = N_low + sum(TestG==label);
    end
    TestLable = unique(TestG);
    
    [NFSAccuracy(j)] = Judge(NFSprediction, TestLable); NFST(j)=mean(NFStime);    
    [E1DRAAccuracy(j)] = Judge(E1DRAprediction, TestLable); E1DRAT(j)=mean(DRAtime_d)+mean(E1DRAtime_p); L1T(j) = E1DRA_T1+RMT1;
    [R1DRAAccuracy(j)] = Judge(R1DRAprediction, TestLable); R1DRAT(j)=mean(DRAtime_d)+mean(R1DRAtime_p); L2T(j) = R1DRA_T2+RMT1;
    [E2DRAAccuracy(j)] = Judge(E2DRAprediction, TestLable); E2DRAT(j)=mean(DRAtime_d)+mean(E2DRAtime_p); L3T(j) = E2DRA_T3+RMT2;
    [R2DRAAccuracy(j)] = Judge(R2DRAprediction, TestLable); R2DRAT(j)=mean(DRAtime_d)+mean(R2DRAtime_p); L4T(j) = R2DRA_T4+RMT2;

    mins = idivide(etime(clock,t1),int32(60));
    disp(['LFW Experiments ',num2str(j),' Finished!']);
    disp(['[Current iteration time: ',num2str(etime(clock,t2)),'secs] [Total time: ',num2str(idivide(mins,int32(60))),'h ',num2str(mod(mins,60)),'m ',num2str(mod(etime(clock,t1),60)),'s]']);
    disp('=======================================================================');
end
NFSACC = mean(NFSAccuracy);      NFSStd = std(NFSAccuracy,1);
E1DRAACC = mean(E1DRAAccuracy);    E1DRAStd = std(E1DRAAccuracy,1);
R1DRAACC = mean(R1DRAAccuracy);    R1DRAStd = std(R1DRAAccuracy,1);
E2DRAACC = mean(E2DRAAccuracy);    E2DRAStd = std(E2DRAAccuracy,1);
R2DRAACC = mean(R2DRAAccuracy);    R2DRAStd = std(R2DRAAccuracy,1);
LFWResult(:,4:6)=[
    NFSACC,mean(NFST),NFSStd;
    E1DRAACC,mean(E1DRAT)+mean(L1T),E1DRAStd;
    R1DRAACC,mean(R1DRAT)+mean(L2T),R1DRAStd;
    E2DRAACC,mean(E2DRAT)+mean(L3T),E2DRAStd;
    R2DRAACC,mean(R2DRAT)+mean(L4T),R2DRAStd;
    ];

%--------------------------------------- Gray Scale 15x10 -------------------------
load database\LFW_30x15.mat
fea = double(fea);
for i=1:size(fea,1)
    fea(i,:) = fea(i,:)/norm(fea(i,:));
end

t1 = clock;
num_train = 3; num_test = 3; num_valid = 3; Exp_times = 30; k = 62;
for j=1:Exp_times
    disp(['LFW Database: Setting',num2str(1),' -- Experiments ',num2str(j),' Start!']); t2 = clock;
    [TestFea,TestG,TrainFea,TrainG,ValidFea,ValidG] = RandpickTVT(fea,gnd,num_train,num_valid,num_test,j);
    %-----Learning----
    [uu1, rr1, RMT1] = DRA_residual_matrix(TrainFea,TrainG,ValidFea,ValidG,0); 
    [uu2, rr2, RMT2] = DRA_residual_matrix(TrainFea,TrainG,ValidFea,ValidG,1); 
    
    [P1, ~, E1DRA_T1] = DRA_Exp(uu1, rr1, 'num', k);
    [P2, ~, R1DRA_T2] = DRA_Reg(uu1, rr1, 'num', k, 1e-3);
    [P3, ~, E2DRA_T3] = DRA_Exp(uu2, rr2, 'num', k); 
    [P4, ~, R2DRA_T4] = DRA_Reg(uu2, rr2, 'num', k, 1e-3);
    
    %--------Testing-------------------------------------------------------
    i = 1; N_low = 0;
    for label=unique(TestG)
        %[i,j]
        N_up = N_low + sum(TestG==label);
        
        [Drc, Duc, DRAtime_d(i)] = DRA_d(TrainFea,TestFea(N_low+1:N_up,:),TrainG);
        
        [NFSprediction(i), NFStime(i)] = NFS(TrainFea,TestFea(N_low+1:N_up,:),TrainG);
        [E1DRAprediction(i), E1DRAtime_p(i)] = DRA_p(Drc,Duc,TrainG,P1);
        [R1DRAprediction(i), R1DRAtime_p(i)] = DRA_p(Drc,Duc,TrainG,P2);
        [E2DRAprediction(i), E2DRAtime_p(i)] = DRA_p(Drc,Duc,TrainG,P3);
        [R2DRAprediction(i), R2DRAtime_p(i)] = DRA_p(Drc,Duc,TrainG,P4);
        
        i=i+1; N_low = N_low + sum(TestG==label);
    end
    TestLable = unique(TestG);
    
    [NFSAccuracy(j)] = Judge(NFSprediction, TestLable); NFST(j)=mean(NFStime);    
    [E1DRAAccuracy(j)] = Judge(E1DRAprediction, TestLable); E1DRAT(j)=mean(DRAtime_d)+mean(E1DRAtime_p); L1T(j) = E1DRA_T1+RMT1;
    [R1DRAAccuracy(j)] = Judge(R1DRAprediction, TestLable); R1DRAT(j)=mean(DRAtime_d)+mean(R1DRAtime_p); L2T(j) = R1DRA_T2+RMT1;
    [E2DRAAccuracy(j)] = Judge(E2DRAprediction, TestLable); E2DRAT(j)=mean(DRAtime_d)+mean(E2DRAtime_p); L3T(j) = E2DRA_T3+RMT2;
    [R2DRAAccuracy(j)] = Judge(R2DRAprediction, TestLable); R2DRAT(j)=mean(DRAtime_d)+mean(R2DRAtime_p); L4T(j) = R2DRA_T4+RMT2;

    mins = idivide(etime(clock,t1),int32(60));
    disp(['LFW Experiments ',num2str(j),' Finished!']);
    disp(['[Current iteration time: ',num2str(etime(clock,t2)),'secs] [Total time: ',num2str(idivide(mins,int32(60))),'h ',num2str(mod(mins,60)),'m ',num2str(mod(etime(clock,t1),60)),'s]']);
    disp('=======================================================================');
end
NFSACC = mean(NFSAccuracy);      NFSStd = std(NFSAccuracy,1);
E1DRAACC = mean(E1DRAAccuracy);    E1DRAStd = std(E1DRAAccuracy,1);
R1DRAACC = mean(R1DRAAccuracy);    R1DRAStd = std(R1DRAAccuracy,1);
E2DRAACC = mean(E2DRAAccuracy);    E2DRAStd = std(E2DRAAccuracy,1);
R2DRAACC = mean(R2DRAAccuracy);    R2DRAStd = std(R2DRAAccuracy,1);
LFWResult(:,7:9)=[
    NFSACC,mean(NFST),NFSStd;
    E1DRAACC,mean(E1DRAT)+mean(L1T),E1DRAStd;
    R1DRAACC,mean(R1DRAT)+mean(L2T),R1DRAStd;
    E2DRAACC,mean(E2DRAT)+mean(L3T),E2DRAStd;
    R2DRAACC,mean(R2DRAT)+mean(L4T),R2DRAStd;
    ];

%--------------------------------------- Deep Feature 2048d -------------------------
load dataBase\LFW_VggFace2_Resnet50_2048.mat
fea = double(fea);

t1 = clock;
num_train = 3; num_test = 3; num_valid = 3; Exp_times = 30; k = 62;
for j=1:Exp_times
    disp(['LFW Database: Setting',num2str(1),' -- Experiments ',num2str(j),' Start!']); t2 = clock;
    [TestFea,TestG,TrainFea,TrainG,ValidFea,ValidG] = RandpickTVT(fea,gnd,num_train,num_valid,num_test,j);
    %-----Learning----
    [uu1, rr1, RMT1] = DRA_residual_matrix(TrainFea,TrainG,ValidFea,ValidG,0); 
    [uu2, rr2, RMT2] = DRA_residual_matrix(TrainFea,TrainG,ValidFea,ValidG,1); 
    
    [P1, ~, E1DRA_T1] = DRA_Exp(uu1, rr1, 'num', k);
    [P2, ~, R1DRA_T2] = DRA_Reg(uu1, rr1, 'num', k, 1e-3);
    [P3, ~, E2DRA_T3] = DRA_Exp(uu2, rr2, 'num', k); 
    [P4, ~, R2DRA_T4] = DRA_Reg(uu2, rr2, 'num', k, 1e1);
   
    %--------Testing-------------------------------------------------------
    i = 1; N_low = 0;
    for label=unique(TestG)
        N_up = N_low + sum(TestG==label);
        
        [Drc, Duc, DRAtime_d(i)] = DRA_d(TrainFea,TestFea(N_low+1:N_up,:),TrainG);
       
        [NFSprediction(i), NFStime(i)] = NFS(TrainFea,TestFea(N_low+1:N_up,:),TrainG);
        [E1DRAprediction(i), E1DRAtime_p(i)] = DRA_p(Drc,Duc,TrainG,P1);
        [R1DRAprediction(i), R1DRAtime_p(i)] = DRA_p(Drc,Duc,TrainG,P2);
        [E2DRAprediction(i), E2DRAtime_p(i)] = DRA_p(Drc,Duc,TrainG,P3);
        [R2DRAprediction(i), R2DRAtime_p(i)] = DRA_p(Drc,Duc,TrainG,P4);
        
        i=i+1; N_low = N_low + sum(TestG==label);
    end
    TestLable = unique(TestG);
    
    [NFSAccuracy(j)] = Judge(NFSprediction, TestLable); NFST(j)=mean(NFStime);    
    [E1DRAAccuracy(j)] = Judge(E1DRAprediction, TestLable); E1DRAT(j)=mean(DRAtime_d)+mean(E1DRAtime_p); L1T(j) = E1DRA_T1+RMT1;
    [R1DRAAccuracy(j)] = Judge(R1DRAprediction, TestLable); R1DRAT(j)=mean(DRAtime_d)+mean(R1DRAtime_p); L2T(j) = R1DRA_T2+RMT1;
    [E2DRAAccuracy(j)] = Judge(E2DRAprediction, TestLable); E2DRAT(j)=mean(DRAtime_d)+mean(E2DRAtime_p); L3T(j) = E2DRA_T3+RMT2;
    [R2DRAAccuracy(j)] = Judge(R2DRAprediction, TestLable); R2DRAT(j)=mean(DRAtime_d)+mean(R2DRAtime_p); L4T(j) = R2DRA_T4+RMT2;

    mins = idivide(etime(clock,t1),int32(60));
    disp(['LFW Experiments ',num2str(j),' Finished!']);
    disp(['[Current iteration time: ',num2str(etime(clock,t2)),'secs] [Total time: ',num2str(idivide(mins,int32(60))),'h ',num2str(mod(mins,60)),'m ',num2str(mod(etime(clock,t1),60)),'s]']);
    disp('=======================================================================');
end
NFSACC = mean(NFSAccuracy);      NFSStd = std(NFSAccuracy,1);
E1DRAACC = mean(E1DRAAccuracy);    E1DRAStd = std(E1DRAAccuracy,1);
R1DRAACC = mean(R1DRAAccuracy);    R1DRAStd = std(R1DRAAccuracy,1);
E2DRAACC = mean(E2DRAAccuracy);    E2DRAStd = std(E2DRAAccuracy,1);
R2DRAACC = mean(R2DRAAccuracy);    R2DRAStd = std(R2DRAAccuracy,1);
LFWResult(:,10:12)=[
    NFSACC,mean(NFST),NFSStd;
    E1DRAACC,mean(E1DRAT)+mean(L1T),E1DRAStd;
    R1DRAACC,mean(R1DRAT)+mean(L2T),R1DRAStd;
    E2DRAACC,mean(E2DRAT)+mean(L3T),E2DRAStd;
    R2DRAACC,mean(R2DRAT)+mean(L4T),R2DRAStd;
    ];