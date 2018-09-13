% 8Aera作图
% Periodogram PSD of G500 in 6Aera - WZZM Form
% plot PSD_Figure
figure(1)
plot(f1,PXX_WZZM_8Aera(:,4),f1,PXX_E_8Aera(:,4),f1,PXX_O_8Aera(:,4),'LineWidth',1);
hold on;
grid on;
plot(f1,RedConf_O_8Aera(:,1,4)./100,'r-.');
xlabel('Cycles/Year')
ylabel('PSD(W/Hz)')
% title('Periodogram of G500 Global.Mean')
FF=[0:0.05:0.5];
t=round(0.5./FF.*100)/100;
%set(gca,'xticklabel',t);
set(gca,'Ylim',[0 9000])
legend('WZZM','CM','Obs');
set(gca, 'Fontname', 'Times New Roman', 'Fontsize', 10);
figure(4)
plot(f1,PXX_WZZM_8Aera(:,[1 2 3 5 6 8]),'LineWidth',1);
hold on;
%plot(f1,RedConf_WZZM_GlobalAve(:,1),'r-.',f1,RedConf_WZZM_GlobalAve(:,2),'g-.')
grid on;
xlabel('Cycles/Year')
ylabel('dB')
title('Periodogram PSD of G500 in 6Aera - WZZM Form')
FF=[0.5/42 0.05:0.05:0.5];
t=[round(0.5./FF.*100)/100 ];
set(gca,'xtick',FF);
set(gca,'xticklabel',t);
set(gca,'Ylim',[0 2000]);
legend('1','2','3','5','6','8');
% Periodogram PSD of G500 in 6Aera - DY Form
figure(5)
plot(f1,PXX_DY_8Aera(:,[1 2 3 5 6 8]),'LineWidth',1);
hold on;
%plot(f1,RedConf_WZZM_GlobalAve(:,1),'r-.',f1,RedConf_WZZM_GlobalAve(:,2),'g-.')
grid on;
xlabel('Cycles/Year')
ylabel('dB')
title('Periodogram PSD of G500 in 6Aera - DY Form')
FF=[0.5/42 0.05:0.05:0.5];
t=[round(0.5./FF.*100)/100 ];
set(gca,'xtick',FF);
set(gca,'xticklabel',t);
set(gca,'Ylim',[0 2000]);
legend('1','2','3','5','6','8');
%Periodogram PSD of G500 in 6Aera - E Form
figure(6)
plot(f1,PXX_E_8Aera(:,[1 2 3 5 6 8]),'LineWidth',1);
hold on;
%plot(f1,RedConf_WZZM_GlobalAve(:,1),'r-.',f1,RedConf_WZZM_GlobalAve(:,2),'g-.')
grid on;
xlabel('Cycles/Year')
ylabel('dB')
title('Periodogram PSD of G500 in 6Aera - E Form')
FF=[0.5/42 0.05:0.05:0.5];
t=[round(0.5./FF.*100)/100 ];
set(gca,'xtick',FF);
set(gca,'xticklabel',t);
Max=1.1*(max(max(PXX_E_8Aera(:,[1 2 3 5 6 8]))));
set(gca,'Ylim',[0 Max]);
legend('1','2','3','5','6','8');
% Periodogram PSD of G500 in 6Aera - O Form
figure(7)
plot(f1,PXX_O_8Aera(:,[1 2 3 5 6 8]),'LineWidth',1);
hold on;
%plot(f1,RedConf_WZZM_GlobalAve(:,1),'r-.',f1,RedConf_WZZM_GlobalAve(:,2),'g-.')
grid on;
xlabel('Cycles/Year')
ylabel('dB')
title('Periodogram PSD of G500 in 6Aera - O Form')
FF=[0.5/42 0.05:0.05:0.5];
t=[round(0.5./FF.*100)/100 ];
set(gca,'xtick',FF);
set(gca,'xticklabel',t);
Max=1.1*(max(max(PXX_O_8Aera(:,[1 2 3 5 6 8]))));
set(gca,'Ylim',[0 Max]);
legend('1','2','3','5','6','8');
% A 1 2 5 FourForms
figure(8)
% 一大堆画错的图
% PXX_4Form_2Aera=[squeeze(PXX_O_8Aera(:,1))';squeeze(PXX_O_8Aera(:,5))';...
%                                  squeeze(PXX_E_8Aera(:,1))';squeeze(PXX_E_8Aera(:,5))';...
%                                  squeeze(PXX_DY_8Aera(:,1))';squeeze(PXX_DY_8Aera(:,5))';...
%                                  squeeze(PXX_WZZM_8Aera(:,1))';squeeze(PXX_WZZM_8Aera(:,5))'];
% plot(f1',PXX_4Form_2Aera');
% ArrayName = {'LineStyle','LineColor'};
% ArrayIns = {'-','r';'--','r';'-','g';'--','g';'-','b';'--','b';'-','y';'--','y'};
% set(gca,ArrayName,ArrayIns);
% ArrayName = {'LineStyle'};
% ArrayIns = {'-','--','-','--','-','--','-','--'}';
% set(gca,ArrayName,ArrayIns);
% ArrayName = {'LineColor'};
% ArrayIns = {'r','y','b','g','r','y','b','g'}';
% set(gca,ArrayName,ArrayIns);
% set(gca,'LineWidth',1);
PXX_4Form_A1=[PXX_O_8Aera(:,1),PXX_E_8Aera(:,1),...
                            PXX_DY_8Aera(:,1),PXX_WZZM_8Aera(:,1)];
PXX_4Form_A5=[PXX_O_8Aera(:,5),PXX_E_8Aera(:,5),...
                            PXX_DY_8Aera(:,5),PXX_WZZM_8Aera(:,5)];
PXX_4Form_A4=[PXX_O_8Aera(:,4),PXX_E_8Aera(:,4),...
                            PXX_DY_8Aera(:,4),PXX_WZZM_8Aera(:,4)];
ArrayName={'Color'};
ArrayValue={'r','y','g','b'}';
A1=plot(f1,PXX_4Form_A1,'LineWidth',1);
set(A1,ArrayName,ArrayValue);
hold on;
% A5=plot(f1,PXX_4Form_A5,'LineWidth',1,'LineStyle','--');
% set(A5,ArrayName,ArrayValue);
plot(f1,RedConf_WZZM_8Aera(:,1,1)./100,'r-.',f1,RedConf_WZZM_8Aera(:,2,1)./1000,'g-.')
grid on;
xlabel('Cycles/Year')
ylabel('dB')
title('Periodogram PSD of G500 in Aera1 - Four Form')
FF=[0.5/42 0.05:0.05:0.5];
t=[round(0.5./FF.*100)/100 ];
set(gca,'xtick',FF);
set(gca,'xticklabel',t);
Max=1.1*(max(max(PXX_O_8Aera(:,[1 2 3 5 6 8]))));
set(gca,'Ylim',[0 Max]);
legend(A1,'O','E','DY','WZZM');
% hold on;
% L2=legend(A5,'O','E','DY','WZZM');
figure(9)
ArrayName={'Color'};
ArrayValue={'r','y','g','b'}';
% A1=plot(f1,PXX_4Form_A1,'LineWidth',1);
% set(A1,ArrayName,ArrayValue);
hold on;
A5=plot(f1,PXX_4Form_A5,'LineWidth',1,'LineStyle','-');
set(A5,ArrayName,ArrayValue);
hold on;
plot(f1,RedConf_WZZM_8Aera(:,1,5)./100,'r-.',f1,RedConf_WZZM_8Aera(:,2,5)./1000,'g-.')
grid on;
xlabel('Cycles/Year')
ylabel('dB')
title('Periodogram PSD of G500 in Aera5 - Four Form')
FF=[0.5/42 0.05:0.05:0.5];
t=[round(0.5./FF.*100)/100 ];
set(gca,'xtick',FF);
set(gca,'xticklabel',t);
Max=1.1*(max(max(PXX_O_8Aera(:,[1 2 3 5 6 8]))));
set(gca,'Ylim',[0 Max]);
legend(A5,'O','E','DY','WZZM');
figure(10)
ArrayName={'Color'};
ArrayValue={'r','y','g','b'}';
% A1=plot(f1,PXX_4Form_A1,'LineWidth',1);
% set(A1,ArrayName,ArrayValue);
hold on;
A4=plot(f1,PXX_4Form_A4,'LineWidth',1,'LineStyle','-');
set(A4,ArrayName,ArrayValue);
hold on;
plot(f1,RedConf_WZZM_8Aera(:,1,4)./100,'r-.',f1,RedConf_WZZM_8Aera(:,2,4)./1000,'g-.')
grid on;
xlabel('Cycles/Year')
ylabel('dB')
title('Periodogram PSD of G500 in Aera4 - Four Form')
FF=[0.5/42 0.05:0.05:0.5];
t=[round(0.5./FF.*100)/100 ];
set(gca,'xtick',FF);
set(gca,'xticklabel',t);
Max=1.1*(max(max(PXX_WZZM_8Aera(:,4))));
set(gca,'Ylim',[0 Max]);
legend(A4,'O','E','DY','WZZM');