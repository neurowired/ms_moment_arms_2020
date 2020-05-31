%__________________________________________________________________________
% function [idCluster] = HierarchClustering(nR,sSignalList, varargin)
%
% CREATE HIERARCHAL CLUSTERING DENDROGRAM USING HVE DISTANCES
%
% INPUT -------------------------------------------------------------------
% nR:           <numeric> correlation matrix of synergies of size
%                   nSig x nSig, where nSig are signals for which
%                   correlations were calculated between temporal
%                   profiles (or binned profiles) for a single movement
%                   and single subject separately, e.g. MEP_BicSho,
%                   EMG_BicSho, Ia_BicSho, Angle_ShoX, GTorque_ShoX, etc.
%
% sSignalList:  <cell> Cell Array contaiing names of signals to display on
%                   dendrogram
%
% OUTPUT ------------------------------------------------------------------
% idCluster:    <numeric> matrix of cluster IDs from 2-(0.5 * # of signals)
%
% PROPERTIES --------------------------------------------------------------
% sFile:        <string> filename to save dendrogram pdf (default: default.pdf)
% bPlot:        <boolean> Flag to plot dendrogram (default: 1)
% bPrint:       <boolean> Flag to print PDF of dendrogram (default: 0)
%__________________________________________________________________________

function [idCluster, idNamePerm1] = HVEClustering(nR, sSignalList, varargin)

% Assign defaults and inputs
in.sFile             = 'default.pdf'; % [sFile,sPath] = uiputfile('*.pdf');
in.bPlot             = 1;
in.bPrint            = 0;

if ~isempty(varargin)
    for i = 1:numel(varargin)/2
        in.(varargin{(i-1)*2+1}) = varargin{i*2};
    end
end

%threshold determines coloring of dendrogram
nThresh      = 0.7; 
%total number of all signals
nSig         = length(sSignalList); 
%convert Pearson Coefficient to HVE
nHVE = getHVE(nR);

%% hierarchical clustering
nDist   = squareform(nHVE);
nTree   = linkage(nDist,'average');


%% Calculate cluster interations

for MaxClust = 1:(round(length(nHVE)/2))
    idCluster(:,MaxClust) = cluster(nTree,'MaxClust',MaxClust);
end

%% plotting dendrogram of hierarchical clustering

if in.bPlot
    
    figure
    [~,~,idNamePerm1] = dendrogram(nTree,nSig,...
        'colorthreshold',nThresh,...
        'orientation', 'left');
    printpdf(gcf,['left_', in.sFile],'landscape')
    
    [hFig, ~, ~]  = setPlot('sAnnotation',in.sFile);
    [~,~,idNamePerm] = polardendrogram(nTree,nSig,'colorthreshold',nThresh);
    set(gcf, 'WindowStyle', 'Docked');
    hAxis = gca;
    hChildren = hAxis.Children;
    for iChild = 1:numel(hChildren)
        hObj = hChildren(iChild);
        if strcmp(hObj.Type,'text')
            nLabel = str2num(hObj.String);
            if ~isempty(nLabel) && ~isempty(find(idNamePerm==nLabel,1)) && iChild >4
                set(hObj,'String',sSignalList(nLabel),...
                    'HorizontalAlignment','center',...
                    'Rotation',0,...
                    'Interpreter','none')
            end
        end
    end
    %% save figures for each movement and each subject
    if in.bPrint
    printpdf(gcf,in.sFile,'landscape')
    end
end
