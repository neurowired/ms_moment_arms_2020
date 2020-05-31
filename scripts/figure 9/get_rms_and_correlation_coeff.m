clc
clear

% load data from moment arm validation
load('MS_Moment_Arm_validation.mat')

% get muscle names from the data
cMuscles = fields(Data);
% counter
iC = 1;
% loop through each muscle
for iM = 1:numel(cMuscles)
    % loop through each DOF that muscle spans
    for iDof = 1:numel(Data.(cMuscles{iM}).sDOF)
        % if the muscle DOF passed the metrics
        if Data.(cMuscles{iM}).bGood(iDof)
            % if the muscle DOF passed the normalized RMSE check
            if isnan(Data.(cMuscles{iM}).nRMSE{iDof})
                % get the numer of profiles that were for the muscle DOF
                numPostures = numel(Data.(cMuscles{iM}).nRMSE_norm{iDof}); 
                % pull the Normalized RMSE from the data
                nRMSE_norm(iC:(iC+numPostures-1)) = Data.(cMuscles{iM}).nRMSE_norm{iDof};
                % pull the correlation coefficients
                nR(iC:(iC+numPostures-1))   = Data.(cMuscles{iM}).nR{iDof};
                % adjust the counter for the data pulled
                iC = iC + 1 + numPostures - 1;
            end
        end
    end
end

disp('Looking at only muscles that passed the metric')
disp('Removed muscle DOFs that failed the normalized RMSE check but passed by having an RMSE less than 0.1')
fprintf('showing RMSE norm only\n\normalized RMSE mean = %0.4f\nnormalized RMSE std = %0.4f\n', mean(nRMSE_norm), std(nRMSE_norm))
fprintf('R mean = %0.4f\nR std = %0.4f\n\n', mean(nR), std(nR))





