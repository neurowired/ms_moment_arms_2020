function  torque_before_and_after(metaMuscle, metaTorqueMVC)
metaMuscle_true = metaMuscle;

nTorqueOut.idMJC        = {};
nTorqueOut.sDescr       = {};
nTorqueOut.nTbefore     = [];
nTorqueOut.nTdesired    = [];
nTorqueOut.nTafter      = [];

%% Index Finger flexion
% description of task being scaled
sDescr = 'index MCP flex';
% find specific task in metaTorqueMVC
ix = find(strcmp(sDescr, metaTorqueMVC.sDescription));
% Muscle to receive maximum activation
sMuscle         = {'FDS2', 'FDP2'};
idMuscle        = [36, 40];
% boolean of which muscles in list to scale
ixScale         = [true true];
nPosition       = single(str2num(metaTorqueMVC.cModelPosition{ix})')*pi/180;
% before scaling
metaMuscle.nBeta = ones(54,1);
clear muscle_model
% run in multiple times because of stacking of data
for iC = 1:50
    [nTorques, ~]   = generate_torques(idMuscle, nPosition, metaMuscle);
end
nTorqueOut.idMJC        = {metaTorqueMVC.idDOF_MJC{ix}};
nTorqueOut.sDescr       = {metaTorqueMVC.sDescription{ix}};
nTorqueOut.nTbefore     = [nTorqueOut.nTbefore, nTorques(str2num(metaTorqueMVC.idDOF_MJC{ix}))];
nTorqueOut.nTdesired    = [nTorqueOut.nTdesired, metaTorqueMVC.nTorqueMVC(ix)];

% after scaling
metaMuscle = metaMuscle_true;
clear muscle_model
% run in multiple times because of stacking of data
for iC = 1:50
    [nTorques, ~]   = generate_torques(idMuscle, nPosition, metaMuscle);
end
nTorqueOut.nTafter      = [nTorqueOut.nTafter, nTorques(str2num(metaTorqueMVC.idDOF_MJC{ix}))];


%% Index Finger extension
% description of task being scaled
sDescr = 'index MCP ext';
% find specific task in metaTorqueMVC
ix = find(strcmp(sDescr, metaTorqueMVC.sDescription));
% Muscle to receive maximum activation
sMuscle         = {'EIND', 'ED2'};
idMuscle        = [46, 45];
% boolean of which muscles in list to scale
ixScale         = [true true];
nPosition       = single(str2num(metaTorqueMVC.cModelPosition{ix})')*pi/180;
% before scaling
metaMuscle.nBeta = ones(54,1);
clear muscle_model
% run in multiple times because of stacking of data
for iC = 1:50
    [nTorques, ~]   = generate_torques(idMuscle, nPosition, metaMuscle);
end
nTorqueOut.idMJC        = [nTorqueOut.idMJC, metaTorqueMVC.idDOF_MJC{ix}];
nTorqueOut.sDescr       = [nTorqueOut.sDescr, metaTorqueMVC.sDescription(ix)];
nTorqueOut.nTbefore     = [nTorqueOut.nTbefore, nTorques(str2num(metaTorqueMVC.idDOF_MJC{ix}))];
nTorqueOut.nTdesired    = [nTorqueOut.nTdesired, metaTorqueMVC.nTorqueMVC(ix)];

% after scaling
metaMuscle = metaMuscle_true;
clear muscle_model
% run in multiple times because of stacking of data
for iC = 1:50
    [nTorques, ~]   = generate_torques(idMuscle, nPosition, metaMuscle);
end
nTorqueOut.nTafter      = [nTorqueOut.nTafter, nTorques(str2num(metaTorqueMVC.idDOF_MJC{ix}))];



%% Middle Finger flexion
% description of task being scaled
sDescr = 'middle  MCP flex';
% find specific task in metaTorqueMVC
ix = find(strcmp(sDescr, metaTorqueMVC.sDescription));
% Muscle to receive maximum activation
sMuscle         = {'FDS3', 'FDP3'};
idMuscle        = [35, 39];
% boolean of which muscles in list to scale
ixScale         = [true true];
nPosition       = single(str2num(metaTorqueMVC.cModelPosition{ix})')*pi/180;
% before scaling
metaMuscle.nBeta = ones(54,1);
clear muscle_model
% run in multiple times because of stacking of data
for iC = 1:50
    [nTorques, ~]   = generate_torques(idMuscle, nPosition, metaMuscle);
end
nTorqueOut.idMJC        = [nTorqueOut.idMJC, metaTorqueMVC.idDOF_MJC{ix}];
nTorqueOut.sDescr       = [nTorqueOut.sDescr, metaTorqueMVC.sDescription(ix)];
nTorqueOut.nTbefore     = [nTorqueOut.nTbefore, nTorques(str2num(metaTorqueMVC.idDOF_MJC{ix}))];
nTorqueOut.nTdesired    = [nTorqueOut.nTdesired, metaTorqueMVC.nTorqueMVC(ix)];

% after scaling
metaMuscle = metaMuscle_true;
clear muscle_model
% run in multiple times because of stacking of data
for iC = 1:50
    [nTorques, ~]   = generate_torques(idMuscle, nPosition, metaMuscle);
end
nTorqueOut.nTafter      = [nTorqueOut.nTafter, nTorques(str2num(metaTorqueMVC.idDOF_MJC{ix}))];



%% Middle Finger extension
% description of task being scaled
sDescr = 'middle  MCP ext';
% find specific task in metaTorqueMVC
ix = find(strcmp(sDescr, metaTorqueMVC.sDescription));
% Muscle to receive maximum activation
sMuscle         = {'ED3'};
idMuscle        = [44];
% boolean of which muscles in list to scale
ixScale         = true ;
nPosition       = single(str2num(metaTorqueMVC.cModelPosition{ix})')*pi/180;
% before scaling
metaMuscle.nBeta = ones(54,1);
clear muscle_model
% run in multiple times because of stacking of data
for iC = 1:50
    [nTorques, ~]   = generate_torques(idMuscle, nPosition, metaMuscle);
end
nTorqueOut.idMJC        = [nTorqueOut.idMJC, metaTorqueMVC.idDOF_MJC{ix}];
nTorqueOut.sDescr       = [nTorqueOut.sDescr, metaTorqueMVC.sDescription(ix)];
nTorqueOut.nTbefore     = [nTorqueOut.nTbefore, nTorques(str2num(metaTorqueMVC.idDOF_MJC{ix}))];
nTorqueOut.nTdesired    = [nTorqueOut.nTdesired, metaTorqueMVC.nTorqueMVC(ix)];

% after scaling
metaMuscle = metaMuscle_true;
clear muscle_model
% run in multiple times because of stacking of data
for iC = 1:50
    [nTorques, ~]   = generate_torques(idMuscle, nPosition, metaMuscle);
end
nTorqueOut.nTafter      = [nTorqueOut.nTafter, nTorques(str2num(metaTorqueMVC.idDOF_MJC{ix}))];


%% Ring Finger flexion
% description of task being scaled
sDescr = 'ring  MCP flex';
% find specific task in metaTorqueMVC
ix = find(strcmp(sDescr, metaTorqueMVC.sDescription));
% Muscle to receive maximum activation
sMuscle         = {'FDS4', 'FDP4'};
idMuscle        = [34, 38];
% boolean of which muscles in list to scale
ixScale         = [true true];
nPosition       = single(str2num(metaTorqueMVC.cModelPosition{ix})')*pi/180;
% before scaling
metaMuscle.nBeta = ones(54,1);
clear muscle_model
% run in multiple times because of stacking of data
for iC = 1:50
    [nTorques, ~]   = generate_torques(idMuscle, nPosition, metaMuscle);
end
nTorqueOut.idMJC        = [nTorqueOut.idMJC, metaTorqueMVC.idDOF_MJC{ix}];
nTorqueOut.sDescr       = [nTorqueOut.sDescr, metaTorqueMVC.sDescription(ix)];
nTorqueOut.nTbefore     = [nTorqueOut.nTbefore, nTorques(str2num(metaTorqueMVC.idDOF_MJC{ix}))];
nTorqueOut.nTdesired    = [nTorqueOut.nTdesired, metaTorqueMVC.nTorqueMVC(ix)];

% after scaling
metaMuscle = metaMuscle_true;
clear muscle_model
% run in multiple times because of stacking of data
for iC = 1:50
    [nTorques, ~]   = generate_torques(idMuscle, nPosition, metaMuscle);
end
nTorqueOut.nTafter      = [nTorqueOut.nTafter, nTorques(str2num(metaTorqueMVC.idDOF_MJC{ix}))];



%% Ring Finger extension
% description of task being scaled
sDescr = 'ring  MCP ext';
% find specific task in metaTorqueMVC
ix = find(strcmp(sDescr, metaTorqueMVC.sDescription));
% Muscle to receive maximum activation
sMuscle         = {'ED4'};
idMuscle        = [43];
% boolean of which muscles in list to scale
ixScale         = true;
nPosition       = single(str2num(metaTorqueMVC.cModelPosition{ix})')*pi/180;
% before scaling
metaMuscle.nBeta = ones(54,1);
clear muscle_model
% run in multiple times because of stacking of data
for iC = 1:50
    [nTorques, ~]   = generate_torques(idMuscle, nPosition, metaMuscle);
end
nTorqueOut.idMJC        = [nTorqueOut.idMJC, metaTorqueMVC.idDOF_MJC{ix}];
nTorqueOut.sDescr       = [nTorqueOut.sDescr, metaTorqueMVC.sDescription(ix)];
nTorqueOut.nTbefore     = [nTorqueOut.nTbefore, nTorques(str2num(metaTorqueMVC.idDOF_MJC{ix}))];
nTorqueOut.nTdesired    = [nTorqueOut.nTdesired, metaTorqueMVC.nTorqueMVC(ix)];

% after scaling
metaMuscle = metaMuscle_true;
clear muscle_model
% run in multiple times because of stacking of data
for iC = 1:50
    [nTorques, ~]   = generate_torques(idMuscle, nPosition, metaMuscle);
end
nTorqueOut.nTafter      = [nTorqueOut.nTafter, nTorques(str2num(metaTorqueMVC.idDOF_MJC{ix}))];



%% Pinky Finger flexion
% description of task being scaled
sDescr = 'pinky  MCP flex';
% find specific task in metaTorqueMVC
ix = find(strcmp(sDescr, metaTorqueMVC.sDescription));
% Muscle to receive maximum activation
sMuscle         = {'FDS5', 'FDP5'};
idMuscle        = [33, 37];
% boolean of which muscles in list to scale
ixScale         = [true true];
nPosition       = single(str2num(metaTorqueMVC.cModelPosition{ix})')*pi/180;
% before scaling
metaMuscle.nBeta = ones(54,1);
clear muscle_model
% run in multiple times because of stacking of data
for iC = 1:50
    [nTorques, ~]   = generate_torques(idMuscle, nPosition, metaMuscle);
end
nTorqueOut.idMJC        = [nTorqueOut.idMJC, metaTorqueMVC.idDOF_MJC{ix}];
nTorqueOut.sDescr       = [nTorqueOut.sDescr, metaTorqueMVC.sDescription(ix)];
nTorqueOut.nTbefore     = [nTorqueOut.nTbefore, nTorques(str2num(metaTorqueMVC.idDOF_MJC{ix}))];
nTorqueOut.nTdesired    = [nTorqueOut.nTdesired, metaTorqueMVC.nTorqueMVC(ix)];

% after scaling
metaMuscle = metaMuscle_true;
clear muscle_model
% run in multiple times because of stacking of data
for iC = 1:50
    [nTorques, ~]   = generate_torques(idMuscle, nPosition, metaMuscle);
end
nTorqueOut.nTafter      = [nTorqueOut.nTafter, nTorques(str2num(metaTorqueMVC.idDOF_MJC{ix}))];



%% Pinky Finger extension
% description of task being scaled
sDescr = 'pinky  MCP ext';
% find specific task in metaTorqueMVC
ix = find(strcmp(sDescr, metaTorqueMVC.sDescription));
% Muscle to receive maximum activation
sMuscle         = {'ED5', 'ED_M'};
idMuscle        = [42, 41];
% boolean of which muscles in list to scale
ixScale         = [true true];
nPosition       = single(str2num(metaTorqueMVC.cModelPosition{ix})')*pi/180;
% before scaling
metaMuscle.nBeta = ones(54,1);
clear muscle_model
% run in multiple times because of stacking of data
for iC = 1:50
    [nTorques, ~]   = generate_torques(idMuscle, nPosition, metaMuscle);
end
nTorqueOut.idMJC        = [nTorqueOut.idMJC, metaTorqueMVC.idDOF_MJC{ix}];
nTorqueOut.sDescr       = [nTorqueOut.sDescr, metaTorqueMVC.sDescription(ix)];
nTorqueOut.nTbefore     = [nTorqueOut.nTbefore, nTorques(str2num(metaTorqueMVC.idDOF_MJC{ix}))];
nTorqueOut.nTdesired    = [nTorqueOut.nTdesired, metaTorqueMVC.nTorqueMVC(ix)];

% after scaling
metaMuscle = metaMuscle_true;
clear muscle_model
% run in multiple times because of stacking of data
for iC = 1:50
    [nTorques, ~]   = generate_torques(idMuscle, nPosition, metaMuscle);
end
nTorqueOut.nTafter      = [nTorqueOut.nTafter, nTorques(str2num(metaTorqueMVC.idDOF_MJC{ix}))];



%% Thumb Flexion Abduction
% description of task being scaled
sDescr = 'thumb flex abd';
% find specific task in metaTorqueMVC
ix = find(strcmp(sDescr, metaTorqueMVC.sDescription));
% Muscle to receive maximum activation
sMuscleFlexAbd  = {'FPB', 'FPL', 'OP', 'APB'};
idMuscle        = [49, 50, 52, 53];
% boolean of which muscles in list to scale
ixScale         = [true, true, true, true];
nPosition       = single(str2num(metaTorqueMVC.cModelPosition{ix})')*pi/180;
% before scaling
metaMuscle.nBeta = ones(54,1);
clear muscle_model
% run in multiple times because of stacking of data
for iC = 1:50
    [nTorques, ~]   = generate_torques(idMuscle, nPosition, metaMuscle);
end
nTorqueOut.idMJC        = [nTorqueOut.idMJC, metaTorqueMVC.idDOF_MJC(ix)];
nTorqueOut.sDescr       = [nTorqueOut.sDescr, metaTorqueMVC.sDescription(ix)];

nTorqueSimulated = abs(nTorques(str2num(metaTorqueMVC.idDOF_MJC{ix})));
nTorqueSimulated = cosd(45)*nTorqueSimulated(1) + cosd(45)*nTorqueSimulated(2);
nTorqueOut.nTbefore     = [nTorqueOut.nTbefore, nTorqueSimulated];

nTorqueOut.nTdesired    = [nTorqueOut.nTdesired, metaTorqueMVC.nTorqueMVC(ix)];

% after scaling
metaMuscle = metaMuscle_true;
clear muscle_model
% run in multiple times because of stacking of data
for iC = 1:50
    [nTorques, ~]   = generate_torques(idMuscle, nPosition, metaMuscle);
end

nTorqueSimulated = abs(nTorques(str2num(metaTorqueMVC.idDOF_MJC{ix})));
nTorqueSimulated = cosd(45)*nTorqueSimulated(1) + cosd(45)*nTorqueSimulated(2);

nTorqueOut.nTafter      = [nTorqueOut.nTafter, nTorqueSimulated];



%% Thumb Flexion Adduction
% description of task being scaled
sDescr = 'thumb flex add';
% find specific task in metaTorqueMVC
ix = find(strcmp(sDescr, metaTorqueMVC.sDescription));
% Muscle to receive maximum activation
sMuscleFlexAdd  = {'ADPT'};
idMuscle        = [54];
% boolean of which muscles in list to scale
ixScale         = true;
nPosition       = single(str2num(metaTorqueMVC.cModelPosition{ix})')*pi/180;
% before scaling
metaMuscle.nBeta = ones(54,1);
clear muscle_model
% run in multiple times because of stacking of data
for iC = 1:50
    [nTorques, ~]   = generate_torques(idMuscle, nPosition, metaMuscle);
end
nTorqueOut.idMJC        = [nTorqueOut.idMJC, metaTorqueMVC.idDOF_MJC{ix}];
nTorqueOut.sDescr       = [nTorqueOut.sDescr, metaTorqueMVC.sDescription(ix)];

nTorqueSimulated = abs(nTorques(str2num(metaTorqueMVC.idDOF_MJC{ix})));
nTorqueSimulated = cosd(45)*nTorqueSimulated(1) + cosd(45)*nTorqueSimulated(2);
nTorqueOut.nTbefore     = [nTorqueOut.nTbefore, nTorqueSimulated];

nTorqueOut.nTdesired    = [nTorqueOut.nTdesired, metaTorqueMVC.nTorqueMVC(ix)];

% after scaling
metaMuscle = metaMuscle_true;
clear muscle_model
% run in multiple times because of stacking of data
for iC = 1:50
    [nTorques, ~]   = generate_torques(idMuscle, nPosition, metaMuscle);
end

nTorqueSimulated = abs(nTorques(str2num(metaTorqueMVC.idDOF_MJC{ix})));
nTorqueSimulated = cosd(45)*nTorqueSimulated(1) + cosd(45)*nTorqueSimulated(2);

nTorqueOut.nTafter      = [nTorqueOut.nTafter, nTorqueSimulated];



%% Thumb Extension Abduction
% description of task being scaled
sDescr = 'thumb ext abd';
% find specific task in metaTorqueMVC
ix = find(strcmp(sDescr, metaTorqueMVC.sDescription));
% Muscle to receive maximum activation
sMuscleExtAbd  = {'APL', 'EPB'};
idMuscle        = [51, 48];
% boolean of which muscles in list to scale
ixScale         = [true true];
nPosition       = single(str2num(metaTorqueMVC.cModelPosition{ix})')*pi/180;
% before scaling
metaMuscle.nBeta = ones(54,1);
clear muscle_model
% run in multiple times because of stacking of data
for iC = 1:50
    [nTorques, ~]   = generate_torques(idMuscle, nPosition, metaMuscle);
end
nTorqueOut.idMJC        = [nTorqueOut.idMJC, metaTorqueMVC.idDOF_MJC{ix}];
nTorqueOut.sDescr       = [nTorqueOut.sDescr, metaTorqueMVC.sDescription(ix)];

nTorqueSimulated = abs(nTorques(str2num(metaTorqueMVC.idDOF_MJC{ix})));
nTorqueSimulated = cosd(45)*nTorqueSimulated(1) + cosd(45)*nTorqueSimulated(2);
nTorqueOut.nTbefore     = [nTorqueOut.nTbefore, nTorqueSimulated];

nTorqueOut.nTdesired    = [nTorqueOut.nTdesired, metaTorqueMVC.nTorqueMVC(ix)];

% after scaling
metaMuscle = metaMuscle_true;
clear muscle_model
% run in multiple times because of stacking of data
for iC = 1:50
    [nTorques, ~]   = generate_torques(idMuscle, nPosition, metaMuscle);
end

nTorqueSimulated = abs(nTorques(str2num(metaTorqueMVC.idDOF_MJC{ix})));
nTorqueSimulated = cosd(45)*nTorqueSimulated(1) + cosd(45)*nTorqueSimulated(2);

nTorqueOut.nTafter      = [nTorqueOut.nTafter, nTorqueSimulated];


%% Thumb Extension Adduction
% description of task being scaled
sDescr = 'thumb ext add';
% find specific task in metaTorqueMVC
ix = find(strcmp(sDescr, metaTorqueMVC.sDescription));
% Muscle to receive maximum activation
sMuscleExtAdd  = {'EPL'};
idMuscle        = [47];
% boolean of which muscles in list to scale
ixScale         = true;
nPosition       = single(str2num(metaTorqueMVC.cModelPosition{ix})')*pi/180;
% before scaling
metaMuscle.nBeta = ones(54,1);
clear muscle_model
% run in multiple times because of stacking of data
for iC = 1:50
    [nTorques, ~]   = generate_torques(idMuscle, nPosition, metaMuscle);
end
nTorqueOut.idMJC        = [nTorqueOut.idMJC, metaTorqueMVC.idDOF_MJC{ix}];
nTorqueOut.sDescr       = [nTorqueOut.sDescr, metaTorqueMVC.sDescription(ix)];

nTorqueSimulated = abs(nTorques(str2num(metaTorqueMVC.idDOF_MJC{ix})));
nTorqueSimulated = cosd(45)*nTorqueSimulated(1) + cosd(45)*nTorqueSimulated(2);
nTorqueOut.nTbefore     = [nTorqueOut.nTbefore, nTorqueSimulated];

nTorqueOut.nTdesired    = [nTorqueOut.nTdesired, metaTorqueMVC.nTorqueMVC(ix)];

% after scaling
metaMuscle = metaMuscle_true;
clear muscle_model
% run in multiple times because of stacking of data
for iC = 1:50
    [nTorques, ~]   = generate_torques(idMuscle, nPosition, metaMuscle);
end

nTorqueSimulated = abs(nTorques(str2num(metaTorqueMVC.idDOF_MJC{ix})));
nTorqueSimulated = cosd(45)*nTorqueSimulated(1) + cosd(45)*nTorqueSimulated(2);

nTorqueOut.nTafter      = [nTorqueOut.nTafter, nTorqueSimulated];


%% Wrist Flexion
% description of task being scaled
sDescr = 'wrist flex';
% find specific task in metaTorqueMVC
ix = find(strcmp(sDescr, metaTorqueMVC.sDescription));
% Muscle to receive maximum activation
sMuscle     = {'FCR', 'FCU', 'PALL',...
    'FDS5', 'FDS4', 'FDS3', 'FDS2',...
    'FDP5', 'FDP4', 'FDP3', 'FDP2'};
idMuscle        = [30, 31, 32,...
    33, 34, 35, 36,...
    37, 38, 39, 40];
% boolean of which muscles in list to scale
ixScale     = [true, true, true,...
    false, false, false, false,...
    false, false, false, false,...
    false, false, false];
nPosition       = single(str2num(metaTorqueMVC.cModelPosition{ix})')*pi/180;
% before scaling
metaMuscle.nBeta = ones(54,1);
clear muscle_model
% run in multiple times because of stacking of data
for iC = 1:50
    [nTorques, ~]   = generate_torques(idMuscle, nPosition, metaMuscle);
end
nTorqueOut.idMJC        = [nTorqueOut.idMJC, metaTorqueMVC.idDOF_MJC{ix}];
nTorqueOut.sDescr       = [nTorqueOut.sDescr, metaTorqueMVC.sDescription(ix)];
nTorqueOut.nTbefore     = [nTorqueOut.nTbefore, nTorques(str2num(metaTorqueMVC.idDOF_MJC{ix}))];
nTorqueOut.nTdesired    = [nTorqueOut.nTdesired, metaTorqueMVC.nTorqueMVC(ix)];

% after scaling
metaMuscle = metaMuscle_true;
clear muscle_model
% run in multiple times because of stacking of data
for iC = 1:50
    [nTorques, ~]   = generate_torques(idMuscle, nPosition, metaMuscle);
end
nTorqueOut.nTafter      = [nTorqueOut.nTafter, nTorques(str2num(metaTorqueMVC.idDOF_MJC{ix}))];



%% Wrist Extension
% description of task being scaled
sDescr = 'wrist ext';
% find specific task in metaTorqueMVC
ix = find(strcmp(sDescr, metaTorqueMVC.sDescription));
% Muscle to receive maximum activation
sMuscle  = {'ECR_LO', 'ECR_BR', 'ECU',...
    'ED_M', 'ED5', 'ED4', 'ED3', 'ED2', 'EIND'};
idMuscle        = [27, 28, 29,...
    41, 42, 43, 44, 45, 46];
% boolean of which muscles in list to scale
ixScale         = [true, true, true,...
    false, false, false, false, false, false,...
    false];
nPosition       = single(str2num(metaTorqueMVC.cModelPosition{ix})')*pi/180;
% before scaling
metaMuscle.nBeta = ones(54,1);
clear muscle_model
% run in multiple times because of stacking of data
for iC = 1:50
    [nTorques, ~]   = generate_torques(idMuscle, nPosition, metaMuscle);
end
nTorqueOut.idMJC        = [nTorqueOut.idMJC, metaTorqueMVC.idDOF_MJC{ix}];
nTorqueOut.sDescr       = [nTorqueOut.sDescr, metaTorqueMVC.sDescription(ix)];
nTorqueOut.nTbefore     = [nTorqueOut.nTbefore, nTorques(str2num(metaTorqueMVC.idDOF_MJC{ix}))];
nTorqueOut.nTdesired    = [nTorqueOut.nTdesired, metaTorqueMVC.nTorqueMVC(ix)];

% after scaling
metaMuscle = metaMuscle_true;
clear muscle_model
% run in multiple times because of stacking of data
for iC = 1:50
    [nTorques, ~]   = generate_torques(idMuscle, nPosition, metaMuscle);
end
nTorqueOut.nTafter      = [nTorqueOut.nTafter, nTorques(str2num(metaTorqueMVC.idDOF_MJC{ix}))];



%% Wrist Pronation
% description of task being scaled
sDescr = 'wrist pro';
% find specific task in metaTorqueMVC
ix = find(strcmp(sDescr, metaTorqueMVC.sDescription));
% Muscle to receive maximum activation
sMuscle  = {'PTER', 'PQUAD'}; % currently ignoring other muscles
idMuscle        = [25, 26];
% boolean of which muscles in list to scale
ixScale         = [true, true];
nPosition       = single(str2num(metaTorqueMVC.cModelPosition{ix})')*pi/180;
% before scaling
metaMuscle.nBeta = ones(54,1);
clear muscle_model
% run in multiple times because of stacking of data
for iC = 1:50
    [nTorques, ~]   = generate_torques(idMuscle, nPosition, metaMuscle);
end
nTorqueOut.idMJC        = [nTorqueOut.idMJC, metaTorqueMVC.idDOF_MJC{ix}];
nTorqueOut.sDescr       = [nTorqueOut.sDescr, metaTorqueMVC.sDescription(ix)];
nTorqueOut.nTbefore     = [nTorqueOut.nTbefore, nTorques(str2num(metaTorqueMVC.idDOF_MJC{ix}))];
nTorqueOut.nTdesired    = [nTorqueOut.nTdesired, metaTorqueMVC.nTorqueMVC(ix)];

% after scaling
metaMuscle = metaMuscle_true;
clear muscle_model
% run in multiple times because of stacking of data
for iC = 1:50
    [nTorques, ~]   = generate_torques(idMuscle, nPosition, metaMuscle);
end
nTorqueOut.nTafter      = [nTorqueOut.nTafter, nTorques(str2num(metaTorqueMVC.idDOF_MJC{ix}))];



%% Wrist Supination
% description of task being scaled
sDescr = 'wrist sup';
% find specific task in metaTorqueMVC
ix = find(strcmp(sDescr, metaTorqueMVC.sDescription));
% Muscle to receive maximum activation
sMuscle  = {'SUP', 'BIC_LO', 'BIC_SH'}; % currently ignoring other muscles
idMuscle        = [24, 20, 21];
% boolean of which muscles in list to scale
ixScale = [true, true, true];
nPosition       = single(str2num(metaTorqueMVC.cModelPosition{ix})')*pi/180;
% before scaling
metaMuscle.nBeta = ones(54,1);
clear muscle_model
% run in multiple times because of stacking of data
for iC = 1:50
    [nTorques, ~]   = generate_torques(idMuscle, nPosition, metaMuscle);
end
nTorqueOut.idMJC        = [nTorqueOut.idMJC, metaTorqueMVC.idDOF_MJC{ix}];
nTorqueOut.sDescr       = [nTorqueOut.sDescr, metaTorqueMVC.sDescription(ix)];
nTorqueOut.nTbefore     = [nTorqueOut.nTbefore, nTorques(str2num(metaTorqueMVC.idDOF_MJC{ix}))];
nTorqueOut.nTdesired    = [nTorqueOut.nTdesired, metaTorqueMVC.nTorqueMVC(ix)];

% after scaling
metaMuscle = metaMuscle_true;
clear muscle_model
% run in multiple times because of stacking of data
for iC = 1:50
    [nTorques, ~]   = generate_torques(idMuscle, nPosition, metaMuscle);
end
nTorqueOut.nTafter      = [nTorqueOut.nTafter, nTorques(str2num(metaTorqueMVC.idDOF_MJC{ix}))];

save('torque_before_after.mat', '-struct', 'nTorqueOut')
