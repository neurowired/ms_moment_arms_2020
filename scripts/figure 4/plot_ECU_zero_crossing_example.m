function plot_ECU_zero_crossing_example


sPathDataNew = ['New Model/'];
sFileNewData = 'ECUMomentArm.mat';

sPathOldData = ['Old Model/'];
sFileOldData = 'ECUMomentArm.mat';


sPathList = {sPathOldData, sPathDataNew};
sFileList = {sFileOldData, sFileNewData};

hFig = figure;

for iFile = 1:numel(sFileList)
    
    nData = load([sPathList{iFile}, sFileList{iFile}]);
    hAx(iFile) = subplot(1,numel(sFileList),iFile);
    hold on
    nUnique = unique(nData.metaData.nDOF(:,1));
    % each line is at a different wrist pro/sup angle
    for iLine = 1:numel(nUnique)
        ix = find(nData.metaData.nDOF(:,1) == nUnique(iLine));
        % x axis is wrist flex/ext angle
        nDataPlotX = nData.metaData.nDOF(ix,2)*180/pi;
        % plot wrist flex/ext moment arm
        nDataPlotY = nData.metaData.nMomArm(ix,2)*1000;
        plot(nDataPlotX, nDataPlotY, 'k')
    end
    hold off
    xlim([-100, 100])
    ylim([-12, 2])
    ylabel('wrist flex/ext momemt arm (mm)')
    xlabel('wrist flex/ext DOF Angle (deg)')
end

printpdf(hFig, 'ECU_zero_crossing_example.pdf')