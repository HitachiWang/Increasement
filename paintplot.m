t=1961:2005;
plot(t,CorE,t,CorW,'LineWidth',1.2);
xlim([1961 2005]);
%  ylim([-0.4 1.1]);
legend('CM','WZZM');
 ylabel('Pearson Correlation Coefficients');
% ylabel('RMSE');
set(gca, 'Fontname', 'Times New Roman', 'Fontsize', 10);
