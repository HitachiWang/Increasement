%this program is for test

%clear all;
clc;
ncdisp('D:/data/Ensemble/129EnsembleJune.nc');
ncdisp('D:/data/Ensemble/ERA40_G.nc');

G_ENSEMBLE_JUNE=ncread('D:/data/Ensemble/129EnsembleJune.nc','g500');
G_ENSEMBLE_JULY=ncread('D:/data/Ensemble/129EnsembleJuly.nc','g500');
G_ENSEMBLE_APRIL=ncread('D:/data/Ensemble/129EnsembleApril.nc','g500');

   %参考时间平均
G_Ensemble_June=rand(73,144,46,6);%这是mean.mon
G_Ensemble_June=mean(G_ENSEMBLE_JUNE,5);
G_Ensemble_July=rand(73,144,46,6);
G_Ensemble_July=mean(G_ENSEMBLE_JULY,5);
G_Ensemble_April=rand(73,144,46,6);
G_Ensemble_April=mean(G_ENSEMBLE_APRIL,5);
%季度平均
G_Ensemble_SUM=(G_Ensemble_June+G_Ensemble_July+G_Ensemble_April)/3;


%重力位势to位势高度
HG_Ensemble=rand(73,144,46,6);
HG_Ensemble_June=rand(73,144,46,6);
HG_Ensemble_July=rand(73,144,46,6);
HG_Ensemble_April=rand(73,144,46,6);
for i=1:6
    for j=1:46
        HG_Ensemble(:,:,j,i)=G_Ensemble_SUM(:,:,j,i)/9.8;
        HG_Ensemble_June(:,:,j,i)=G_Ensemble_June(:,:,j,i)/9.8;
        HG_Ensemble_July(:,:,j,i)=G_Ensemble_July(:,:,j,i)/9.8;
        HG_Ensemble_April(:,:,j,i)=G_Ensemble_April(:,:,j,i)/9.8;
    end
end
%时间序列平均
HG_AVE=mean(HG_Ensemble,3);
HG_AVE_June=mean(HG_Ensemble_June,3);
HG_AVE_July=mean(HG_Ensemble_July,3);
HG_AVE_April=mean(HG_Ensemble_April,3);


%求距平
HG_DELTA=rand(73,144,46,6);
for i=1:46
    HG_DELTA(:,:,i,:)=HG_Ensemble(:,:,i,:)-HG_AVE;
end

%距平平均
HG_DELTA_AVE=mean(HG_DELTA,3);

%EOF
%标准化
HG_AVE=squeeze(HG_AVE);
HG_DELTA_AVE=squeeze(HG_DELTA_AVE);
HG_STD=zeros(73,144,46);
HG_STD=HG_DELTA(:,:,:,1); %ECWMF

    x=zeros(73*144,46);
   for k=1:46
    c=1;
         for i=1:73
             for j=1:144
            x(c,k)=HG_STD(i,j,k);
            c=c+1;
             end
         end
   end
    s=x'*x;
    [vq,dq]=eig(s);
    vq=fliplr(vq);
    dq=rot90(dq,2);
    lambda=diag(dq);
    [d,idx] = sort(diag(dq),'descend'); %排序
    vq = vq(:,idx); 
    for i=1:46
        vq(:,i)=vq(:,i)/sqrt(d(i));
    end
    v=x*vq;
    t=v'*x;
    HG_SUM=zeros(73,144,3);
    a=zeros(73,144,3);
    g=zeros(3);
    for k=1:3
    count=1;
    for i=1:73
        for j=1:144
            HG_SUM(i,j,k)=v(count,k);
            count=count+1;
        end
    end
    g(k)=d(k)/sum(d);
    end

HG_EOF=zeros(73,144,3);
for i=1:3
    HG_EOF(:,:,i)=HG_SUM(:,:,i)+HG_AVE(:,:,1);
end

%清除过程变量
clear G_Ensemble_June G_Ensemble_July G_Ensemble_April;
clear G_ENSEMBLE_JUNE G_ENSEMBLE_JULY G_ENSEMBLE_APRIL

for k=1:3
    
figure(k)
[lon,lat]=meshgrid([0:2.5:357.5],[-90:2.5:90]);
m_proj('miller','longitudes',[0 357.5], 'latitudes',[-90 90],'direction','vertical','aspect',2.5);
m_coast;
m_grid;
hold on;
[cs,h]=m_contour(lon,lat,HG_STD(:,:,k));
clabel(cs,h);
title(['500hpa HG',' ','EOF',num2str(k),'  ',num2str(g(k)*100),'%'],'fontsize',12,'fontweight','b');
end

year=1960:1:2005;
for k=4:6
    figure(k)
    bar(year,t(k,:),'k');
    xlim([min(year),max(year)]);
    xlabel('Year','fontsize',12,'fontweight','b');
    ylabel(['PC',num2str(k)],'fontsize',12,'fontweight','b');
    title(['500hpa HG',' ','PC',num2str(k)],'fontsize',12,'fontweight','b');
    
end