%this program is for DY&YR
%ENSEMBLE Project   Observation: ECWMF ERA-40 Reanalysis

%Dataset
%time Ensemble 1960-2005/46   Obs 1958-2002/45  =》 1960-2002/43
% clc;
% clear ;
ncdisp('D:/data/Ensemble/129EnsembleJune.nc');
ncdisp('D:/data/Ensemble/ERA40_G.nc');

G_ENSEMBLE_JUNE=ncread('D:/data/Ensemble/129EnsembleJune.nc','g500');
G_ENSEMBLE_JULY=ncread('D:/data/Ensemble/129EnsembleJuly.nc','g500');
G_ENSEMBLE_APRIL=ncread('D:/data/Ensemble/129EnsembleApril.nc','g500');
G_OBS=ncread('d:/data/Ensemble/ERA40_G.nc','z',[1 1 7],[144 73 129]);
G_lat=ncread('d:/data/Ensemble/ERA40_G.nc','latitude');
G_lon=ncread('d:/data/Ensemble/ERA40_G.nc','longitude');
   %参考时间平均
G_Ensemble_June=rand(73,144,43,6);%这是mean.mon 选取ref=05
G_Ensemble_June=G_ENSEMBLE_JUNE(:,:,1:43,:,2);
G_Ensemble_July=rand(73,144,43,6);
G_Ensemble_July=G_ENSEMBLE_JULY(:,:,1:43,:,2);
G_Ensemble_April=rand(73,144,43,6);
G_Ensemble_April=G_ENSEMBLE_APRIL(:,:,1:43,:,2);
%季度平均
G_Ensemble_SUM=(G_Ensemble_June+G_Ensemble_July+G_Ensemble_April)/3;
G_OBS_SUM=rand(73,144,43);
for i=1:43
    G_OBS_SUM(:,:,i)=flipud(rot90((G_OBS(:,:,i*3-2)+G_OBS(:,:,i*3-1)+G_OBS(:,:,i*3))/3));
end

%重力位势to位势高度
HG_Ensemble=rand(73,144,43);
HG_Ensemble_June=rand(73,144,43);
HG_Ensemble_July=rand(73,144,43);
HG_Ensemble_April=rand(73,144,43);
HG_Obs=rand(73,144,43);
ENS=1;%选取
    for j=1:43
        HG_Ensemble(:,:,j)=G_Ensemble_SUM(:,:,j,ENS)/9.8;
        HG_Ensemble_June(:,:,j)=G_Ensemble_June(:,:,j,ENS)/9.8;
        HG_Ensemble_July(:,:,j)=G_Ensemble_July(:,:,j,ENS)/9.8;
        HG_Ensemble_April(:,:,j)=G_Ensemble_April(:,:,j,ENS)/9.8;
        HG_Obs(:,:,j)=G_OBS_SUM(:,:,j)/9.8;
    end

%时间序列平均
HG_AVE=mean(HG_Ensemble,3);
HG_OAVE=mean(HG_Obs,3);

%观测距平
HDELTA_O=rand(73,144,43);
HDELTA_E=rand(73,144,43);
for i=1:43
    HDELTA_O(:,:,i)=HG_Obs(:,:,i)-HG_OAVE;
    HDELTA_E(:,:,i)=HG_Ensemble(:,:,i)-HG_AVE;
end

%验证公式
%RES=DELTA_E(:,:,2)-(DELTA_E(:,:,1)+(HG_Ensemble(:,:,2)-HG_Ensemble(:,:,1)));

%DY 1961-2002/42
HDELTA_DY=rand(73,144,42);
for i=2:43
    HDELTA_DY(:,:,i-1)=HDELTA_O(:,:,i-1)+(HG_Ensemble(:,:,i)-HG_Ensemble(:,:,i-1));
end

%求各个格点的相关系数 DELTA_O&DELTA_DY
COR_DY=rand(73,144);
COR1_DY=rand(73,144);
Ttest_DY=rand(73,144);
for i=1:73
    for j=1:144
        A=squeeze(HDELTA_O(i,j,2:43));
        B=squeeze(HDELTA_DY(i,j,:));
        [r,p]=corrcoef(A,B);
        r1=xiangguan(A,B,42);
        COR_DY(i,j)=r(1,2);
        COR1_DY(i,j)=r1;
        Ttest_DY(i,j)=p(1,2);
    end
end

COR_E=rand(73,144);
COR1_E=rand(73,144);
Ttest_E=rand(73,144);
for i=1:73
    for j=1:144
        A=squeeze(HDELTA_O(i,j,2:43));
        B=squeeze(HDELTA_E(i,j,2:43));
        [r,p]=corrcoef(A,B);
        r1=xiangguan(A,B,42);
        COR_E(i,j)=r(1,2);
        COR1_E(i,j)=r1;
        Ttest_E(i,j)=p(1,2);
    end
end

[t1x,t1y]=find(Ttest_DY<0.01);
[t2x,t2y]=find(Ttest_E<0.01);
% CORT_E=coetime(DELTA_E(:,:,2:43),DELTA_O(:,:,2:43),42,73,144);
% CORT_DY=coetime(DELTA_DY,DELTA_O(:,:,2:43),42,73,144);
% x=[1961:2002];
% figure(1)
% p=plot(x',CORT_E(:,1),'r',x',CORT_DY(:,1),'b');
% p(2).LineWidth=3;
% axis([1961 2002 -100 100]);
% grid on;
% title('Correlation Coefficients of Anomaly between Obs. and DY-Form in ecwmf Timeline','FontSize',10);
% legend('ENS&Obs','DY&Obs');
% % 
% [EOF_DY,PC_DY,GD]=eof(DELTA_DY,73,144,42,3);
% [EOF_E,PC_E,GE]=eof(DELTA_E(:,:,2:43),73,144,42,3);
% [EOF_O,PC_O,GO]=eof(DELTA_O,73,144,43,3);
% figure(3)
% subplot(1,2,1)
% [lon,lat]=meshgrid([0:2.5:357.5],[90:-2.5:-90]);
% m_proj('miller','longitudes',[0 357.5], 'latitudes',[-90 90],'direction','vertical','aspect',2.5);
% m_coast('color','k');
% m_grid;
% xlabel('Longtitude');
% ylabel('Latitude');
% title({'Correlation Coefficients of Anomaly between Obs. and DY-Form in CMCC';' 1961-2002'},'FontSize',10)
% hold on;
% [cs,h]=m_contourf(lon,lat,(COR_DY),[-0.9:0.1:0.8],'LineWidth',1);
% clabel(cs,h,'FontSize',8);
% subplot(1,2,2)
% [lon,lat]=meshgrid([0:2.5:357.5],[90:-2.5:-90]);
% m_proj('miller','longitudes',[0 357.5], 'latitudes',[-90 90],'direction','vertical','aspect',2.5);
% m_coast('color','k');
% m_grid;
% xlabel('Longtitude');
% ylabel('Latitude');
% title({'Correlation Coefficients of Anomaly between Obs. and CMCC';' 1961-2002'},'FontSize',10)
% hold on;
% [cs,h]=m_contourf(lon,lat,(COR_E),[-0.9:0.1:0.8],'LineWidth',1);
% clabel(cs,h,'FontSize',8);
% %print(1,'d:/fig/IMF','-dbitmap');
% 
% 
figure(2)
map=colormap('jet');
map1=map(1:5:55,:);
colormap(map1);
[lon,lat]=meshgrid([0:2.5:357.5],[90:-2.5:-90]);
m_proj('Equidistant','longitudes',[0 357.5], 'latitudes',[-90 90],'direction','vertical','aspect',2.5);
m_coast('color','k');
m_grid;
xlabel('Longtitude');
ylabel('Latitude');
title({'Correlation Coefficients of Anomaly between Obs. and ECWMF';' 1961-2002'},'FontSize',10)
hold on;
 [cs,h]=m_contourf(lon,lat,(COR_E),[-0.3:0.1:0.8],'LineStyle','none');
llat=-1*(t2x*2.5-2.5)+90;
llon=t2y*2.5-2.5;
hold on;
m_scatter(llon,llat,1,'k');
color1=[-0.3:0.1:0.8];
clabel(cs,h,'FontSize',8);
colorbar('Ticks',color1);
% figure(1)
% map1=map(1:5:55,:);
% colormap(map1);
% [lon,lat]=meshgrid([0:2.5:357.5],[90:-2.5:-90]);
% m_proj('miller','longitudes',[0 357.5], 'latitudes',[-90 90],'direction','vertical','aspect',2.5);
% m_coast('color','k');
% m_grid;
% xlabel('Longtitude');
% ylabel('Latitude');
% title({'Correlation Coefficients of Anomaly between Obs. and DY-Form';' 1961-2002'},'FontSize',10)
% hold on;
%  [cs,h]=m_contourf(lon,lat,(COR_DY),[-0.3:0.1:0.8],'LineStyle','none');
% llat=-1*(t1x*2.5-2.5)+90;
% llon=t1y*2.5-2.5;
% hold on;
% m_scatter(llon,llat,1,'k');
% color1=[-0.3:0.1:0.8];
% clabel(cs,h,'FontSize',8);
% colorbar('Ticks',color1);
% 
% 
% 
% % figure(4)
% % subplot(1,3,1)
% % [lon,lat]=meshgrid([0:2.5:357.5],[90:-2.5:-90]);
% % m_proj('miller','longitudes',[0 357.5], 'latitudes',[-90 90],'direction','vertical','aspect',2.5);
% % m_coast('color','k');
% % m_grid;
% % xlabel('Longtitude');
% % ylabel('Latitude');
% % title({'EOF of DY-Form in CMCC';num2str(GD(1,1));' 1961-2002'},'FontSize',10)
% % hold on;
% % [cs,h]=m_contourf(lon,lat,(EOF_DY(:,:,1)),'LineWidth',1);
% % clabel(cs,h,'FontSize',8);
% % subplot(1,3,2)
% % [lon,lat]=meshgrid([0:2.5:357.5],[90:-2.5:-90]);
% % m_proj('miller','longitudes',[0 357.5], 'latitudes',[-90 90],'direction','vertical','aspect',2.5);
% % m_coast('color','k');
% % m_grid;
% % xlabel('Longtitude');
% % ylabel('Latitude');
% % title({'EOF of CMCC';num2str(GE(1,1));' 1961-2002'},'FontSize',10)
% % hold on;
% % [cs,h]=m_contourf(lon,lat,(EOF_E(:,:,1)),'LineWidth',1);
% % clabel(cs,h,'FontSize',8);
% % subplot(1,3,3)
% % [lon,lat]=meshgrid([0:2.5:357.5],[90:-2.5:-90]);
% % m_proj('miller','longitudes',[0 357.5], 'latitudes',[-90 90],'direction','vertical','aspect',2.5);
% % m_coast('color','k');
% % m_grid;
% % xlabel('Longtitude');
% % ylabel('Latitude');
% % title({'EOF of  Obs';num2str(GO(1,1));' 1961-2002'},'FontSize',10)
% % hold on;
% % [cs,h]=m_contourf(lon,lat,((EOF_O(:,:,1))),'LineWidth',1);
% % clabel(cs,h,'FontSize',8);
% % % DELTA_O(1,1,1)