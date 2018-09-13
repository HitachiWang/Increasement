%this program is for prlr  unit m s-1

clear all;

ncdisp('d:/data/Ensemble/228EnsembleJune.nc');
ncdisp('d:/data/Ensemble/ECWMF_Obs_water.nc');
ncdisp('d:/data/Ensemble/pr_wtr.mon.mean.nc'); %time start 1948/1

%计算模式数据中的降水量 单位 ms-1-->mm*day-1   wtr=prlr*t(sec*min*hour*m->mm)
PRLR_06=ncread('d:/data/Ensemble/228EnsembleJune.nc','prlr');
PRLR_07=ncread('d:/data/Ensemble/228EnsembleJuly.nc','prlr');
PRLR_08=ncread('d:/data/Ensemble/228EnsembleApril.nc','prlr');
PRLR_June=mean(PRLR_06,5);
PRLR_July=mean(PRLR_07,5);
PRLR_April=mean(PRLR_08,5);

PR_June=rand(73,144,46,6);
for i=1:6
    for j=1:46
        PR_June(:,:,j,i)=PRLR_June(:,:,j,i)*86400000;
    end
end
PR_July=rand(73,144,46,6);
for i=1:6
    for j=1:46
        PR_July(:,:,j,i)=PRLR_July(:,:,j,i)*86400000;
    end
end
PR_April=rand(73,144,46,6);
for i=1:6
    for j=1:46
        PR_April(:,:,j,i)=PRLR_April(:,:,j,i)*86400000;
    end
end

%OBS for ECWMF
TCW_Obs=ncread('d:/data/Ensemble/ECWMF_Obs_water.nc','tcw');
TCW_Lat=ncread('d:/data/Ensemble/ECWMF_Obs_water.nc','latitude');
TCW_Lon=ncread('d:/data/Ensemble/ECWMF_Obs_water.nc','longitude');

%kg*m-2->mm/day  tcw/rou/day
TCW_June=rand(73,144,46);
for i=181:3:318
    TCW_June(:,:,(i-178)/3)=(flipud(rot90(TCW_Obs(:,:,i))))/1000/30;
end

%OBS for NCEP R1

figure(2)
[lon,lat]=meshgrid([0:2.5:357.5],[-90:2.5:90]);
m_proj('miller','longitudes',[0 357.5], 'latitudes',[-90 90],'direction','vertical','aspect',2.5);
m_coast('color','k');
m_grid;
hold on;
[cs,h]=m_contour(lon,lat,TCW_June(:,:,1));
clabel(cs,h);
colorbar;
