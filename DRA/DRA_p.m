function [prediction, time] = DRA_p(Drc, Duc, TrainLable, P)
uLabel = unique(TrainLable);
tic;
%----------Recognition Stage------------
count = 1;
for c = uLabel
    drc = norm(P'*Drc(:,count),2);
    duc = norm(P'*Duc(:,count),2);
    
    %Combined Distance
    CD(count) = drc/duc;
    
    count = count + 1;
end
[~,Index] = min(CD);
prediction = uLabel(Index);
time = toc;
end