function nHVE = getHVE(nR)

% HVE (heterogenous variance explained)
bAgonist     = nR>0; %positive correlations
bAntagonist  = nR<0; %negative correlations
bData = nR==0;

nHVE_pos     = nR;
nHVE_pos     = (1-nHVE_pos.^2);
nHVE_pos(bAntagonist) = 0; %values to be substituted by nHVE_neg

nHVE_neg     = nR;
nHVE_neg     = (1+nHVE_neg.^2);
nHVE_neg(bAgonist) = 0; %values to be substituted by nHVE_pos

nHVE    = nHVE_pos + nHVE_neg;
nHVE(bData) = 1;
