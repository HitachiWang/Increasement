%this program is for WZZM
%ENSEMBLE Project   Observation: ECWMF NCEP Reanalysis1

%Dataset
%time Ensemble 1960-2005/46   Obs 1948-2017/69  =》 1960-2005/46
clc;
clear ;
ncdisp('D:/data/Ensemble/228.ref11.DJF.nc');
ncdisp('D:/data/Ensemble/pr_wtr.mon.mean.nc');

G=squeeze(ncread('d:/data/Ensemble/228.ref05.JJA.nc','G11DJF',[1 1 2 1 1],[144 73 1 46 5])); 
OBS=squeeze(ncread('d:/data/Ensemble/hgt.mon.mean.nc','hgt',[1 1 6 145],[144 73 1 47*12]));
lat=ncread('d:/data/Ensemble/hgt.mon.mean.nc','lat');
lon=ncread('d:/data/Ensemble/hgt.mon.mean.nc','lon');
level=ncread('d:/data/Ensemble/hgt.mon.mean.nc','level');
time=ncread('d:/data/Ensemble/hgt.mon.mean.nc','time');
   %参考时间平均
%季度平均
Obs=rand(144,73,46);
Ens=squeeze(G)./9.8;
for i=1:46
    Obs(:,:,i)=((OBS(:,:,i*12-6)+OBS(:,:,i*12-5)+OBS(:,:,i*12-4))/3);
end

%  for ENS=1:5
% % 时间序列平均
Ensemble=zeros(144,73,46);
for ENS=1:5
    Ensemble=Ensemble+Ens(:,:,:,ENS);
end
Ensemble=Ensemble./5;
% Ensemble=Ens(:,:,:,ENS);
AVE=mean(Ensemble(:,:,2:46),3);
OAVE=mean(Obs(:,:,2:46),3);
%观测距
DELTA_O=rand(144,73,45);
DELTA_E=rand(144,73,45);
for i=2:46
    DELTA_O(:,:,i-1)=Obs(:,:,i)-OAVE;
    DELTA_E(:,:,i-1)=Ensemble(:,:,i)-AVE;
end
DELTA_DY=rand(144,73,45);
DELTA_W=rand(144,73,45);
for i=2:46
    DELTA_DY(:,:,i-1)=DELTA_O(:,:,i-1)+(Ensemble(:,:,i)-Ensemble(:,:,i-1));
end

eval(['COR_DY_',num2str(ENS),'=rand(144,73);']);
eval(['RMSE_DY_',num2str(ENS),'=rand(144,73);']);
for i=1:144
    for j=1:73
        A=squeeze(DELTA_O(i,j,:));
        B=squeeze(DELTA_DY(i,j,:));
        [r,p]=corrcoef(A,B);
        eval(['COR_DY_',num2str(ENS),'(i,j)=r(1,2);']);
        Rmse=RMSE(A,B,45);
        eval(['RMSE_DY_',num2str(ENS),'(i,j)=Rmse;']);
    end
end
%%CORDY WZZR
eval(['COR_DY_W_',num2str(ENS),'=rand(144,73);']);
eval(['Ttest_DY_W_',num2str(ENS),'=rand(144,73);']);
for i=1:144
    for j=1:73
        OA=squeeze(OAVE(i,j));
        A=squeeze(DELTA_O(i,j,:));
        O=squeeze(Obs(i,j,:));
        E=squeeze(Ensemble(i,j,:));
        S_O=std(O);
        S_E=std(E);
        for t=1:45
            P(t)=(E(t+1)-E(t))*S_O/S_E+O(t)-OA;
        end
        DELTA_W(i,j,:)=P;
        [r,p]=corrcoef(P,A);
        eval(['COR_DY_W_',num2str(ENS),'(i,j)=r(1,2);']);
        Rmse=RMSE(P,A,45);
        eval(['RMSE_DY_W_',num2str(ENS),'(i,j)=Rmse;']);
    end
end

eval(['COR_E_',num2str(ENS),'=rand(144,73);']);
eval(['Ttest_E_',num2str(ENS),'=rand(144,73);']);
for i=1:144
    for j=1:73
        A=squeeze(DELTA_O(i,j,:));
        B=squeeze(DELTA_E(i,j,:));
        [r,p]=corrcoef(A,B);
        eval(['COR_E_',num2str(ENS),'(i,j)=r(1,2);']);
        Rmse=RMSE(A,B,45);
        eval(['RMSE_E_',num2str(ENS),'(i,j)=Rmse;']);
    end
end

D_E=zeros(144*73,45);
D_D=zeros(144*73,45);
D_W=zeros(144*73,45);
D_O=zeros(144*73,45);
RMse_E=zeros(45,1);
RMse_D=zeros(45,1);
RMse_W=zeros(45,1);
for t=1:45
        for i=1:144
            for j=1:73
                 D_E(i*j,t)=DELTA_E(i,j,t);
                 D_D(i*j,t)=DELTA_DY(i,j,t);
                 D_W(i*j,t)=DELTA_W(i,j,t);
                 D_O(i*j,t)=DELTA_O(i,j,t);
            end
        end
    RMse_E(t)=RMSE(D_E(:,t),D_O(:,t),144*73);
    RMse_D(t)=RMSE(D_D(:,t),D_O(:,t),144*73);
    RMse_W(t)=RMSE(D_W(:,t),D_O(:,t),144*73);
end
%-40 40 
D1_E=zeros(144*33,45);
D1_D=zeros(144*33,45);
D1_W=zeros(144*33,45);
D1_O=zeros(144*33,45);
RMSe_E=zeros(45,1);
RMSe_D=zeros(45,1);
RMSe_W=zeros(45,1);
for t=1:45
    
        for i=1:144
            for j=21:53
                 D1_E(i*j,t)=DELTA_E(i,j,t);
                 D1_D(i*j,t)=DELTA_DY(i,j,t);
                 D1_W(i*j,t)=DELTA_W(i,j,t);
                 D1_O(i*j,t)=DELTA_O(i,j,t);
            end
        end
    
    RMSe_E(t)=RMSE(D1_E(:,t),D1_O(:,t),144*33);
    RMSe_D(t)=RMSE(D1_D(:,t),D1_O(:,t),144*33);
    RMSe_W(t)=RMSE(D1_W(:,t),D1_O(:,t),144*33);
end
%-23.5 23.5
D2_E=zeros(144*21,45);
D2_D=zeros(144*21,45);
D2_W=zeros(144*21,45);
D2_O=zeros(144*21,45);
Rmse_E=zeros(45,1);
Rmse_D=zeros(45,1);
Rmse_W=zeros(45,1);
for t=1:45
   
        for i=1:144
            for j=27:47
                 D2_E(i*j,t)=DELTA_E(i,j,t);
                 D2_D(i*j,t)=DELTA_DY(i,j,t);
                 D2_W(i*j,t)=DELTA_W(i,j,t);
                 D2_O(i*j,t)=DELTA_O(i,j,t);
            end
        end
    
    Rmse_E(t)=RMSE(D2_E(:,t),D2_O(:,t),144*21);
    Rmse_D(t)=RMSE(D2_D(:,t),D2_O(:,t),144*21);
    Rmse_W(t)=RMSE(D2_W(:,t),D2_O(:,t),144*21);
end
 
CorE=zeros(45,1);
CorW=zeros(45,1);
for k=1:45
    r=corrcoef(D_E(:,k),D_O(:,k));
    CorE(k)=r(1,2);
    r=corrcoef(D_W(:,k),D_O(:,k));
    CorW(k)=r(1,2);
end

% eval(['[t1x_',num2str(ENS),',t1y_',num2str(ENS),']','=find(Ttest_DY_',num2str(ENS),'<0.01);']);
% eval(['[t2x_',num2str(ENS),',t2y_',num2str(ENS),']','=find(Ttest_E_',num2str(ENS),'<0.01);']);
% end



