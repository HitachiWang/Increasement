%time Ensemble 1960-2005/46   Obs 1958-2002/45  =¡· 1960-2002/43
clc;
clear ;
ncdisp('D:/data/Ensemble/hgt.mon.mean.nc');
OBS=squeeze(ncread('d:/data/Ensemble/uwnd.mon.mean.nc','uwnd',[1 1 3 145],[144 73 1 46*12]));
lat=ncread('d:/data/Ensemble/hgt.mon.mean.nc','lat');
lon=ncread('d:/data/Ensemble/hgt.mon.mean.nc','lon');

OBS_SUM=rand(73,144,46);
for i=1:46
    OBS_SUM(:,:,i)=flipud(rot90((OBS(:,:,i*12-6)+OBS(:,:,i*12-5)+OBS(:,:,i*12-4))/3));
end
Obs=OBS_SUM;
% for i=1:46
% Obs(:,:,i)=OBS(:,:,i)';
% end
OAVE=mean(Obs,3);
DELTA_O=rand(73,144,43);
for i=1:43
    DELTA_O(:,:,i)=Obs(:,:,i)-OAVE;
end
Obs_Long8=zeros(73,144,43);
VarCon_8=zeros(73,144);
[b,a]=butter(1,1/10,'low');
for i=1:73
    for j=1:144
        datax=squeeze(DELTA_O(i,j,:));
        Obs_Long8(i,j,:)=filter(b,a,datax);
        var1=var(DELTA_O(i,j,2:42));
        var2=var(Obs_Long8(i,j,2:42));
        VarCon_8(i,j)=var2/var1;
    end
end

%% ÖÜÆÚ
RedConf_E=rand(129,2);
DELTA_E_GlobalAve=mean(mean(DELTA_O(:,:,:),1),2);
datax=DELTA_E_GlobalAve;
datax=squeeze(datax);
[pxx1,f1] = periodogram(datax,[],[],1);
PXX_E_GlobalAve=pxx1;
r=rhoAR1(datax);
[~,~,~,~,~,~,~,tabtchi,~,~]=RedConf(pxx1,f1,1,1000,4);
RedConf_E_GlobalAve(:,1)=tabtchi(:,3)./100; % 95%
RedConf_E_GlobalAve(:,2)=tabtchi(:,4)./100;  % 99%
figure(2)
plot(f1,PXX_E_GlobalAve);
hold on;
plot(f1,RedConf_E_GlobalAve(:,1),'r-.',f1,RedConf_E_GlobalAve(:,2),'g-.')
xlabel('Cycles/Year')
ylabel('dB')
title('Periodogram of G500 Global.Mean')
FF=[1/46 1/30 1/25 1/10 1/8 1/6 1/5 1/4 1/2];
t=round(0.5./FF.*100)/100*2;
set(gca,'xtick',FF);
set(gca,'xticklabel',t);


%% »­Í¼
figure(1)
color1=[0:0.1:0.8];
map=colormap('jet');
map1=map(22:5:57,:);
colormap(map1);
[lon,lat]=meshgrid([0:2.5:357.5],[90:-2.5:-90]);
m_proj('Equidistant','longitudes',[0 357.5], 'latitudes',[-90 90]);
m_coast('color','k');
m_grid('FontSize',6);

hold on;
m_contourf(lon,lat,VarCon_8,color1,'LineStyle','none');
caxis([0 0.8]);
hBar=colorbar('southoutside','Ticks',[0:0.1:0.8],'TickLabels',[0:0.1:0.8],'FontSize',6);
set(gca, 'Fontname', 'Times New Roman', 'Fontsize', 10);
print(1,'d:/fig/4.bmp','-dbitmap');