figure(1)
color1=[-0.5:0.1:1.0];
map=colormap('jet');
map1=map(8:4:64,:);
colormap(map1);
[lon,lat]=meshgrid([0:2.5:357.5],[90:-2.5:-90]);
m_proj('Equidistant','longitudes',[0 357.5], 'latitudes',[-90 90]);
m_coast('color','k');
m_grid('FontSize',6);
% title('COR.WZZM');
hold on;
m_contourf(lon,lat,COR_DY_W_5',color1,'LineStyle','none');
hold on;
m_contour(lon,lat,COR_DY_W_5',0:0.0000001:0.0000001,'LineWidth',1,'LineColor','k');
hold on;
caxis([-0.5 1.0]);
hBar=colorbar('southoutside','Ticks',color1,'TickLabels',[-0.5:0.1:1.0],'FontSize',6);
print(1,'d:/fig/1.bmp','-dbitmap');

% figure(2)
% color1=[-0.5:0.1:1.0];
% map=colormap('jet');
% map1=map(8:4:64,:);
% colormap(map1);
% [lon,lat]=meshgrid([0:2.5:357.5],[90:-2.5:-90]);
% m_proj('Equidistant','longitudes',[0 357.5], 'latitudes',[-90 90]);
% m_coast('color','k');
% m_grid('FontSize',6);
% title('COR.DY');
% hold on;
% m_contourf(lon,lat,COR_DY_5,color1,'LineStyle','none');
% hold on;
% m_contour(lon,lat,COR_DY_5,0:1:1,'LineWidth',1,'LineColor','k');
% hold on;
% caxis([-0.5 1.0]);
% hBar=colorbar('southoutside','Ticks',color1,'TickLabels',[-0.5:0.1:1.0],'FontSize',6);
% print(2,'d:/fig/May15.NCEP.U850.JJA.ref05.CORDY.1961-2005.IMF.bmp','-dbitmap');

figure(3)
color1=[-0.5:0.1:1.0];
map=colormap('jet');
map1=map(8:4:64,:);
colormap(map1);
[lon,lat]=meshgrid([0:2.5:357.5],[90:-2.5:-90]);
m_proj('Equidistant','longitudes',[0 357.5], 'latitudes',[-90 90]);
m_coast('color','k');
m_grid('FontSize',6);
% title('COR.E');
hold on;
m_contourf(lon,lat,COR_E_5',color1,'LineStyle','none');
hold on;
m_contour(lon,lat,Ttest_E_5',0:0.01:0.01,'LineWidth',1,'LineColor','k');
hold on;
caxis([-0.5 1.0]);
colorbar('southoutside','Ticks',color1,'TickLabels',[-0.5:0.1:1.0],'FontSize',6);
print(3,'d:/fig/2.bmp','-dbitmap');

% figure(4)
% color2=(-0.5:0.1:0.5);
% map=colormap('jet');
% map2=map(10:5:55,:);
% colormap(map2);
% [lon,lat]=meshgrid([0:2.5:357.5],[90:-2.5:-90]);
% m_proj('Equidistant','longitudes',[0 357.5], 'latitudes',[-90 90]);
% m_coast('color','k');
% m_grid('FontSize',6);
% title('COR.WZZM-COR.DY');
% m_contourf(lon,lat,(COR_DY_W_5-COR_DY_5),color2,'LineStyle','none');
% hold on;
% m_contour(lon,lat,(COR_DY_W_5-COR_DY_5),0:1:1,'LineWidth',1,'LineColor','k');
% hold on;
% caxis([-0.5,0.5]);
% colorbar('southoutside','Ticks',[-0.5:0.1:0.5],'TickLabels',[-0.5:0.1:0.5],'FontSize',6);
% print(4,'d:/fig/3.bmp','-dbitmap');

% figure(5)
% color2=(-0.5:0.1:0.5);
% map=colormap('jet');
% map2=map(10:5:55,:);
% colormap(map2);
% [lon,lat]=meshgrid([0:2.5:357.5],[90:-2.5:-90]);
% m_proj('Equidistant','longitudes',[0 357.5], 'latitudes',[-90 90]);
% m_coast('color','k');
% m_grid('FontSize',6);
% title('COR.DY-COR.E');
% hold on;
% m_contourf(lon,lat,(COR_DY_5-COR_E_5),'LineStyle','none');
% caxis([-0.5,0.5]);
% colorbar('southoutside','Ticks',[-0.5:0.1:0.5],'TickLabels',[-0.5:0.1:0.5],'FontSize',6);
% print(5,'d:/fig/May15.NCEP.U850.JJA.ref05.CORDY-CORE.1961-2005.IMF.bmp','-dbitmap');
% 
figure(6)
color2=(-0.5:0.1:0.5);
map=colormap('jet');
map2=map(10:5:55,:);
colormap(map2);
[lon,lat]=meshgrid([0:2.5:357.5],[90:-2.5:-90]);
m_proj('Equidistant','longitudes',[0 357.5], 'latitudes',[-90 90]);
m_coast('color','k');
m_grid('FontSize',6);
% title('COR.WZZM-COR.E');
hold on;
m_contourf(lon,lat,(COR_DY_W_5-COR_E_5)',color2,'LineStyle','none');
m_contour(lon,lat,(COR_DY_W_5-COR_E_5)',0:100:100,'LineWidth',1,'LineColor','k');
hold on;
caxis([-0.5,0.5]);
colorbar('southoutside','Ticks',[-0.5:0.1:0.5],'TickLabels',[-0.5:0.1:0.5],'FontSize',6);
print(6,'d:/fig/3.bmp','-dbitmap');