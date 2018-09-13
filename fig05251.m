
colormap('gray');
subplot(2,2,1)
[lon,lat]=meshgrid([0:2.5:357.5],[90:-2.5:-90]);
m_proj('Equidistant','longitudes',[0 357.5], 'latitudes',[-90 90]);
m_coast('color','k');
m_grid('FontSize',6);
title('Obs 1981');
hold on;
% m_contourf(lon,lat,Obs(:,:,2)',10,'LineStyle','None');
% hold on;
[c,h]=m_contour(lon,lat,Obs(:,:,2)',5000:40:5800,'LineWidth',1,'LineColor','k');
clabel(c,h);
subplot(2,2,2);
[lon,lat]=meshgrid([0:2.5:357.5],[90:-2.5:-90]);
m_proj('Equidistant','longitudes',[0 357.5], 'latitudes',[-90 90]);
m_coast('color','k');
m_grid('FontSize',6);
title('DY 1981');
hold on;
% m_contourf(lon,lat,Ensemble(:,:,2)',0:1000:1000,'LineStyle','None');
% hold on;
[c,h]=m_contour(lon,lat,Ensemble(:,:,2)',5000:40:5800,'LineWidth',1,'LineColor','k');
clabel(c,h);
subplot(2,2,3);
[lon,lat]=meshgrid([0:2.5:357.5],[90:-2.5:-90]);
m_proj('Equidistant','longitudes',[0 357.5], 'latitudes',[-90 90]);
m_coast('color','k');
m_grid('FontSize',6);
title('WZZM 1981');
hold on;
m_contourf(lon,lat,',0:1000:1000,'LineStyle','None');
hold on;
[c,h]=m_contour(lon,lat,DELTA_W(:,:,1)',-100:20:100,'LineWidth',1,'LineColor','k');
clabel(c,h);