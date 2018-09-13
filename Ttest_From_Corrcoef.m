figure(1)

color1=[-0.4:0.1:0.9];
map=colormap('jet');
map1=map(9:4:57,:);
colormap(map1);
[lon,lat]=meshgrid([0:2.5:357.5],[90:-2.5:-90]);
m_proj('Equidistant','longitudes',[0 357.5], 'latitudes',[-90 90],'direction','vertical','aspect',2.5);
m_coast('color','k');
m_grid('FontSize',6);
title('UK  DY £¦Obs    ¡¤ represent corr-coef adopt 99% t-test','FontSize',6)
hold on;
m_contourf(lon,lat,(COR_DY_4),[-0.3:0.1:0.9],'LineStyle','none');
llat=-1*(t1x_1*2.5-2.5)+90;
llon=t1y_1*2.5-2.5;
hold on;
m_scatter(llon,llat,1,'k');
caxis([-0.4 0.9]);
colorbar('southoutside','Ticks',color1,'TickLabels',[-0.4:0.1:0.9],'FontSize',6);

print(1,'d:/fig/u850_UK_ref05DYForm_ttest','-dbitmap');

figure(2)
color1=[-0.4:0.1:0.9];
map=colormap('jet');
map1=map(9:4:57,:);
colormap(map1);
[lon,lat]=meshgrid([0:2.5:357.5],[90:-2.5:-90]);
m_proj('Equidistant','longitudes',[0 357.5], 'latitudes',[-90 90],'direction','vertical','aspect',2.5);
m_coast('color','k');
m_grid('FontSize',6);
title('UK  Ens&Obs   ¡¤ represent corr-coef adopt 99% t-test ','FontSize',6)
hold on;
m_contourf(lon,lat,(COR_E_4),[-0.3:0.1:0.9],'LineStyle','none');
llat=-1*(t2x_1*2.5-2.5)+90;
llon=t2y_1*2.5-2.5;
hold on;
m_scatter(llon,llat,1,'k');
caxis([-0.4 0.9]);
colorbar('southoutside','Ticks',color1,'TickLabels',[-0.4:0.1:0.9],'FontSize',6);

print(2,'d:/fig/u850_UK_ref05Ensemble_ttest','-dbitmap');