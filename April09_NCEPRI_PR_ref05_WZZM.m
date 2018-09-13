%this program is for DY&YR
%ENSEMBLE Project   Observation: ECWMF ERA-40 Reanalysis

%Dataset
%time Ensemble 1960-2005/46   Obs 1958-2002/45  =》 1960-2002/43
% 110-122.5
%27.5 32.5

% clc;
% clear ;
ncdisp('D:/data/Ensemble/228EnsembleJune.nc');
ncdisp('D:/data/Ensemble/pr_wtr.mon.mean.nc');

ENSEMBLE_JUNE=ncread('D:/data/Ensemble/228EnsembleJune.nc','prlr');
ENSEMBLE_JULY=ncread('D:/data/Ensemble/228EnsembleJuly.nc','prlr');
ENSEMBLE_APRIL=ncread('D:/data/Ensemble/228EnsembleApril.nc','prlr');
OBS=ncread('d:/data/Ensemble/pr_wtr.mon.mean.nc','pr_wtr',[45 24 145],[6 3 46*12]);
lat=ncread('d:/data/Ensemble/pr_wtr.mon.mean.nc','lat');
lon=ncread('d:/data/Ensemble/pr_wtr.mon.mean.nc','lon');
   %参考时间平均   
ref=2;
Ensemble_June=zeros(3,6,46,6);%这是mean.mon 选取ref=05
Ensemble_June=ENSEMBLE_JUNE(:,:,1:46,:,ref);
Ensemble_July=zeros(3,6,46,6);
Ensemble_July=ENSEMBLE_JULY(:,:,1:46,:,ref);
Ensemble_April=zeros(3,6,46,6);
Ensemble_April=ENSEMBLE_APRIL(:,:,1:46,:,ref);
%季度平均
Ensemble_SUM=(Ensemble_June+Ensemble_July+Ensemble_April)/3;
OBS_SUM=rand(3,6,46);
for i=1:46
    OBS_SUM(:,:,i)=flipud(rot90((OBS(:,:,i*12-6)+OBS(:,:,i*12-5)+OBS(:,:,i*12-4))/3));
end
ENS=6;
% for ENS=1:6
Ensemble=rand(3,6,46);
% Ensemble_June=rand(3,6,43);
% Ensemble_July=rand(3,6,43);
% Ensemble_April=rand(3,6,43);
Obs=rand(3,6,46);
%选取
    for j=1:46
        Ensemble(:,:,j)=Ensemble_SUM(24:26,45:50,j,ENS)*30*24*3600*1000; %m/s->kg/m**2
%         Ensemble_June(:,:,j)=Ensemble_June(:,:,j,ENS)/9.8;
%         Ensemble_July(:,:,j)=Ensemble_July(:,:,j,ENS)/9.8;
%         Ensemble_April(:,:,j)=Ensemble_April(:,:,j,ENS)/9.8;
        Obs(:,:,j)=OBS_SUM(:,:,j);
    end
%时间序列平均
AVE=mean(Ensemble,3);
OAVE=mean(Obs,3);
%观测距
DELTA_O=rand(3,6,46);
DELTA_E=rand(3,6,46);
for i=1:46
    DELTA_O(:,:,i)=Obs(:,:,i)-OAVE;
    DELTA_E(:,:,i)=Ensemble(:,:,i)-AVE;
end
DELTA_DY=rand(3,6,45);
DELTA_W=rand(3,6,45);
for i=2:46
    DELTA_DY(:,:,i-1)=DELTA_O(:,:,i-1)+(Ensemble(:,:,i)-Ensemble(:,:,i-1));
end
eval(['COR_DY_',num2str(ENS),'=rand(3,6);']);
eval(['RMSE_DY_',num2str(ENS),'=rand(3,6);']);
for i=1:3
    for j=1:6
        A=squeeze(DELTA_O(i,j,2:46));
        B=squeeze(DELTA_DY(i,j,:));
        [r,p]=corrcoef(A,B);
        eval(['COR_DY_',num2str(ENS),'(i,j)=r(1,2);']);
        Rmse=RMSE(A,B,45);
        eval(['RMSE_DY_',num2str(ENS),'(i,j)=Rmse;']);
    end
end
%%CORDY WZZR
eval(['COR_DY_W_',num2str(ENS),'=rand(3,6);']);
eval(['RMSE_DY_W_',num2str(ENS),'=rand(3,6);']);
Ttest_W_6=zeros(3,6);
for i=1:3
    for j=1:6
        OA=squeeze(OAVE(i,j));
        A=squeeze(DELTA_O(i,j,2:46));
        O=squeeze(Obs(i,j,:));
        E=squeeze(Ensemble(i,j,:));
        S_O=std(O);
        S_E=std(E);
        for t=1:45
            P(t)=(E(t+1)-E(t))*S_O/S_E+O(t)-OA;
        end
        DELTA_W(i,j,:)=P;
        [r,p]=corrcoef(P,A);
        eval(['COR_DY_W_',num2str(ENS),'(i,j)=r(1,2);']);
        Rmse=RMSE(P,A,45);
        eval(['RMSE_DY_W_',num2str(ENS),'(i,j)=Rmse;']);
        Ttest_W_6(i,j)=p(1,2);
    end
end

eval(['COR_E_',num2str(ENS),'=rand(3,6);']);
eval(['RMSE_E_',num2str(ENS),'=rand(3,6);']);
Ttest_E_6=zeros(3,6);
for i=1:3
    for j=1:6
        A=squeeze(DELTA_O(i,j,2:46));
        B=squeeze(DELTA_E(i,j,2:46));
        [r,p]=corrcoef(A,B);
        eval(['COR_E_',num2str(ENS),'(i,j)=r(1,2);']);
        Rmse=RMSE(A,B,45);
        eval(['RMSE_E_',num2str(ENS),'(i,j)=Rmse;']);
        Ttest_E_6(i,j)=p(1,2);
    end
end
% 
% D_E=zeros(144*73,45);
% D_D=zeros(144*73,45);
% D_W=zeros(144*73,45);
% D_O=zeros(144*73,45);
% RMse_E=zeros(45,1);
% RMse_D=zeros(45,1);
% RMse_W=zeros(45,1);
% for t=1:45
%    
%         for i=1:73
%             for j=1:144
%   z=i*j;
%                 D_E(z,t)=DELTA_E(i,j,t+1);
%                  D_D(z,t)=DELTA_DY(i,j,t);
%                  D_W(z,t)=DELTA_W(i,j,t);
%                  D_O(z,t)=DELTA_O(i,j,t+1);
%             end
%         
%         end
%     RMse_E(t)=RMSE(D_E(:,t),D_O(:,t),144*73);
%     RMse_D(t)=RMSE(D_D(:,t),D_O(:,t),144*73);
%     RMse_W(t)=RMSE(D_W(:,t),D_O(:,t),144*73);
% end
% % end
% 
Anomly_E=squeeze(mean(mean(DELTA_E,1),2));
Anomly_W=squeeze(mean(mean(DELTA_W,1),2));
Anomly_O=squeeze(mean(mean(DELTA_O,1),2));
x=1:45;
Trend1dex_O=polyfit(26:39,Anomly_O(26:39)',1);
Trend1dex_W=polyfit(25:38,Anomly_W(25:38)',1);
Trend2dex_O=polyfit(39:46,Anomly_O(39:46)',1);
Trend2dex_W=polyfit(38:45,Anomly_W(38:45)',1);
Trend1_O=polyval(Trend1dex_O,26:39);
Trend1_W=polyval(Trend1dex_W,25:38);
Trend2_O=polyval(Trend2dex_O,39:46);
Trend2_W=polyval(Trend2dex_W,38:45);
plot(1:45,Anomly_O(2:46),1:45,Anomly_W);
hold on
plot(25:38,Trend1_O,'--o',25:38,Trend1_W,'--*');
hold on
plot(38:45,Trend2_O,38:45,Trend2_W);
legend;

