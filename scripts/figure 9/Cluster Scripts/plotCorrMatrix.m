% _________________________________________________________________________
% function plotCorrGrid(nR,nP, ...<PROPERTIES>)
%
% PLOT CORRELATION MATRIX HEATMAP
%
% INPUT -------------------------------------------------------------------
%  nR          <numeric> correlation matrix, needs to be square, 3rd dimension
%                     indicates multiple correlation matrixes
%  nP          <numeric> p-value matrix, needs to be save size as
%                     correlation matrix 

%
% PROPERTIES --------------------------------------------------------------
%  sFile       <string> file name for figure PDF
%  sPath       <string> directory where file is to be saved (default: cd)
%  alpha       <numeric> significance criteria (default: 0.05)
%  bPrint      <boolean> flag to print PDF of figure
%  sRepList    <cell> list of names for repetitions denoting the 3rd 
%                     dimention of correlation matrix
%  sSignalList <cell> list of names for correlated signals
%
% Examples ---------------------------------------------------------------- 
%   plotCorrGrid(eye(3),zeros(3,3),'sRepList',{'Ones'},'sSignalList',{'1','2','3'});
%
% SEE ALSO: 
% printpdf()      % PRINT FIGURE IN PDF VECTOR FORMAT

% Sergiy Yakovenko © 2007-2012
% 26-Feb-2016 © Valeriya Gritsenko

function h = plotCorrMatrix(nR,nP, varargin)
sWorkPath = cd;
[nSignal,~,nRep] = size(nR);

% Assign defaults and inputs
in.sFile             = 'default.pdf'; % [sFile,sPath] = uiputfile('*.pdf');
in.sPath             = sWorkPath;
in.alpha             = 0.05;
in.bPrint             = 0;

for iRep = 1:nRep
    in.sRepList(iRep)  = {['rep',num2str(iRep)]};
end

for iSignal = 1:nSignal
    in.sSignalList(iSignal) = {['signal',num2str(iSignal)]};
end

if ~isempty(varargin)
   for i = 1:numel(varargin)/2
      in.(varargin{(i-1)*2+1}) = varargin{i*2};
   end
end

[in.hFig, ~, hText]  = setPlot('sAnnotation',in.sRepList(1));
set(gcf, 'WindowStyle', 'Docked');

%% plot correlation matrix

% set color palette
color_mat = parula(11);
color_mat(6,:) = [1 1 1];
colormap(color_mat);

% correct for any NaNs
nR(isnan(nR)) = 0;

% set figure
h = imagesc(nR(:,:,1));
caxis([-1 1]);
colorbar;
axis square
set(gca,...
    'XTick',1:nSignal,...
    'XTickLabel',in.sSignalList,...
    'XTickLabelRotation',90,...
    'XAxisLocation','top',...
    'TickLabelInterpreter','none')

set(gca,...
    'YTick',1:nSignal,...
    'YTickLabel',in.sSignalList,...
    'YTickLabelRotation',0,...
    'TickLabelInterpreter','none')


% plot matrix
cd(in.sPath)
for iRep = 1:nRep
    sRep = in.sRepList{iRep};
    sRep(strfind(sRep,'_')) = '-';    
    hText.String    = ['CORRELATION MATRIX ',sRep];
    rho_adj         = nR(:,:,iRep);
    pval_adj        = nP(:,:,iRep);
    rho_adj(pval_adj>in.alpha & pval_adj<1) = 0;
    h.CData         = rho_adj;
    colormap(color_mat)
    drawnow
    
    % print PDF
    if in.bPrint
    printpdf(gcf,[in.sFile(1:end-4),'_',sRep,'.pdf'],'landscape')
    end
    
end
cd(sWorkPath)
