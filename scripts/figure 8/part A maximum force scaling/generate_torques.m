
%% generation of torques through the muscle model
function [nTorque, nMuscleTorques] = generate_torques(idMuscleList, nPosition, metaMuscle)
% Muscle length data
nL  = lenfunc_c(nPosition);
% Muscle moment arm data
nMA = momarmfunc_c(nPosition);

% activation signal
nA = zeros(54,1);
nA(idMuscleList) = 1;
% muscle Range of Motion
nROM	= [metaMuscle.nLengthMin, metaMuscle.nLengthMax];
% maximum muscle force
nFmax   = metaMuscle.nFmax;
% beta scaling
nFmax   = nFmax.*metaMuscle.nBeta;
% time between input signals
dt  = 0.002;
% passive muscle force
nFpass  = metaMuscle.nFpass;
% passive length
nLpass  = metaMuscle.nLpass;
% calculate muscle force
nF = muscle_model(nA,nL,nROM,nFmax,dt,nFpass,nLpass);

% calculate joint torques per muscle
nMuscleTorques  = (nF*ones(1,23)).*nMA;
% calculate joint torques
nTorque      	= sum(nMuscleTorques,1);
