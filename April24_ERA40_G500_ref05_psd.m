%this program is for WZZM
%ENSEMBLE Project   Observation: ECWMF ERA-40 Reanalysis

%Dataset
%time Ensemble 1960-2005/46   Obs 1958-2002/45  =》 1960-2002/43
clc;
clear ;
ncdisp('D:/data/Ensemble/129EnsembleJune.nc');
ncdisp('D:/data/Ensemble/ERA40_G.nc');

ENSEMBLE_JUNE=ncread('D:/data/Ensemble/129EnsembleJune.nc','g500');
ENSEMBLE_JULY=ncread('D:/data/Ensemble/129EnsembleJuly.nc','g500');
ENSEMBLE_APRIL=ncread('D:/data/Ensemble/129EnsembleApril.nc','g500');
OBS=ncread('d:/data/Ensemble/ERA40_G.nc','z',[1 1 7],[144 73 129]);
lat=ncread('d:/data/Ensemble/ERA40_G.nc','latitude');
lon=ncread('d:/data/Ensemble/ERA40_G.nc','longitude');
   %参考时间平均
ref=2;
Ensemble_June=zeros(73,144,43,6);%这是mean.mon 选取ref=05
Ensemble_June=ENSEMBLE_JUNE(:,:,1:43,:,ref);
Ensemble_July=zeros(73,144,43,6);
Ensemble_July=ENSEMBLE_JULY(:,:,1:43,:,ref);
Ensemble_April=zeros(73,144,43,6);
Ensemble_April=ENSEMBLE_APRIL(:,:,1:43,:,ref);
%季度平均
Ensemble_SUM=(Ensemble_June+Ensemble_July+Ensemble_April)/3;
OBS_SUM=rand(73,144,43);
for i=1:43
    OBS_SUM(:,:,i)=flipud(rot90((OBS(:,:,i*3-2)+OBS(:,:,i*3-1)+OBS(:,:,i*3))/3));
end
 ENS=1;%重力位势to位势高度
    Ensemble=rand(73,144,43);
Obs=rand(73,144,43);
%选取
    for j=1:43
        Ensemble(:,:,j)=Ensemble_SUM(:,:,j,ENS)/9.8;
        Obs(:,:,j)=OBS_SUM(:,:,j)/9.8;
    end
%时间序列平均
AVE=mean(Ensemble,3);
OAVE=mean(Obs,3);
%观测距
DELTA_O=rand(73,144,43);
DELTA_E=rand(73,144,43);
for i=1:43
    DELTA_O(:,:,i)=Obs(:,:,i)-OAVE;
    DELTA_E(:,:,i)=Ensemble(:,:,i)-AVE;
end
DELTA_DY=rand(73,144,42);
for i=2:43
    DELTA_DY(:,:,i-1)=DELTA_O(:,:,i-1)+(Ensemble(:,:,i)-Ensemble(:,:,i-1));
end
DELTA_D=rand(73,144,42);
DELTA_D(:,:,:)=DELTA_DY;
delta=rand(73,144,42,4);
delta(:,:,1)=DELTA_WZZM;
delta(:,:,:,2)=DELTA_DY;
delta(:,:,:,3)=DELTA_E(:,:,2:43);
delta(:,:,:,4)=DELTA_O(:,:,2:43);
% 
% Wp = [9.5 10.5]/42;
% Ws = [9 11]/42;
% Rp = 1;
% Rs = 100;
% [n,Wn] = buttord(Wp,Ws,Rp,Rs);
% 
% [a,b]=butter(n,Wn,'bandpass');
kk=['delta_dy';'delta_e ';'delta_o '];
ncid2=netcdf.create('d:/data/Ensemble/ERA40.G500.ref05.nc','clobber');
        % Create NetCDF file,输入文件名.
lon=netcdf.defDim(ncid2,'longitude',144);%定义维
lat=netcdf.defDim(ncid2,'latitude',73);
time=netcdf.defDim(ncid2,'time',43);
kind=netcdf.defDim(ncid2,'kind',3);
len=netcdf.defDim(ncid2,'length',8);
Kind=netcdf.defVar(ncid2,'Kind','char',[kind len]);
Delta=netcdf.defVar(ncid2,'Delta','double',[lat lon time kind]);%定义变量
netcdf.endDef(ncid2);%关闭定义
netcdf.putVar(ncid2,Kind,kk);
netcdf.putVar(ncid2,Delta,delta);%填值
netcdf.close(ncid2);

COR_W=rand(73,144);
COR_10=rand(73,144);

for i=1:73
    for j=1:144
        OA=squeeze(OAVE(i,j));
        A=squeeze(DELTA_O(i,j,2:43));
        O=squeeze(Obs(i,j,:));
        E=squeeze(Ensemble(i,j,:));
        S_O=std(O);
        S_E=std(E);
        for t=1:42
            P(t)=(E(t+1)-E(t))*S_O/S_E+O(t)-OA;
        end
        r1=corrcoef(P,A);
        COR_W(i,j)=r1(1,2);
        X_10=filter(b,a,P);
        r2=corrcoef(X_10,A);
        COR_10(i,j)=r2(1,2);
    end
end

d=COR_10./COR_W;
figure(1)
[lon,lat]=meshgrid([0:2.5:357.5],[90:-2.5:-90]);
m_proj('miller','longitudes',[0 357.5], 'latitudes',[-90 90],'direction','vertical','aspect',2.5);
m_coast('color','k');
m_grid;
xlabel('Longtitude');
ylabel('Latitude');
hold on;
[cs,h]=m_contourf(lon,lat,d,'LineWidth',1);
clabel(cs,h,'FontSize',8);
        
        
%test 40-100E 0-20N Asia monsoon region
A=DELTA_DY(29:37,17:45,:);
m=round(42/3);
AA=squeeze(mean(mean(A,1),2));
r=cor_self(AA,0,m);
[px,tk]=psd_lianxu(AA,42,m);
k=0:m;
T=42./k;
plot(px);
set(gca,'xtick',k);
set(gca,'xticklabel',T);

%%低通滤波
windowSize=2;
b= (1/windowSize)*ones(1,windowSize);
cc=filter(b,1,AA);
q=(std(cc)/std(AA))^2*100
for i=1:42
    dd(i)=lowpass_Hf(5,AA(i))*AA(i);
end
AA(1);
t=1:42;
plot(t,AA,t,cc,t,dd)
x=[1:42];
plot(x,cc,x,AA,x,dd);
legend;

pxx=periodogram(AA);
figure(2)
plot(w,pxx)
periodogram(AA);

%%周期图功率谱估计
b=DELTA_O(29:37,17:45,2:43);
c=DELTA_E(29:37,17:45,2:43);
m=round(42/3);
bb=squeeze(mean(mean(b,1),2));
cc=squeeze(mean(mean(c,1),2));
[pxx1,f1,pxxc1] = periodogram(AA,[],[],1);
[pxx2,f2] = periodogram(bb,rectwin(42),[],1);
[pxx5,f5] = periodogram(cc,rectwin(42),[],1);
plot(f1,pxx1,f2,pxx2,f5,pxx5)
hold on;
plot(f1,h(:,4),'r-.',f1,h(:,1),'g-.')
%  plot(f1,pxxc1,'r-.')
xlabel('Cycles/Year')
ylabel('dB')
title('Periodogram of G500 in Asia Monsoom Region Mon.Aera.Mean')
FF=[0:0.05:0.5];
t=round(0.5./FF.*100)/100;
set(gca,'xticklabel',t);
set(gca,'Ylim',[0 2000])
legend('DY','Obs','Ens');
%%噪声检验
r=rhoAR1(AA)
rho=rwithenoise(AA)
[a,b,c,d,e,f,g,h,i,j]=RedConf(pxx1,f1,1,10,4);
[pxx,f] = periodogram(bb,[],[],1);
plot(f,pxx)
xlabel('Cycles/Year')
ylabel('dB')
title('Periodogram of Relative Sunspot Number Data')
dof = 42 - f1; 
signif = wave_signif(pxx1,1,f1)
[pxx3,pxxc3,f]=psd(AA)

plot(f,10*log10(pxx3))
t=round(1./[0:0.1:1].*100)./100
set(gca,'xticklabel',t)