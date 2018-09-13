
figure(1)
color1=[0:0.1:1].*100;
map=colormap('jet');
map1=map(9:6:63,:);
colormap(map1);
[lon,lat]=meshgrid([0:2.5:357.5],[90:-2.5:-90]);
m_proj('Equidistant','longitudes',[0 357.5], 'latitudes',[-90 90]);
m_coast('color','k');
m_grid('FontSize',6);
title('Variance Conribution >2year in E Form','FontSize',6);
hold on;
m_contourf(lon,lat,(VC.*100),10,'LineStyle','none');
caxis([0 100]);
colorbar('southoutside','Ticks',color1,'TickLabels',[0:10:100],'FontSize',6);
print(1,'d:/fig/Variance Contribution more than 2yr in E Form','-dbitmap');

figure(2)
color1=[0:0.1:1].*100;
map=colormap('jet');
map1=map(9:6:63,:);
colormap(map1);
[lon,lat]=meshgrid([0:2.5:357.5],[90:-2.5:-90]);
m_proj('Equidistant','longitudes',[0 357.5], 'latitudes',[-90 90]);
m_coast('color','k');
m_grid('FontSize',6);
title('Variance Conribution <2yr in E Form','FontSize',6);
hold on;
m_contourf(lon,lat,(100-ButterVarCon_E(:,:,1)),color1,'LineStyle','none');
caxis([0 100]);
colorbar('southoutside','Ticks',color1,'TickLabels',[0:10:100],'FontSize',6);
print(2,'d:/fig/Variance Contribution less than 2yr in E Form','-dbitmap');

figure(3)
color1=[0:0.1:1].*100;
map=colormap('jet');
map1=map(9:6:63,:);
colormap(map1);
[lon,lat]=meshgrid([0:2.5:357.5],[90:-2.5:-90]);
m_proj('Equidistant','longitudes',[0 357.5], 'latitudes',[-90 90]);
m_coast('color','k');
m_grid('FontSize',6);
title('Variance Conribution Band 2yr-10yr in E Form','FontSize',6);
hold on;
m_contourf(lon,lat,(ButterVarCon_E(:,:,3)),color1,'LineStyle','none');
caxis([0 100]);
colorbar('southoutside','Ticks',color1,'TickLabels',[0:10:100],'FontSize',6);
print(3,'d:/fig/Variance Contribution 2ye-10ye in E Form','-dbitmap');

figure(4)
color1=[0:0.1:1].*100;
map=colormap('jet');
map1=map(9:6:63,:);
colormap(map1);
[lon,lat]=meshgrid([0:2.5:357.5],[90:-2.5:-90]);
m_proj('Equidistant','longitudes',[0 357.5], 'latitudes',[-90 90]);
m_coast('color','k');
m_grid('FontSize',6);
title('Variance Conribution >2year in WZZM Form','FontSize',6);
hold on;
m_contourf(lon,lat,(ButterVarCon_WZZM(:,:,1)),10,'LineStyle','none');
caxis([0 100]);
colorbar('southoutside','Ticks',color1,'TickLabels',[0:10:100],'FontSize',6);
print(4,'d:/fig/Variance Contribution more than 2yr in WZZM Form','-dbitmap');

figure(5)
color1=[0:0.1:1].*100;
map=colormap('jet');
map1=map(9:6:63,:);
colormap(map1);
[lon,lat]=meshgrid([0:2.5:357.5],[90:-2.5:-90]);
m_proj('Equidistant','longitudes',[0 357.5], 'latitudes',[-90 90]);
m_coast('color','k');
m_grid('FontSize',6);
title('Variance Conribution <2yr in WZZM Form','FontSize',6);
hold on;
m_contourf(lon,lat,(100-ButterVarCon_WZZM(:,:,1)),color1,'LineStyle','none');
caxis([0 100]);
colorbar('southoutside','Ticks',color1,'TickLabels',[0:10:100],'FontSize',6);
print(5,'d:/fig/Variance Contribution less than 2yr in WZZM Form','-dbitmap');

figure(6)
color1=[0:0.1:1].*100;
map=colormap('jet');
map1=map(9:6:63,:);
colormap(map1);
[lon,lat]=meshgrid([0:2.5:357.5],[90:-2.5:-90]);
m_proj('Equidistant','longitudes',[0 357.5], 'latitudes',[-90 90]);
m_coast('color','k');
m_grid('FontSize',6);
title('Variance Conribution Band 2yr-10yr in WZZM Form','FontSize',6);
hold on;
m_contourf(lon,lat,(ButterVarCon_WZZM(:,:,3)),color1,'LineStyle','none');
caxis([0 100]);
colorbar('southoutside','Ticks',color1,'TickLabels',[0:10:100],'FontSize',6);
print(6,'d:/fig/Variance Contribution 2ye-10ye in WZZM Form','-dbitmap');

figure(7)
color1=[0:0.1:1].*100;
map=colormap('jet');
map1=map(9:6:63,:);
colormap(map1);
[lon,lat]=meshgrid([0:2.5:357.5],[90:-2.5:-90]);
m_proj('Equidistant','longitudes',[0 357.5], 'latitudes',[-90 90]);
m_coast('color','k');
m_grid('FontSize',6);
title('Variance Conribution >2year in DY Form','FontSize',6);
hold on;
m_contourf(lon,lat,(ButterVarCon_DY(:,:,1)),10,'LineStyle','none');
caxis([0 100]);
colorbar('southoutside','Ticks',color1,'TickLabels',[0:10:100],'FontSize',6);
print(7,'d:/fig/Variance Contribution more than 2yr in DY Form','-dbitmap');

figure(8)
color1=[0:0.1:1].*100;
map=colormap('jet');
map1=map(9:6:63,:);
colormap(map1);
[lon,lat]=meshgrid([0:2.5:357.5],[90:-2.5:-90]);
m_proj('Equidistant','longitudes',[0 357.5], 'latitudes',[-90 90]);
m_coast('color','k');
m_grid('FontSize',6);
title('Variance Conribution <2yr in DY Form','FontSize',6);
hold on;
m_contourf(lon,lat,(100-ButterVarCon_DY(:,:,1)),color1,'LineStyle','none');
caxis([0 100]);
colorbar('southoutside','Ticks',color1,'TickLabels',[0:10:100],'FontSize',6);
print(8,'d:/fig/Variance Contribution less than 2yr in DY Form','-dbitmap');

figure(9)
color1=[0:0.1:1].*100;
map=colormap('jet');
map1=map(9:6:63,:);
colormap(map1);
[lon,lat]=meshgrid([0:2.5:357.5],[90:-2.5:-90]);
m_proj('Equidistant','longitudes',[0 357.5], 'latitudes',[-90 90]);
m_coast('color','k');
m_grid('FontSize',6);
title('Variance Conribution Band 2yr-10yr in DY Form','FontSize',6);
hold on;
m_contourf(lon,lat,(ButterVarCon_DY(:,:,3)),color1,'LineStyle','none');
caxis([0 100]);
colorbar('southoutside','Ticks',color1,'TickLabels',[0:10:100],'FontSize',6);
print(9,'d:/fig/Variance Contribution 2ye-10ye in DY Form','-dbitmap');

figure(10)
color1=[0:0.1:1].*100;
map=colormap('jet');
map1=map(9:6:63,:);
colormap(map1);
[lon,lat]=meshgrid([0:2.5:357.5],[90:-2.5:-90]);
m_proj('Equidistant','longitudes',[0 357.5], 'latitudes',[-90 90]);
m_coast('color','k');
m_grid('FontSize',6);
title('Variance Conribution >2year in O Form','FontSize',6);
hold on;
m_contourf(lon,lat,(ButterVarCon_O(:,:,1)),10,'LineStyle','none');
caxis([0 100]);
colorbar('southoutside','Ticks',color1,'TickLabels',[0:10:100],'FontSize',6);
print(10,'d:/fig/Variance Contribution more than 2yr in O Form','-dbitmap');

figure(11)
color1=[0:0.1:1].*100;
map=colormap('jet');
map1=map(9:6:63,:);
colormap(map1);
[lon,lat]=meshgrid([0:2.5:357.5],[90:-2.5:-90]);
m_proj('Equidistant','longitudes',[0 357.5], 'latitudes',[-90 90]);
m_coast('color','k');
m_grid('FontSize',6);
title('Variance Conribution <2yr in O Form','FontSize',6);
hold on;
m_contourf(lon,lat,(100-ButterVarCon_O(:,:,1)),color1,'LineStyle','none');
caxis([0 100]);
colorbar('southoutside','Ticks',color1,'TickLabels',[0:10:100],'FontSize',6);
print(11,'d:/fig/Variance Contribution less than 2yr in O Form','-dbitmap');

figure(12)
color1=[0:0.1:1].*100;
map=colormap('jet');
map1=map(9:6:63,:);
colormap(map1);
[lon,lat]=meshgrid([0:2.5:357.5],[90:-2.5:-90]);
m_proj('Equidistant','longitudes',[0 357.5], 'latitudes',[-90 90]);
m_coast('color','k');
m_grid('FontSize',6);
title('Variance Conribution Band 2yr-10yr in O Form','FontSize',6);
hold on;
m_contourf(lon,lat,(ButterVarCon_O(:,:,3)),color1,'LineStyle','none');
caxis([0 100]);
colorbar('southoutside','Ticks',color1,'TickLabels',[0:10:100],'FontSize',6);
print(12,'d:/fig/Variance Contribution 2ye-10ye in O Form','-dbitmap');