%this program is for WZZM
%ENSEMBLE Project   Observation: ECWMF NCEP Reanalysis1

%Dataset
%time Ensemble 1960-2005/46   Obs 1948-2017/69  =》 1960-2005/46
clc;
clear ;
ncdisp('D:/data/Ensemble/129.ref11.DJF.nc');
ncdisp('D:/data/Ensemble/hgt.mon.mean.nc');
OBS1=zeros(25,9,5,47*12);
OBS2=zeros(25,9,5,47*12);
k=[3 6 10 12 14];
G1=squeeze(ncread('d:/data/Ensemble/131.ref11.DJF.nc','U',[49 33 1 1 1],[25 9 5 46 5])); 
G2=squeeze(ncread('d:/data/Ensemble/131.ref11.DJF.nc','U',[85 33 1 1 1],[25 9 5 46 5])); 
for i=1:5
OBS1(:,:,i,:)=squeeze(ncread('d:/data/Ensemble/uwnd.mon.mean.nc','uwnd',[49 33 k(i) 145],[25 9 1 47*12]));
end
for i=1:5
OBS2(:,:,i,:)=squeeze(ncread('d:/data/Ensemble/uwnd.mon.mean.nc','uwnd',[85 33 k(i) 145],[25 9 1 47*12]));
end
OBS1=squeeze(mean(OBS1,1));
OBS2=squeeze(mean(OBS2,1));
lat=ncread('d:/data/Ensemble/hgt.mon.mean.nc','lat');
lon=ncread('d:/data/Ensemble/hgt.mon.mean.nc','lon');
level=ncread('d:/data/Ensemble/hgt.mon.mean.nc','level');
time=ncread('d:/data/Ensemble/hgt.mon.mean.nc','time');
   %参考时间平均
%季度平均
Obs1=rand(9,5,46);
Obs2=zeros(9,5,46);
Ens1=squeeze(mean(G1,1));
Ens2=squeeze(mean(G2,1));
for i=1:46
     Obs1(:,:,i)=((OBS1(:,:,i*12-6)+OBS1(:,:,i*12-5)+OBS1(:,:,i*12-4))/3);
     Obs2(:,:,i)=((OBS2(:,:,i*12-6)+OBS2(:,:,i*12-5)+OBS2(:,:,i*12-4))/3);
end

%  for ENS=1:5
% % 时间序列平均
% ENS=1;
Ensemble1=zeros(9,5,46);
% Ensemble=Ens(:,:,:,1);
for ENS=1:5
    Ensemble1=Ensemble1+Ens1(:,:,:,ENS);
end
Ensemble1=Ensemble1./5;
Ensemble2=zeros(9,5,46);
% Ensemble=Ens(:,:,:,1);
for ENS=1:5
    Ensemble2=Ensemble2+Ens2(:,:,:,ENS);
end
Ensemble2=Ensemble2./5;
% Ensemble=Ens(:,:,:,ENS);
AVE1=mean(Ensemble1(:,:,1:46),3);
OAVE1=mean(Obs1(:,:,1:46),3);
AVE2=mean(Ensemble2(:,:,1:46),3);
OAVE2=mean(Obs2(:,:,1:46),3);
%观测距
DELTA1_O=rand(9,5,46);
DELTA1_E=rand(9,5,46);
for i=1:46
    DELTA1_O(:,:,i)=Obs1(:,:,i)-OAVE1;
    DELTA1_E(:,:,i)=Ensemble1(:,:,i)-AVE1;
end
DELTA2_O=rand(9,5,46);
DELTA2_E=rand(9,5,46);
for i=1:46
    DELTA2_O(:,:,i)=Obs2(:,:,i)-OAVE1;
    DELTA2_E(:,:,i)=Ensemble2(:,:,i)-AVE1;
end
DELTA1_W=zeros(9,5,45);
DELTA2_W=zeros(9,5,45);

COR1_W=zeros(9,5);
for i=1:9
    for j=1:5
        OA=squeeze(OAVE1(i,j));
        A=squeeze(DELTA1_O(i,j,2:46));
        O=squeeze(Obs1(i,j,:));
        E=squeeze(Ensemble1(i,j,:));
        S_O=std(O);
        S_E=std(E);
        for t=1:45
            P(t)=(E(t+1)-E(t))*S_O/S_E+O(t)-OA;
        end
        DELTA1_W(i,j,:)=P;
        [r,p]=corrcoef(P,A);
        COR1_W(i,j)=r(1,2);
    end
end
COR2_W=zeros(9,5);
for i=1:9
    for j=1:5
        OA=squeeze(OAVE2(i,j));
        A=squeeze(DELTA2_O(i,j,2:46));
        O=squeeze(Obs2(i,j,:));
        E=squeeze(Ensemble2(i,j,:));
        S_O=std(O);
        S_E=std(E);
        for t=1:45
            P(t)=(E(t+1)-E(t))*S_O/S_E+O(t)-OA;
        end
        DELTA2_W(i,j,:)=P;
        [r,p]=corrcoef(P,A);
        COR2_W(i,j)=r(1,2);
    end
end
COR1_E=zeros(9,5);
for i=1:9
    for j=1:5
        A=squeeze(DELTA1_O(i,j,2:46));
        B=squeeze(DELTA1_E(i,j,2:46));
        [r,p]=corrcoef(A,B);
        COR1_E(i,j)=r(1,2);
    end
end
COR2_E=zeros(9,5);
for i=1:9
    for j=1:5
        A=squeeze(DELTA2_O(i,j,2:46));
        B=squeeze(DELTA2_E(i,j,2:46));
        [r,p]=corrcoef(A,B);
        COR2_E(i,j)=r(1,2);
    end
end
Obs1_Long8=zeros(9,5,46);
VarCon1_8=zeros(9,5);
[b,a]=butter(1,1/8,'low');
for i=1:9
    for j=1:5
        datax=squeeze(DELTA1_O(i,j,:));
        Obs1_Long8(i,j,:)=filter(b,a,datax);
        var1=var(DELTA1_O(i,j,2:45));
        var2=var(Obs1_Long8(i,j,2:45));
        VarCon1_8(i,j)=var2/var1;
    end
end
Obs2_Long8=zeros(9,5,46);
VarCon2_8=zeros(9,5);
[b,a]=butter(1,1/8,'low');
for i=1:9
    for j=1:5
        datax=squeeze(DELTA2_O(i,j,:));
        Obs2_Long8(i,j,:)=filter(b,a,datax);
        var1=var(DELTA2_O(i,j,2:45));
        var2=var(Obs2_Long8(i,j,2:45));
        VarCon2_8(i,j)=var2/var1;
    end
end

