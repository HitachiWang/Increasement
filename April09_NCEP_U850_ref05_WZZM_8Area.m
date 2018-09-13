%this program is for WZZM
%ENSEMBLE Project   Observation: ECWMF NCEP Reanalysis1

%Dataset
%time Ensemble 1960-2005/46   Obs 1948-2017/69  =》 1960-2005/46
clc;
clear ;
ncdisp('D:/data/Ensemble/131EnsembleJune.nc');
ncdisp('D:/data/Ensemble/uwnd.mon.mean.nc');

ENSEMBLE_JUNE=ncread('D:/data/Ensemble/131EnsembleJune.nc','u850');
ENSEMBLE_JULY=ncread('D:/data/Ensemble/131EnsembleJuly.nc','u850');
ENSEMBLE_APRIL=ncread('D:/data/Ensemble/131EnsembleApril.nc','u850');
OBS=squeeze(ncread('d:/data/Ensemble/uwnd.mon.mean.nc','uwnd',[1 1 3 145],[144 73 1 46*12]));
lat=ncread('d:/data/Ensemble/uwnd.mon.mean.nc','lat');
lon=ncread('d:/data/Ensemble/uwnd.mon.mean.nc','lon');
level=ncread('d:/data/Ensemble/uwnd.mon.mean.nc','level');
   %参考时间平均
ref=2;
Ensemble_June=zeros(73,144,46,6);%这是mean.mon 选取ref=05
Ensemble_June=ENSEMBLE_JUNE(:,:,1:46,:,ref);
Ensemble_July=zeros(73,144,46,6);
Ensemble_July=ENSEMBLE_JULY(:,:,1:46,:,ref);
Ensemble_April=zeros(73,144,46,6);
Ensemble_April=ENSEMBLE_APRIL(:,:,1:46,:,ref);
%季度平均
Ensemble_SUM=(Ensemble_June+Ensemble_July+Ensemble_April)/3;
OBS_SUM=rand(73,144,46);
for i=1:46
    OBS_SUM(:,:,i)=flipud(rot90((OBS(:,:,i*12-6)+OBS(:,:,i*12-5)+OBS(:,:,i*12-4))/3));
end
AeraCOR_WDY=zeros(8,6);
AeraCOR_DY=zeros(8,6);
AeraCOR_E=zeros(8,6);
for AERA=1:2
% for ENS=1:6%重力位势to位势高度    
ENS=6;
Ensemble=rand(73,144,46);
Obs=rand(73,144,46);
%选取
    for j=1:46
        Ensemble(:,:,j)=Ensemble_SUM(:,:,j,ENS)/9.8;
        Obs(:,:,j)=OBS_SUM(:,:,j);
    end
%时间序列平均
AVE=mean(Ensemble,3);
OAVE=mean(Obs,3);
%观测距
DELTA_O=rand(73,144,46);
DELTA_E=rand(73,144,46);
for i=1:46
    DELTA_O(:,:,i)=Obs(:,:,i)-OAVE;
    DELTA_E(:,:,i)=Ensemble(:,:,i)-AVE;
end
DELTA_DY=rand(73,144,45);
for i=2:46
    DELTA_DY(:,:,i-1)=DELTA_O(:,:,i-1)+(Ensemble(:,:,i)-Ensemble(:,:,i-1));
end
NLAT=[9,9,9,9,9,9,9,13];
NLON=[25,25,7,13,37,25,37,13];
LAT={33:41;33:41;21:29;45:53;33:41;33:41;65:73;17:29};
LON={49:73;85:109;45:51;51:61;85:109;49:73;73:109;17:29};


 

R=NLAT(AERA);
C=NLON(AERA);
eval(['COR_DY_',num2str(ENS),'=rand(R,C);']);
eval(['Ttest_DY_',num2str(ENS),'=rand(R,C);']);
x=1;
for i=cell2mat(LAT(AERA))
    y=1;
    for j=cell2mat(LON(AERA))
        A=squeeze(DELTA_O(i,j,2:46));
        B=squeeze(DELTA_DY(i,j,:));
        [r,p]=corrcoef(A,B);
        eval(['COR_DY_',num2str(ENS),'(x,y)=r(1,2);']);
        eval(['Ttest_DY_',num2str(ENS),'(x,y)=p(1,2);']);
        y=y+1;
    end
    x=x+1;
end
%%CORDY WZZR
eval(['COR_DY_W_',num2str(ENS),'=rand(R,C);']);
eval(['Ttest_DY_W_',num2str(ENS),'=rand(R,C);']);
x=1;
for i=cell2mat(LAT(AERA))
    y=1;
    for j=cell2mat(LON(AERA))
        OA=squeeze(OAVE(x,y));
        A=squeeze(DELTA_O(i,j,2:46));
        O=squeeze(Obs(i,j,:));
        E=squeeze(Ensemble(i,j,:));
        S_O=std(O);
        S_E=std(E);
        for t=1:45
            P(t)=(E(t+1)-E(t))*S_O/S_E+O(t)-OA;
        end
        [r,p]=corrcoef(P,A);
        eval(['COR_DY_W_',num2str(ENS),'(x,y)=r(1,2);']);
        eval(['Ttest_DY_W_',num2str(ENS),'(x,y)=p(1,2);']);
        y=y+1;
    end
    x=x+1;
end

eval(['COR_E_',num2str(ENS),'=rand(R,C);']);
eval(['Ttest_E_',num2str(ENS),'=rand(R,C);']);
x=1;
for i=cell2mat(LAT(AERA))
    y=1;
    for j=cell2mat(LON(AERA))
        A=squeeze(DELTA_O(i,j,2:46));
        B=squeeze(DELTA_E(i,j,2:46));
        [r,p]=corrcoef(A,B);
        eval(['COR_E_',num2str(ENS),'(x,y)=r(1,2);']);
        eval(['Ttest_E_',num2str(ENS),'(x,y)=p(1,2);']);
        y=y+1;
    end
    x=x+1;
end

eval(['[t1x_',num2str(ENS),',t1y_',num2str(ENS),']','=find(Ttest_DY_',num2str(ENS),'<0.01);']);
eval(['[t2x_',num2str(ENS),',t2y_',num2str(ENS),']','=find(Ttest_E_',num2str(ENS),'<0.01);']);
eval(['AeraCOR_WDY(AERA,ENS)=squeeze(mean(mean(COR_DY_W_',num2str(ENS),',2),1));']);
eval(['AeraCOR_DY(AERA,ENS)=squeeze(mean(mean(COR_DY_',num2str(ENS),',2),1));']);
eval(['AeraCOR_E(AERA,ENS)=squeeze(mean(mean(COR_E_',num2str(ENS),',2),1));']);
% eval(['clear COR_DY_W_',num2str(ENS)]);
% eval(['clear COR_DY_',num2str(ENS)]);
% eval(['clear COR_E_',num2str(ENS)]);
% clear R C
end

end