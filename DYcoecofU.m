%this program is for DY&YR
%ENSEMBLE Project   Observation: ECWMF ERA-40 Reanalysis

%Dataset
%time Ensemble 1960-2005/46   Obs 1958-2002/45  =》 1960-2002/43
clc;
clear all;
ncdisp('D:/data/Ensemble/131EnsembleJune.nc');
ncdisp('D:/data/Ensemble/V850.nc');

U_ENSEMBLE_JUNE=ncread('D:/data/Ensemble/131EnsembleJune.nc','u850');
U_ENSEMBLE_JULY=ncread('D:/data/Ensemble/131EnsembleJuly.nc','u850');
U_ENSEMBLE_APRIL=ncread('D:/data/Ensemble/131EnsembleApril.nc','u850');
V_ENSEMBLE_JUNE=ncread('D:/data/Ensemble/132EnsembleJune.nc','v850');
V_ENSEMBLE_JULY=ncread('D:/data/Ensemble/132EnsembleJuly.nc','v850');
V_ENSEMBLE_APRIL=ncread('D:/data/Ensemble/132EnsembleApril.nc','v850');
U_OBS=ncread('d:/data/Ensemble/U850.nc','u');
V_OBS=ncread('d:/data/Ensemble/V850.nc','v');

ENS=1;
   %参考时间平均
U_Ensemble_June=rand(73,144,43);%这是mean.mon 选取ref=05
U_Ensemble_June=U_ENSEMBLE_JUNE(:,:,1:43,ENS,2);
U_Ensemble_July=rand(73,144,43);
U_Ensemble_July=U_ENSEMBLE_JULY(:,:,1:43,ENS,2);
U_Ensemble_April=rand(73,144,43);
U_Ensemble_April=U_ENSEMBLE_APRIL(:,:,1:43,ENS,2);
V_Ensemble_June=rand(73,144,43);%这是mean.mon 选取ref=05
V_Ensemble_June=V_ENSEMBLE_JUNE(:,:,1:43,ENS,2);
V_Ensemble_July=rand(73,144,43);
V_Ensemble_July=V_ENSEMBLE_JULY(:,:,1:43,ENS,2);
V_Ensemble_April=rand(73,144,43);
V_Ensemble_April=V_ENSEMBLE_APRIL(:,:,1:43,ENS,2);
%季度平均
U_Ensemble_SUM=(U_Ensemble_June+U_Ensemble_July+U_Ensemble_April)/3;
V_Ensemble_SUM=(V_Ensemble_June+V_Ensemble_July+V_Ensemble_April)/3;
U_OBS_SUM=rand(73,144,43);
V_OBS_SUM=rand(73,144,43);
for i=3:45
    U_OBS_SUM(:,:,i-2)=flipud(rot90(squeeze((U_OBS(:,:,i)+U_OBS(:,:,i+1)+U_OBS(:,:,i+2))/3)));
    V_OBS_SUM(:,:,i-2)=flipud(rot90(squeeze((V_OBS(:,:,i)+V_OBS(:,:,i+1)+V_OBS(:,:,i+2))/3)));
end


%时间序列平均
U_AVE=mean(U_Ensemble_SUM,3);
U_OAVE=mean(U_OBS_SUM,3);
V_AVE=mean(V_Ensemble_SUM,3);
V_OAVE=mean(V_OBS_SUM,3);

%观测距平
UDELTA_O=rand(73,144,43);
UDELTA_E=rand(73,144,43);
for i=1:43
    UDELTA_O(:,:,i)=U_OBS_SUM(:,:,i)-U_OAVE;
    UDELTA_E(:,:,i)=U_Ensemble_SUM(:,:,i)-U_AVE;
    VDELTA_O(:,:,i)=V_OBS_SUM(:,:,i)-V_OAVE;
    VDELTA_E(:,:,i)=V_Ensemble_SUM(:,:,i)-V_AVE;
end

%验证公式
%RES=DELTA_E(:,:,2)-(DELTA_E(:,:,1)+(HG_Ensemble(:,:,2)-HG_Ensemble(:,:,1)));

%DY 1961-2002/42
UDELTA_DY=rand(73,144,42);
for i=2:43
    UDELTA_DY(:,:,i-1)=UDELTA_O(:,:,i-1)+(U_Ensemble_SUM(:,:,i)-U_Ensemble_SUM(:,:,i-1));
    VDELTA_DY(:,:,i-1)=VDELTA_O(:,:,i-1)+(V_Ensemble_SUM(:,:,i)-V_Ensemble_SUM(:,:,i-1));
end

%求各个格点的相关系数 DELTA_O&DELTA_DY
COR_UDY=rand(73,144);
for i=1:73
    for j=1:144
        A=UDELTA_O(i,j,2:43);
        B=UDELTA_DY(i,j,:);
        r=corrcoef(A,B);
        COR_UDY(i,j)=r(1,2);
    end
end

COR_UE=rand(73,144);
for i=1:73
    for j=1:144
        A=UDELTA_O(i,j,2:43);
        B=UDELTA_E(i,j,2:43);
        r=corrcoef(A,B);
        COR_UE(i,j)=r(1,2);
    end
end
CORT_E=coetime(UDELTA_E(:,:,2:43),UDELTA_O(:,:,2:43),42,73,144);
CORT_DY=coetime(UDELTA_DY,UDELTA_O(:,:,2:43),42,73,144);
% [EOF_DY,PC_DY,AVED]=eof(DELTA_DY,73,144,42,3);
% [EOF_E,PC_E,AVEE]=eof(DELTA_E(:,:,2:43),73,144,42,3);
% [EOF_O,PC_O,AVEO]=eof(DELTA_O,73,144,43,3);
figure(3)

%subplot(1,2,1)
[lon,lat]=meshgrid([0:2.5:357.5],[90:-2.5:-90]);
m_proj('miller','longitudes',[0 357.5], 'latitudes',[-90 90],'direction','vertical','aspect',2.5);
m_coast('color','k');
m_grid;
xlabel('Longtitude');
ylabel('Latitude');
title({'COECOF BETWEEN OBs & DY';' 1961-2002'},'FontSize',10)
hold on;
[cs,h]=m_contourf(lon,lat,COR_DY_1,'LineStyle','none');
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
title({'COECOF E&OBS';' 1961-2002'},'FontSize',10)
hold on;
m_contourf(lon,lat,COR_UE(:,:,1),'LineStyle','none');
% clabel(cs,h,'FontSize',8);
%print(1,'d:/fig/IMF','-dbitmap');
colorbar('southoutside');
  
figure(1)
[lon,lat]=meshgrid([0:2.5:357.5],[90:-2.5:-90]);
m_proj('miller','longitudes',[0 357.5], 'latitudes',[-90 90],'direction','vertical','aspect',2.5);
m_coast('color','k');
m_grid;
xlabel('Longtitude');
ylabel('Latitude');
title({'EOF_Obs ';' 1961-2002'},'FontSize',10)
hold on;

 [cs,h]=m_contourf(lon,lat,U_AVE,'LineWidth',1);
 clabel(cs,h,'FontSize',8);
 hold on;
d = 2;dd =2.5;
 m_quiver(lon(1:d:end,1:d:end),lat(1:d:end,1:d:end),U_AVE(1:d:end,1:d:end)./dd,V_AVE(1:d:end,1:d:end)./dd,0,'color','k');
 hold on
 h=m_quiver(30,-80,50./dd.*cosd(-80),0,0);
 set(h,'color','r','linewidth',1);
 hold on
 m_text(30,-75,'20m^2/s^2','fontsize',8);
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




[x,y]=meshgrid([-179.5:1:179.5],[89.5:-1:-89.5]);
[lon,lat]=meshgrid([-180:2.5:177.5],[90:-2.5:-90]);
c=interp2(x,y,b,lon,lat);

