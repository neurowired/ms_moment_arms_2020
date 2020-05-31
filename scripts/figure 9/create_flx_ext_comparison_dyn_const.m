function create_flx_ext_comparison_dyn_const

% add path to haptix moment arm function
% addpath([getenv('NE_REPOSITORIES'), 'haptix', filesep, 'mbm', ...
%     filesep, 'mbm_functions', filesep, 'mbm_rtcore']);
addpath('Moment_Arms');
disp('Added Moment Arm functions that were copied to this folder')
disp('Not the ones being used in Haptix')

%% wrist at 0 pro/sup
% get joint angles to run into moment arm function
nJointPos       = zeros(23,42);
nJointPos(4,:)  = 90;
nJointPos(5,:)  = 0;

% Apply this below to place hand in neutral position
% nJointPos([5,7:23],:) = [0.87, 0.36, 0.59, 0.80, -0.61, -0.28,...
%     0.64, 0.49, 0.38, 0.61, 0.93, 0.52, 0.68, 0.92, 0.43, 0.87, 0.53,...
%     0.36]'*180/pi.*ones(18,42);

% wrist flex/ext  range goes from -1.22 to 1.22 rads or -69 deg to 69 deg
nWristFlex      = linspace(-69,69, 42);
nJointPos(7,:)  = nWristFlex;


% %% wrist sup
% nJointPos2 = nJointPos1;
% nJointPos2(5,:)  = -30;
% 
% %% wrist pro
% nJointPos3 = nJointPos1;
% nJointPos3(5,:)  = 30;
% 
% nJointPos = [nJointPos1, nJointPos2, nJointPos3];
% change joint position to rads
nJointPos = nJointPos*pi/180;

nConMomentArms = load('constant_moment_arms.mat');

% for each joint position
for iC = 1:numel(nJointPos(1,:))
    nMA(:,:,iC) = momarmfunc_c(single(nJointPos(:,iC)));
    nMA_con(:,:,iC) = nConMomentArms.nMA;
end

numSample = numel(nJointPos(1,:));

%% Make Moment Arm Figure Wrist Flex Ext
% wrist flex/ext dof
idDOF_MJC = 7;
% muscle that wrist ext dof
idExt   = 27;
% muscle that wrist flex dof
idFlex  = 30;
% get wrist flexion moment arm
nMAFlex = reshape(nMA(idFlex, idDOF_MJC, :),1,numSample);
% get wrist extension moment arm
nMAExt = reshape(nMA(idExt, idDOF_MJC, :),1,numSample);
% get wrist flexion moment arm
nMAconFlex = reshape(nMA_con(idFlex, idDOF_MJC, :),1,numSample);
% get wrist extension moment arm
nMAconExt = reshape(nMA_con(idExt, idDOF_MJC, :),1,numSample);
% muscle that wrist ext dof
idExt   = 45;
% muscle that wrist flex dof
idFlex  = 40;
% get wrist flexion moment arm
nMAFingFlex = reshape(nMA(idFlex, idDOF_MJC, :),1,numSample);
% get wrist extension moment arm
nMAFingExt = reshape(nMA(idExt, idDOF_MJC, :),1,numSample);
% get wrist flexion moment arm
nMAconFingFlex = reshape(nMA_con(idFlex, idDOF_MJC, :),1,numSample);
% get wrist extension moment arm
nMAconFingExt = reshape(nMA_con(idExt, idDOF_MJC, :),1,numSample);

%% Get all the data for the moment arms about wrist flex/ext DOF
% add path to metaMuscle and metaDOF
sPath = [getenv('NE_REPOSITORIES'), 'haptix', filesep, 'mbm', filesep];
addpath(sPath);

metaDOF = load_csv(...
    'sPath', sPath,...
    'sFile', 'mbm_metaDOF_18.csv',...
    'bVerbose', false);

metaMuscle = load_csv(...
    'sPath', sPath,...
    'sFile', 'mbm_metaMuscle.csv',...
    'bVerbose', false);

ix = find(idDOF_MJC == metaDOF.idDOF_MJC);

idDOF = metaDOF.idDOF(ix);
iC = 1;
for iMuscle = 1:numel(metaMuscle.idMuscle)
    sMuscle = metaMuscle.sMuscle{iMuscle};
    idMuscle = metaMuscle.idMuscle(iMuscle);
    idDOF_used = str2num(metaMuscle.idDOFList_used{iMuscle});
    if ~isempty(find(idDOF_used == idDOF,1,'first'))
        cMuscleList{iC} = sMuscle;
        nData(iC,:) = reshape(nMA(idMuscle, idDOF_MJC, :),1,numSample);
        nData_con(iC,:) = reshape(nMA_con(idMuscle, idDOF_MJC, :),1,numSample);
        iC = iC + 1;
    end
end


%% Stats
% find the mean of the dynamic moment arms for each movement
nMean = mean(nData,2);

% based on the moment arms average classify them into flexion and ext
% moment arms
ixFlex  = find(nMean > 0);
ixExt   = find(nMean < 0);


% get the first and last value from each muscle
nDataPairedFlex1 = [nData(ixFlex,1)'; nData_con(ixFlex,1)' ];
nDataPairedFlex2 = [nData(ixFlex,end)'; nData_con(ixFlex,end)' ];

nDataPairedExt1 = [nData(ixExt,1)'; nData_con(ixExt,1)'];
nDataPairedExt2 = [nData(ixExt,end)'; nData_con(ixExt,end)'];

nDataSub(1,:) = abs([nDataPairedFlex1(1,:), nDataPairedFlex2(1,:), nDataPairedExt1(1,:), nDataPairedExt2(1,:)]);
nDataSub(2,:) = abs([nDataPairedFlex1(2,:), nDataPairedFlex2(2,:), nDataPairedExt1(2,:), nDataPairedExt2(2,:)]);

% number of sample in a quarter of the data
numQuart  = round(numel(nJointPos(1,:))/4);

ix1stQuart = 1:numQuart;

ixLastQuart = (numel(nJointPos(1,:))-numQuart+1):numel(nJointPos(1,:));


% hypothesis 1 Moment arms are bigger when muscle length is smaller
% extension muscles are shortest at full extension (first value is full
% ext)
nMA_short_muscle_ext = [mean(abs(nData(ixExt,ix1stQuart))'); abs(nData_con(ixExt,1)')];

% flexion muscles are shortest at full flexion (last value is full
% flex)
nMA_short_muscle_flex = [mean(abs(nData(ixFlex,ixLastQuart))'); abs(nData_con(ixFlex,end)')];

% place flexion and ext into a group for comparison with constant
nMA_short_muscle = [nMA_short_muscle_ext, nMA_short_muscle_flex];

nMA_short_Dyn_minus_con = nMA_short_muscle(1,:)-nMA_short_muscle(2,:);

nShortMeanFromCon = mean(nMA_short_Dyn_minus_con./nMA_short_muscle(2,:));
nShortSTDFromCon  = std(nMA_short_Dyn_minus_con./nMA_short_muscle(2,:));

[H1, P1,C1,STATS1] = ttest(nMA_short_Dyn_minus_con',0,'tail','right');

fprintf('\nHypothesis 1: Moment arms are bigger when muscle length is smaller\nMean is %0.3f (normalized to constant MA)\nSD is %0.3f (normalized to constant MA)\nP-value is %0.3e\n\n', nShortMeanFromCon, nShortSTDFromCon, P1);

% hypothesis 2 Moment arms are smaller when muscle length is longer
% extension muscles are longest at full flexion (last value is full
% flex)
nMA_long_muscle_ext = [mean(abs(nData(ixExt,ixLastQuart))'); abs(nData_con(ixExt,end)')];

% flexion muscles are longest at full flexion (first value is full
% ext)
nMA_long_muscle_flex = [mean(abs(nData(ixFlex,ix1stQuart))'); abs(nData_con(ixFlex,1)')];

% place flexion and ext into a group for comparison with constant
nMA_long_muscle = [nMA_long_muscle_ext, nMA_long_muscle_flex];

nMA_long_Dyn_minus_con = nMA_long_muscle(1,:)-nMA_long_muscle(2,:);


nLongMeanFromCon = mean(nMA_long_Dyn_minus_con./nMA_long_muscle(2,:));
nLongSTDFromCon  = std(nMA_long_Dyn_minus_con./nMA_long_muscle(2,:));


[H2, P2,C2,STATS2] = ttest(nMA_long_Dyn_minus_con,0,'tail','left');

fprintf('\nHypothesis 2: Moment arms are smaller when muscle length is longer\nMean is %0.3f (normalized to constant MA)\nSD is %0.3f (normalized to constant MA)\nP-value is %0.2e\n\n', nLongMeanFromCon, nLongSTDFromCon, P2);

%% create figures
hFig = figure;
hold on
plot(nJointPos(7,:)*180/pi, abs(nMAExt)*1000, 'r', 'LineWidth', 3)
plot(nJointPos(7,:)*180/pi, abs(nMAFlex)*1000, 'b', 'LineWidth', 3)
% plot(nJointPos(7,:)*180/pi, abs(nMAFingExt)*1000, 'r--', 'LineWidth', 3)
% plot(nJointPos(7,:)*180/pi, abs(nMAFingFlex)*1000, 'b--', 'LineWidth', 3)
plot(nJointPos(7,:)*180/pi, abs(nMAconExt)*1000, 'r', 'LineWidth', 3)
plot(nJointPos(7,:)*180/pi, abs(nMAconFlex)*1000, 'b', 'LineWidth', 3)
% plot(nJointPos(7,:)*180/pi, abs(nMAconFingExt)*1000, 'r--', 'LineWidth', 3)
% plot(nJointPos(7,:)*180/pi, abs(nMAconFingFlex)*1000, 'b--', 'LineWidth', 3)
plot([nJointPos(7,ix1stQuart(end))*180/pi, nJointPos(7,ix1stQuart(end))*180/pi], [2, 18], 'k', 'LineWidth', 3)
plot([nJointPos(7,ixLastQuart(1))*180/pi, nJointPos(7,ixLastQuart(1))*180/pi], [2, 18], 'k', 'LineWidth', 3)
hold off

ylabel('Moment Arm (mm)')
xlabel('Wrist Joint Angle (deg)')
title('Wrist Moment Arms')
% legend('Wrist Ext', 'Wrist Flex', 'Finger Ext', 'Finger Flex',...
%     'orientation', 'horizontal', 'Location', 'southoutside');

printpdf(hFig, 'ra_wr_e_f_dyn_con_comparison.pdf')

%% Make Cluster Figure for the same movement
addpath('Cluster Scripts')
nData = abs(nData);
% get Pearson matrix data
[nR, nP]  = getPearsonMatrix(nData);
% HVE
nHVE      = getHVE(nR);

% make polar dendogram
[idCluster, idPerm]= HVEClustering(nR, cMuscleList,...
    'bPrint', true,...
    'sFile', ['ra_wr_e_f_dendogram.pdf']);
% need a new order to match dendogram
nNewIdPerm = idPerm(24:-1:1)';
% make correlation matrix
h         = plotCorrMatrix(nR(nNewIdPerm,nNewIdPerm), nP(nNewIdPerm,nNewIdPerm),...
    'bPrint', true,...
    'sSignalList', cMuscleList(nNewIdPerm),...
    'sFile', ['ra_wr_e_f_heatmap.pdf']);

