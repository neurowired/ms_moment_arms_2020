function make_figures

metaMuscle = load_csv(...
    'sPath',cd,...
    'sFile','metaMuscle.csv',...
    'bVerbose', false);

metaTorqueMVC = load_csv(...
    'sPath',cd,...
    'sFile','DOF_MVC_Values.csv',...
    'bVerbose', false);

torque_before_and_after(metaMuscle, metaTorqueMVC)

load('torque_before_after.mat')


%% scatter plots
% make scatter plots of the data
figure
hold on
% plot desired
scatter([1:16],abs(nTdesired),'*k', 'LineWidth', 2, 'SizeData', 120);
% plot before
scatter([1:16],abs(nTbefore),'r', 'LineWidth', 2, 'SizeData', 120);
ylabel('Maximum Joint Torque (Nm)')
legend('desired', 'original model')
hAx = gca;
hAx.XTick = 1:16;
hAx.XTickLabel = sDescr;
hAx.XTickLabelRotation = 45;
printpdf(gcf, 'Maximum Joint Torque Before.pdf')

figure
hold on
% plot desired
scatter([1:16],nTdesired,'k*', 'LineWidth', 2, 'SizeData', 120);
% plot before
scatter([1:16],abs(nTbefore),'r', 'LineWidth', 2, 'SizeData', 120);
% plot after
scatter([1:16],abs(nTafter),'b', 'LineWidth', 2, 'SizeData', 120);
ylabel('Moment Arm Maximum Torque (Nm)')
legend('desired', 'original model', 'scaled model')
hAx = gca;
hAx.XTick = 1:16;
hAx.XTickLabel = sDescr;
hAx.XTickLabelRotation = 45;
printpdf(gcf, 'Maximum Joint Torque After.pdf')



% %% histrograms
% 
% figure
% h1 = histogram(abs(abs(nTbefore)-nTdesired), [0:0.25:9]);
% hold on
% h2 = histogram(abs(abs(nTafter)-nTdesired), [0:0.25:9]);
% 
% figure
% qqplot(abs(abs(nTbefore)-nTdesired))
% figure
% qqplot(abs(abs(nTafter)-nTdesired))

