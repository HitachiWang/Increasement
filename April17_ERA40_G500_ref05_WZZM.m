%this program is for WZZM
%ENSEMBLE Project   Observation: ECWMF ERA-40 Reanalysis

%Dataset
%time Ensemble 1960-2005/46   Obs 1958-2002/45  =》 1960-2002/43
clc;
clear ;
ncdisp('D:/data/Ensemble/129EnsembleJune.nc');
ncdisp('D:/data/Ensemble/ERA40_G.nc');

ENSEMBLE_JUNE=ncread('D:/data/Ensemble/129EnsembleJune.nc','g500');
ENSEMBLE_JULY=ncread('D:/data/Ensemble/129EnsembleJuly.nc','g500');
ENSEMBLE_APRIL=ncread('D:/data/Ensemble/129EnsembleApril.nc','g500');
OBS=ncread('d:/data/Ensemble/ERA40_G.nc','z',[1 1 7],[144 73 129]);
% lat=ncread('d:/data/Ensemble/ERA40_G.nc','lat');
% lon=ncread('d:/data/Ensemble/ERA40_G.nc','lon');
   %参考时间平均
ref=2;
Ensemble_June=zeros(73,144,43,6);%这是mean.mon 选取ref=05
Ensemble_June=ENSEMBLE_JUNE(:,:,1:43,:,ref);
Ensemble_July=zeros(73,144,43,6);
Ensemble_July=ENSEMBLE_JULY(:,:,1:43,:,ref);
Ensemble_April=zeros(73,144,43,6);
Ensemble_April=ENSEMBLE_APRIL(:,:,1:43,:,ref);
%季度平均
Ensemble_SUM=(Ensemble_June+Ensemble_July+Ensemble_April)/3;
OBS_SUM=rand(73,144,43);
for i=1:43
    OBS_SUM(:,:,i)=flipud(rot90((OBS(:,:,i*3-2)+OBS(:,:,i*3-1)+OBS(:,:,i*3))/3));
end
for ENS=1:6%重力位势to位势高度
    Ensemble=rand(73,144,43);
Obs=rand(73,144,43);
%选取
    for j=1:43
        Ensemble(:,:,j)=Ensemble_SUM(:,:,j,ENS)/9.8;
        Obs(:,:,j)=OBS_SUM(:,:,j)/9.8;
    end
%时间序列平均
AVE=mean(Ensemble,3);
OAVE=mean(Obs,3);
%观测距
DELTA_O=rand(73,144,43);
DELTA_E=rand(73,144,43);
for i=1:43
    DELTA_O(:,:,i)=Obs(:,:,i)-OAVE;
    DELTA_E(:,:,i)=Ensemble(:,:,i)-AVE;
end
DELTA_DY=rand(73,144,42);
for i=2:43
    DELTA_DY(:,:,i-1)=DELTA_O(:,:,i-1)+(Ensemble(:,:,i)-Ensemble(:,:,i-1));
end
DELTA_W=zeros(73,144,42);
S_O=zeros(73,144);
S_E=zeros(73,144);
for i=1:73
    for j=1:144
        OA=squeeze(OAVE(i,j));
        A=squeeze(DELTA_O(i,j,2:43));
        O=squeeze(Obs(i,j,:));
        E=squeeze(Ensemble(i,j,:));
        S_O(i,j)=std(O);
        S_E(i,j)=std(E);
        for t=1:42
            P(t)=(E(t+1)-E(t)).*(S_O(i,j)/S_E(i,j))+O(t)-OA;
        end
        DELTA_W(i,j,:)=P;
    end
end
eval(['COR_DY_W_',num2str(ENS),'=rand(73,144);']);
eval(['Ttest_DY_W_',num2str(ENS),'=rand(73,144);']);
for i=1:73
    for j=1:144
        OA=squeeze(OAVE(i,j));
        A=squeeze(DELTA_O(i,j,2:43));
        O=squeeze(Obs(i,j,:));
        E=squeeze(Ensemble(i,j,:));
        S_O=std(O);
        S_E=std(E);
        for t=1:42
            P(t)=(E(t+1)-E(t))*S_O/S_E+O(t)-OA;
        end
        [r,p]=corrcoef(P,A);
        eval(['COR_DY_W_',num2str(ENS),'(i,j)=r(1,2);']);
        eval(['Ttest_DY_W_',num2str(ENS),'(i,j)=p(1,2);']);
    end
end
eval(['COR_DY_',num2str(ENS),'=rand(73,144);']);
eval(['Ttest_DY_',num2str(ENS),'=rand(73,144);']);

for i=1:73
    for j=1:144
        A=squeeze(DELTA_O(i,j,2:43));
        B=squeeze(DELTA_DY(i,j,:));
        [r,p]=corrcoef(A,B);
        eval(['COR_DY_',num2str(ENS),'(i,j)=r(1,2);']);
        eval(['Ttest_DY_',num2str(ENS),'(i,j)=p(1,2);']);
    end
end
eval(['COR_E_',num2str(ENS),'=rand(73,144);']);
eval(['Ttest_E_',num2str(ENS),'=rand(73,144);']);

for i=1:73
    for j=1:144
        A=squeeze(DELTA_O(i,j,2:43));
        B=squeeze(DELTA_E(i,j,2:43));
        [r,p]=corrcoef(A,B);
        eval(['COR_E_',num2str(ENS),'(i,j)=r(1,2);']);
        eval(['Ttest_E_',num2str(ENS),'(i,j)=p(1,2);']);
    end
end

eval(['[t1x_',num2str(ENS),',t1y_',num2str(ENS),']','=find(Ttest_DY_',num2str(ENS),'<0.01);']);
eval(['[t2x_',num2str(ENS),',t2y_',num2str(ENS),']','=find(Ttest_E_',num2str(ENS),'<0.01);']);

end
