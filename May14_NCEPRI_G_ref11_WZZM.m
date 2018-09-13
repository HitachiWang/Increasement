%this program is for WZZM
%ENSEMBLE Project   Observation: ECWMF NCEP Reanalysis1

%Dataset
%time Ensemble 1960-2005/46   Obs 1948-2017/69  =�� 1960-2005/46
clc;
clear ;
ncdisp('D:/data/Ensemble/129.ref11.DJF.nc');
ncdisp('D:/data/Ensemble/hgt.mon.mean.nc');

G=squeeze(ncread('d:/data/Ensemble/129.ref11.DJF.nc','G11DJF',[1 1 2 1 1],[144 73 1 46 5])); 
OBS=squeeze(ncread('d:/data/Ensemble/hgt.mon.mean.nc','hgt',[1 1 6 145],[144 73 1 47*12]));
lat=ncread('d:/data/Ensemble/hgt.mon.mean.nc','lat');
lon=ncread('d:/data/Ensemble/hgt.mon.mean.nc','lon');
level=ncread('d:/data/Ensemble/hgt.mon.mean.nc','level');
time=ncread('d:/data/Ensemble/hgt.mon.mean.nc','time');
   %�ο�ʱ��ƽ��
%����ƽ��
Ens=zeros(144,73,46,6);
Obs=rand(144,73,46);
Ens(:,:,:,1:5)=squeeze(G);
Ensembles=zeros(144,73,46);
for ENS=1:5
    Ensembles=Ensembles+Ens(:,:,:,ENS);
end
Ens(:,:,:,6)=Ensembles./5;
for i=1:46
    Obs(:,:,i)=((OBS(:,:,i*12-0)+OBS(:,:,i*12+1)+OBS(:,:,i*12+2))/3);
end
for ENS=1:6;
%  for ENS=1:5
% % ʱ������ƽ��
% Ensemble=zeros(144,73,46);
% for ENS=1:5
%     Ensemble=Ensemble+Ens(:,:,:,ENS);
% end
% Ens(:,:,6)=Ensemble./5;
Ensemble=Ens(:,:,:,ENS);
AVE=mean(Ensemble,3);
OAVE=mean(Obs,3);
%�۲��
DELTA_O=rand(144,73,46);
DELTA_E=rand(144,73,46);
for i=1:46
    DELTA_O(:,:,i)=Obs(:,:,i)-OAVE;
    DELTA_E(:,:,i)=Ensemble(:,:,i)-AVE;
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
        A=squeeze(DELTA_O(i,j,2:46));
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
        A=squeeze(DELTA_O(i,j,2:46));
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
end
for i=1:144
    for j=1:73
        A=squeeze(DELTA_O(i,j,2:46));
        B=squeeze(DELTA_E(i,j,2:46));
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
                z=i*j;
                 D_E(z,t)=DELTA_E(i,j,t+1);
                 D_D(z,t)=DELTA_DY(i,j,t);
                 D_W(z,t)=DELTA_W(i,j,t);
                 D_O(z,t)=DELTA_O(i,j,t+1);
            end
        end
 
    RMse_E(t)=RMSE(D_E(:,t),D_O(:,t),144*73);
    RMse_D(t)=RMSE(D_D(:,t),D_O(:,t),144*73);
    RMse_W(t)=RMSE(D_W(:,t),D_O(:,t),144*73);
end
    
    
       

% eval(['[t1x_',num2str(ENS),',t1y_',num2str(ENS),']','=find(Ttest_DY_',num2str(ENS),'<0.01);']);
% eval(['[t2x_',num2str(ENS),',t2y_',num2str(ENS),']','=find(Ttest_E_',num2str(ENS),'<0.01);']);
% end



