COR_DELTA=COR_DY-COR_E;
[bx,by]=find(DELTA>0);
figure(3)
map1=map(1:5:55,:);
colormap(map1);
[lon,lat]=meshgrid([0:2.5:357.5],[90:-2.5:-90]);
m_proj('miller','longitudes',[0 357.5], 'latitudes',[-90 90],'direction','vertical','aspect',2.5);
m_coast('color','k');
m_grid;
xlabel('Longtitude');
ylabel('Latitude');
title({'Correlation Coefficients of Anomaly between Obs. and ECWMF';' 1961-2002'},'FontSize',10)
hold on;
 [cs,h]=m_contourf(lon,lat,(COR_DELTA),'LineStyle','none');
llat=-1*(bx*2.5-2.5)+90;
llon=by*2.5-2.5;
hold on;
m_scatter(llon,llat,1,'k');
color1=[-0.3:0.1:0.8];
clabel(cs,h,'FontSize',8);
colorbar('Ticks',color1);