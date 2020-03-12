function [proj] = Our_PCA(fea,type,param)
[V,~,~,~,explained] = pca(fea);
if strcmp(type,'energy')
    Accumulate_energy = 0;
    All_energy = sum(explained);
    for dim = 1:length(explained)
        Accumulate_energy = Accumulate_energy + explained(dim);
        if (Accumulate_energy/All_energy) >= param
            break
        end
    end
    proj = V(:,1:dim);
elseif strcmp(type,'dim')
    proj = V(:,1:param);
else
    error('Unknown type of PCA !!! Must be {energy} or {dim} !!!')
end