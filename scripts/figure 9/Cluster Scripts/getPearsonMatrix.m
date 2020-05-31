% _________________________________________________________________________
% CREATE PEARSON COEEFICIENT MATRIX
%
% INPUT--------------------------------------------------------------------
% [nAllSignals]     <numeric> matrix of signals (by row)
%
% OUTPUT-------------------------------------------------------------------
% nR     <numeric> matrix of regression coefficients
% nP     <numeric> matrix of Pearson coefficients
%__________________________________________________________________________



function [nR,nP] = getPearsonMatrix(nAllSignals)

[nRow, ~] = size(nAllSignals);

nR = zeros(nRow);
nP = zeros(nRow);
for iCol = 1:nRow
    for iRow = 1:nRow
        if sum(diff(nAllSignals(iRow,:))) == 0
            nDataRow = nAllSignals(iRow,:)+rand(1,numel(nAllSignals(iRow,:)))*0.000001;
        else
            nDataRow = nAllSignals(iRow,:);
        end
        if sum(diff(nAllSignals(iCol,:))) == 0
            nDataCol = nAllSignals(iCol,:)+rand(1,numel(nAllSignals(iCol,:)))*0.000001;
        else
            nDataCol = nAllSignals(iCol,:);
        end
        
        [~,R,P,~] = getRegress(nAllSignals(iCol,:),nAllSignals(iRow,:));

%         [~,R,P,~] = getRegress(nDataCol,nDataRow);
        nR(iRow,iCol) = R;
        nP(iRow,iCol) = P;
    end
end