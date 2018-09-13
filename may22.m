%this program is for WZZM
%ENSEMBLE Project   Observation: ECWMF NCEP Reanalysis1

%Dataset
%time Ensemble 1960-2005/46   Obs 1948-2017/69  =》 1960-2005/46
clc;
clear ;
ncdisp('D:/data/Ensemble/129EnsembleJune.nc');
ncdisp('D:/data/Ensemble/hgt.mon.mean.nc');

ncdisp('D:/data/Ensemble/129.ref11.DJF.nc');
ncdisp('D:/data/Ensemble/hgt.mon.mean.nc');

G=squeeze(ncread('d:/data/Ensemble/129.ref11.DJF.nc','G11DJF',[1 1 3 1 1],[144 73 1 46 5])); 
OBS=squeeze(ncread('d:/data/Ensemble/hgt.mon.mean.nc','hgt',[1 1 10 145],[144 73 1 47*12]));
lat=ncread('d:/data/Ensemble/hgt.mon.mean.nc','lat');
lon=ncread('d:/data/Ensemble/hgt.mon.mean.nc','lon');
level=ncread('d:/data/Ensemble/hgt.mon.mean.nc','level');
   %参考时间平均

Obs=rand(144,73,46);
for i=1:46
    Obs(:,:,i)=(OBS(:,:,i*12)+OBS(:,:,i*12+1)+OBS(:,:,i*12+2))/3;
end
% for ENS=1:5%重力位势to位势高度
    ENS=1;
Ensemble=rand(144,73,46);

%选取
    for j=1:46
        Ensemble(:,:,j)=G(:,:,j,ENS)/9.8;
    end
%时间序列平均
AVE=mean(Ensemble,3);
OAVE=mean(Obs,3);
%观测距
DELTA_O=rand(144,73,46);
DELTA_E=rand(144,73,46);
for i=1:46
    DELTA_O(:,:,i)=Obs(:,:,i)-OAVE;
    DELTA_E(:,:,i)=Ensemble(:,:,i)-AVE;
end
DELTA_DY=rand(144,73,45);
for i=2:46
    DELTA_DY(:,:,i-1)=DELTA_O(:,:,i-1)+(Ensemble(:,:,i)-Ensemble(:,:,i-1));
end
eval(['COR_DY_',num2str(ENS),'=rand(144,73);']);
eval(['Ttest_DY_',num2str(ENS),'=rand(144,73);']);
for i=1:144
    for j=1:73
        A=squeeze(DELTA_O(i,j,2:46));
        B=squeeze(DELTA_DY(i,j,:));
        [r,p]=corrcoef(A,B);
        eval(['COR_DY_',num2str(ENS),'(i,j)=r(1,2);']);
        eval(['Ttest_DY_',num2str(ENS),'(i,j)=p(1,2);']);
    end
end
%%CORDY WZZR
eval(['COR_DY_W_',num2str(ENS),'=rand(144,73);']);
eval(['Ttest_DY_W_',num2str(ENS),'=rand(144,73);']);
for i=1:144
    for j=1:73
        OA=squeeze(OAVE(i,j));
        A=squeeze(DELTA_O(i,j,2:46));
        O=squeeze(Obs(i,j,:));
        E=squeeze(Ensemble(i,j,:));
        S_O=std(O);
        S_E=std(E);
        for t=1:45
            P(t)=(E(t+1)-E(t))*S_O/S_E+O(t)-OA;
        end
        [r,p]=corrcoef(P,A);
        eval(['COR_DY_W_',num2str(ENS),'(i,j)=r(1,2);']);
        eval(['Ttest_DY_W_',num2str(ENS),'(i,j)=p(1,2);']);
    end
end

eval(['COR_E_',num2str(ENS),'=rand(144,73);']);
eval(['Ttest_E_',num2str(ENS),'=rand(144,73);']);
for i=1:144
    for j=1:73
        A=squeeze(DELTA_O(i,j,2:46));
        B=squeeze(DELTA_E(i,j,2:46));
        [r,p]=corrcoef(A,B);
        eval(['COR_E_',num2str(ENS),'(i,j)=r(1,2);']);
        eval(['Ttest_E_',num2str(ENS),'(i,j)=p(1,2);']);
    end
end

eval(['[t1x_',num2str(ENS),',t1y_',num2str(ENS),']','=find(Ttest_DY_',num2str(ENS),'<0.01);']);
eval(['[t2x_',num2str(ENS),',t2y_',num2str(ENS),']','=find(Ttest_E_',num2str(ENS),'<0.01);']);

% end
