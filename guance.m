%this program is for 处理观测数据

clear all;
clc;

ncdisp('D:/data/Ensemble/hgt.mon.mean.nc');
hg=ncread('D:/data/Ensemble/hgt.mon.mean.nc','hgt');
filename='D:/data/Ensemble/hgt.mon.mean.nc';
level=ncread(filename,'level');
HG_O_1=rand(144,73,27);
%time start 197901
for i=6:12:324
    HG_O_1(:,:,((i+6)/12))=hg(:,:,6,i);
end
HG_O=rand(73,144,27);
for i=1:27
    HG_O(:,:,i)=flipud(rot90(HG_O_1(:,:,i)));
end
HG_O_AVE=mean(HG_O(:,:,1:27),3);

%jupingpingjun
HG_O_DELTA=rand(73,144,27);
for i=1:27
    HG_O_DELTA(:,:,i)=HG_O(:,:,i)-HG_O_AVE;
end
HG_O_DELTA_AVE=mean(HG_O_DELTA(:,:,1:25),3);

figure(1)
[lon,lat]=meshgrid([0:2.5:357.5],[-90:2.5:90]);
m_proj('miller','longitudes',[0 357.5], 'latitudes',[-90 90],'direction','vertical','aspect',2.5);
m_coast;
m_grid;
hold on;
[cs,h]=m_contourf(lon,lat,HG_O_DELTA_AVE);
clabel(cs,h);
colorbar;
