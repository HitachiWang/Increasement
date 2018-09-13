figure(1)
subplot(2,2,1);
color1=[-0.5:0.1:0.5];
map=colormap('jet');
map2=map(10:5:55,:);
colormap(map2);
x=10:-2.5:-10;
y=[850 500 200 100 50];
y1=[50 100 200 500 850];
x1={'North','10��N','7.5��N','5��N','2.5��N','Equator','2.5��S','5��S','7.5��S','10��S'};
grid on;
hold on;
contourf(x,y,COR1_W'-COR1_E',color1,'LineStyle','none');
% xlim([1 9]);
ylim([0 1000]);

set(gca,'xTicklabel',x1);
set(gca,'yTick',y1,'yTicklabel',y1);
set(gca,'ydir','reverse');
set(gca,'xdir','reverse');
hold on;
% caxis([-0.5,0.5]);
% colorbar('southoutside','Ticks',[-0.5:0.1:0.5],'TickLabels',[-0.5:0.1:0.5],'FontSize',6);
set(gca,'Fontname','Times New Roman','FontSize',10);
subplot(2,2,2);
% color1=[-0.5:0.1:0.5];
% map=colormap('jet');
% map2=map(10:5:55,:);
% colormap(map2);
x=10:-2.5:-10;
y=[850 500 200 100 50];
y1=[50 100 200 500 850];
x1={'North','10��N','7.5��N','5��N','2.5��N','Equator','2.5��S','5��S','7.5��S','10��S'};
grid on;
hold on;
contourf(x,y,COR2_W'-COR2_E',color1,'LineStyle','none');
% xlim([1 9]);
ylim([0 1000]);

set(gca,'xTicklabel',x1);
set(gca,'yTick',y1,'yTicklabel',y1);
set(gca,'ydir','reverse');
set(gca,'xdir','reverse');
hold on;
% caxis([-0.5,0.5]);
% colorbar('southoutside','Ticks',[-0.5:0.1:0.5],'TickLabels',[-0.5:0.1:0.5],'FontSize',6);
set(gca,'Fontname','Times New Roman','FontSize',10);
caxis([-0.5 0.5]);
hBar2=colorbar('eastoutside','Ticks',color1,'TickLabels',[-0.5:0.1:0.5],'FontSize',10);
set(hBar2,'Position',[0.95,0.6,0.02,0.3]);
subplot(2,2,3);
color2=[0.0:0.1:0.7];
map2=map3(2:1:9,:);
colormap(map2);
x=10:-2.5:-10;
y=[850 500 200 100 50];
y1=[50 100 200 500 850];
x1={'North','10��N','7.5��N','5��N','2.5��N','Equator','2.5��S','5��S','7.5��S','10��S'};
grid on;
hold on;
contourf(x,y,VarCon1_8',color2,'LineStyle','none');
% xlim([1 9]);
ylim([0 1000]);

set(gca,'xTicklabel',x1);
set(gca,'yTick',y1,'yTicklabel',y1);
set(gca,'ydir','reverse');
set(gca,'xdir','reverse');
hold on;
% caxis([-0.5,0.5]);
% colorbar('southoutside','Ticks',[-0.5:0.1:0.5],'TickLabels',[-0.5:0.1:0.5],'FontSize',6);
set(gca,'Fontname','Times New Roman','FontSize',10);
subplot(2,2,4);
% color1=[-0.5:0.1:0.5];
% map=colormap('jet');
% map2=map(10:5:55,:);
% colormap(map2);
x=10:-2.5:-10;
y=[850 500 200 100 50];
y1=[50 100 200 500 850];
x1={'North','10��N','7.5��N','5��N','2.5��N','Equator','2.5��S','5��S','7.5��S','10��S'};
grid on;
hold on;
contourf(x,y,VarCon2_8',color2,'LineStyle','none');
% xlim([1 9]);
ylim([0 1000]);

set(gca,'xTicklabel',x1);
set(gca,'yTick',y1,'yTicklabel',y1);
set(gca,'ydir','reverse');
set(gca,'xdir','reverse');
hold on;
% caxis([-0.5,0.5]);
% colorbar('southoutside','Ticks',[-0.5:0.1:0.5],'TickLabels',[-0.5:0.1:0.5],'FontSize',6);
set(gca,'Fontname','Times New Roman','FontSize',10);
caxis([0 0.7]);
hBar1=colorbar('eastoutside','Ticks',color2,'TickLabels',[0.0:0.1:0.7],'FontSize',10);
set(hBar1,'Position',[0.95,0.1,0.02,0.3]);
set(gca,'Fontname','Times New Roman','FontSize',10);