
% values from papers

nRefExt = [...
    80.1... % Narici 1988 
];

nRefModelExt = [146, 100, 110, 146, 126]; %Buchanan 1995

nRefFlex = [
    70.5... % Narici 1988
];

nRefModelFlex = [...
    89, 41, 40, 87, 64,... %Buchanan 1995;
    ];

nRefAll = [...
  35.32,... %  Brand 1981
  35.32,... %ARKIN 1941
  37,... % Weijs 1985
  38.259,... % Haxton 1944
];


metaMuscle = load_csv(...
    'sPath',cd,...
    'sFile','metaMuscle.csv',...
    'bVerbose', false);

nFmax = metaMuscle.nFmax.*metaMuscle.nBeta;

nSpecificTension = nFmax./metaMuscle.nPCSA;

ix = ~isnan(nSpecificTension);

mean(nSpecificTension(ix))





nPublishedRef = [nRefAll, nRefFlex, nRefExt];

nModelRef = [nRefModelFlex, nRefModelExt];

nModel = nSpecificTension(ix);

% figure
% qqplot(nPublishedRef)
% 
% figure
% qqplot(nModelRef)
% 
% figure
% qqplot(nModel)

nGroup = {};
nGroup(1:numel(nPublishedRef)) = {'experimental'};
nGroup(numel(nGroup)+1:numel(nGroup)+numel(nModelRef)) = {'Other Models'};
nGroup(numel(nGroup)+1:numel(nGroup)+numel(nModel)) = {'Our Model'};

vartestn([nPublishedRef, nModelRef, nModel']', nGroup,'TestType', 'BrownForsythe')

[p,t,stats] = anova1([nPublishedRef, nModelRef, nModel']',nGroup);

[c,m,h,nms] = multcompare(stats,'CType', 'tukey-kramer');


% % wrist flexors
% % Muscle to receive maximum activation
sMuscleFlex     = {'FCR', 'FCU', 'PL',...
    'FDS5', 'FDS4', 'FDS3', 'FDS2',...
    'FDP5', 'FDP4', 'FDP3', 'FDP2'};
for iMuscle = 1:numel(sMuscleFlex)
    idMuscleListFlex(iMuscle) = find(strcmp(sMuscleFlex{iMuscle}, metaMuscle.sMuscle));
end


sMuscleExt  = {'ECR_LO', 'ECR_BR', 'ECU',...
    'EDM', 'ED5', 'ED4', 'ED3', 'ED2', 'EIND'};

for iMuscle = 1:numel(sMuscleExt)
    idMuscleListExt(iMuscle) = find(strcmp(sMuscleExt{iMuscle}, metaMuscle.sMuscle));
end


hFig = figure;
hold on
% notBoxPlot([nRefExt, nRefFlex,nRefAll], 1*ones(numel([nRefExt, nRefFlex,nRefAll]),1)); % published
% notBoxPlot(nSpecificTension(ix), 2*ones(numel([nSpecificTension(ix)]),1)) % simulated

boxplot([nRefExt, nRefFlex,nRefAll, nRefModelFlex, nRefModelExt, nSpecificTension(ix)'], ...
    [1*ones(numel([nRefExt, nRefFlex, nRefAll]),1);2*ones(numel([nRefModelExt, nRefModelFlex]),1); 3*ones(numel([nSpecificTension(ix)]),1)],...
    'outliersize', 0.00001);

scatter(1*ones(numel([nRefExt, nRefFlex,nRefAll]),1),...
    [nRefExt, nRefFlex,nRefAll],...
    30,...
    [0 0 0],...
    'jitter', 'on',...
    'jitterAmount', 0.1)


scatter(2*ones(numel([nRefModelExt, nRefModelFlex]),1),...
    [nRefModelExt, nRefModelFlex],...
    30,...
    [0 0 0],...
    'jitter', 'on',...
    'jitterAmount', 0.1)

scatter(3*ones(numel([nSpecificTension(ix)]),1),...
    nSpecificTension(ix),...
    30,...
    [0 0 0],...
    'jitter', 'on',...
    'jitterAmount', 0.1)

% figure
% hold on
% plot(ones(numel(nRefExt),1), nRefExt, 'ok')
% plot(ones(numel(nRefFlex),1), nRefFlex, 'ok')
% plot(ones(numel(nRefAll),1), nRefAll, 'ok')
% 
% plot(2*ones(numel(nSpecificTension(ix)),1), nSpecificTension(ix), 'ko')
% 
% hold off
% 
% 
% xlim([0 3])
ylim([0 160])
hAxe = gca;

hAxe.XTick = [1 2 3];
hAxe.XTickLabel = {'experimental', 'Other Models','Our Model'};

ylabel('Specific Tension (N/cm^2)')


printpdf(gcf,'Specific_Tension_Simulated_vs_Published.pdf')
