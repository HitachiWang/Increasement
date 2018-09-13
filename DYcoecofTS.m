%this program is for DY&YR
%ENSEMBLE Project   Observation: ECWMF ERA-40 Reanalysis

%Dataset
%time Ensemble 1960-2005/46   Obs 1958-2002/45  =》 1960-2002/43
clc;
clear all;
ncdisp('D:/data/Ensemble/139EnsembleJunc.nc');
ncdisp('D:/data/Ensemble/ECWMF_Obs_TS.nc');

TS_ENSEMBLE_JUNE=ncread('D:/data/Ensemble/139EnsembleJune.nc','ts');
TS_ENSEMBLE_JULY=ncread('D:/data/Ensemble/139EnsembleJuly.nc','ts');
TS_ENSEMBLE_APRIL=ncread('D:/data/Ensemble/139EnsembleApril.nc','ts');
TS_OBS=ncread('d:/data/Ensemble/eCWMF_Obs_TS.nc','t2m');

ENS=1;%选取
   %参考时间平均
TS_Ensemble_June=rand(73,144,43);%这是mean.mon 选取ref=05
TS_Ensemble_June=TS_ENSEMBLE_JUNE(:,:,1:43,ENS,2);
TS_Ensemble_July=rand(73,144,43);
TS_Ensemble_July=TS_ENSEMBLE_JULY(:,:,1:43,ENS,2);
TS_Ensemble_April=rand(73,144,43);
TS_Ensemble_April=TS_ENSEMBLE_APRIL(:,:,1:43,ENS,2);
%季度平均
TS_Ensemble_SUM=(TS_Ensemble_June+TS_Ensemble_July+TS_Ensemble_April)/3;
TS_OBS_SUM=rand(73,144,43);
for i=3:45
    TS_OBS_SUM(:,:,i-2)=flipud(rot90((TS_OBS(:,:,i)+TS_OBS(:,:,i+1)+TS_OBS(:,:,i+2))/3));
end

%时间序列平均
TS_AVE=mean(TS_Ensemble_SUM,3);
TS_OAVE=mean(TS_OBS_SUM,3);

%观测距平
DELTA_O=rand(73,144,43);
DELTA_E=rand(73,144,43);
for i=1:43
    DELTA_O(:,:,i)=TS_OBS_SUM(:,:,i)-TS_OAVE;
    DELTA_E(:,:,i)=TS_Ensemble_SUM(:,:,i)-TS_AVE;
end

%验证公式
%RES=DELTA_E(:,:,2)-(DELTA_E(:,:,1)+(HG_Ensemble(:,:,2)-HG_Ensemble(:,:,1)));

%DY 1961-2002/42
DELTA_DY=rand(73,144,42);
for i=2:43
    DELTA_DY(:,:,i-1)=DELTA_O(:,:,i-1)+(TS_Ensemble_SUM(:,:,i)-TS_Ensemble_SUM(:,:,i-1));
end

%求各个格点的相关系数 DELTA_O&DELTA_DY
COR_DY=rand(73,144);
for i=1:73
    for j=1:144
        A=DELTA_O(i,j,2:43);
        B=DELTA_DY(i,j,:);
        r=corrcoef(A,B);
        COR_DY(i,j)=r(1,2);
    end
end

COR_E=rand(73,144);
for i=1:73
    for j=1:144
        A=DELTA_O(i,j,2:43);
        B=DELTA_E(i,j,2:43);
        r=corrcoef(A,B);
        COR_E(i,j)=r(1,2);
    end
end
% 
%[EOF_DY,PC_DY,AVED]=eof(DELTA_DY,73,144,42,3);
% [EOF_E,PC_E,AVEE]=eof(DELTA_E(:,:,2:43),73,144,42,3);
 [EOF_O,PC_O,AVEO]=eof(TS_OBS_SUM,73,144,43,3);
 CORT_E=coetime(DELTA_E(:,:,2:43),DELTA_O(:,:,2:43),42,73,144);
CORT_DY=coetime(DELTA_DY,DELTA_O(:,:,2:43),42,73,144);
figure(3)

%subplot(1,2,1)
[lon,lat]=meshgrid([0:2.5:357.5],[90:-2.5:-90]);
m_proj('miller','longitudes',[0 357.5], 'latitudes',[-90 90],'direction','vertical','aspect',2.5);
m_coast('color','k');
m_grid;
xlabel('Longtitude');
ylabel('Latitude');
title({'COECOF DY&O';' 1961-2002'},'FontSize',10)
hold on;

[cs,h]=m_contourf(lon,lat,COR_DY,'LineStyle','none');
clabel(cs,h,'FontSize',8);
colorbar('southoutside');
%subplot(1,2,2)
figure(2)
[lon,lat]=meshgrid([0:2.5:357.5],[90:-2.5:-90]);
m_proj('miller','longitudes',[0 357.5], 'latitudes',[-90 90],'direction','vertical','aspect',2.5);
m_coast('color','k');
m_grid;
xlabel('Longtitude');
ylabel('Latitude');
title({'COECOF E&O ';' 1961-2002'},'FontSize',10)
hold on;
[cs,h]=m_contourf(lon,lat,COR_E,'LineStyle','none');
clabel(cs,h,'FontSize',8);
%print(1,'d:/fig/IMF','-dbitmap');
colorbar('southoutside');
%}   
figure(1)
[lon,lat]=meshgrid([0:2.5:357.5],[90:-2.5:-90]);
m_proj('miller','longitudes',[0 357.5], 'latitudes',[-90 90],'direction','vertical','aspect',2.5);
m_coast('color','k');
m_grid;
xlabel('Longtitude');
ylabel('Latitude');
title({'EOF_Obs ';' 1961-2002'},'FontSize',10)
hold on;
[cs,h]=m_contourf(lon,lat,DELTA_O(:,:,28),'LineWidth',1);
clabel(cs,h,'FontSize',8);
%print(1,'d:/fig/IMF','-dbitmap');
colorbar('southoutside');

x=[1961:2002];
figure(4)
p=plot(x',CORT_E(:,1),'r',x',CORT_DY(:,1),'b');
p(2).LineWidth=3;
axis([1961 2002 -100 100]);
grid on;
title('Correlation Coefficients of Anomaly between Obs. and DY-Form in ecwmf Timeline','FontSize',10);
legend('ENS&Obs','DY&Obs');