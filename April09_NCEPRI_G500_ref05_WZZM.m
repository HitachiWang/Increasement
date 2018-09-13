%this program is for WZZM
%ENSEMBLE Project   Observation: ECWMF NCEP Reanalysis1

%Dataset
%time Ensemble 1960-2005/46   Obs 1948-2017/69  =》 1960-2005/46
clc;
clear ;
ncdisp('D:/data/Ensemble/129EnsembleJune.nc');
ncdisp('D:/data/Ensemble/hgt.mon.mean.nc');

ENSEMBLE_JUNE=ncread('D:/data/Ensemble/129EnsembleJune.nc','g500');
ENSEMBLE_JULY=ncread('D:/data/Ensemble/129EnsembleJuly.nc','g500');
ENSEMBLE_APRIL=ncread('D:/data/Ensemble/129EnsembleApril.nc','g500');
OBS=squeeze(ncread('d:/data/Ensemble/hgt.mon.mean.nc','hgt',[1 1 6 145],[144 73 1 46*12]));
lat=ncread('d:/data/Ensemble/hgt.mon.mean.nc','lat');
lon=ncread('d:/data/Ensemble/hgt.mon.mean.nc','lon');
level=ncread('d:/data/Ensemble/hgt.mon.mean.nc','level');
   %参考时间平均
ref=2;
Ensemble_June=zeros(73,144,46,6);%这是mean.mon 选取ref=05
Ensemble_June=ENSEMBLE_JUNE(:,:,1:46,:,ref);
Ensemble_July=zeros(73,144,46,6);
Ensemble_July=ENSEMBLE_JULY(:,:,1:46,:,ref);
Ensemble_April=zeros(73,144,46,6);
Ensemble_April=ENSEMBLE_APRIL(:,:,1:46,:,ref);
%季度平均
Ensemble_SUM=(Ensemble_June+Ensemble_July+Ensemble_April)/3;
OBS_SUM=rand(73,144,46);
for i=1:46
    OBS_SUM(:,:,i)=flipud(rot90((OBS(:,:,i*12-6)+OBS(:,:,i*12-5)+OBS(:,:,i*12-4))/3));
end
% for ENS=1:6%重力位势to位势高度
 for  ENS=1:6;  
Ensemble=rand(73,144,46);
Obs=rand(73,144,46);
%选取
    for j=1:46
        Ensemble(:,:,j)=Ensemble_SUM(:,:,j,ENS)/9.8;
        Obs(:,:,j)=OBS_SUM(:,:,j);
    end
Annual_Inc_Obs=zeros(73,144,45);
Annual_Inc_Ens=zeros(73,144,45);
for i=1:45
    Annual_Inc_Obs(:,:,i)=Obs(:,:,i+1)-Obs(:,:,i);
    Annual_Inc_Ens(:,:,i)=Ensemble(:,:,i+1)-Ensemble(:,:,i);
end
Variance_Annual_Inc_Obs=zeros(73,144);
Variance_Annual_Inc_Ens=zeros(73,144);
Variance_Annual_Inc_Obs=std(Annual_Inc_Obs,0,3);
Variance_Annual_Inc_Ens=std(Annual_Inc_Ens,0,3);
%时间序列平均
AVE=mean(Ensemble,3);
OAVE=mean(Obs,3);
%观测距
DELTA_O=rand(73,144,46);
DELTA_E=rand(73,144,46);
for i=1:46
    DELTA_O(:,:,i)=Obs(:,:,i)-OAVE;
    DELTA_E(:,:,i)=Ensemble(:,:,i)-AVE;
end
DELTA_DY=rand(73,144,45);
for i=2:46
    DELTA_DY(:,:,i-1)=DELTA_O(:,:,i-1)+(Ensemble(:,:,i)-Ensemble(:,:,i-1));
end
DELTA_W=zeros(73,144,45);
% S_O=zeros(73,144);
% S_E=zeros(73,144);
for i=1:73
    for j=1:144
        OA=squeeze(OAVE(i,j));
        A=squeeze(DELTA_O(i,j,2:46));
        O=squeeze(Obs(i,j,:));
        E=squeeze(Ensemble(i,j,:));
        for t=1:45
            P(t)=(E(t+1)-E(t)).*(Variance_Annual_Inc_Obs(i,j)/Variance_Annual_Inc_Ens(i,j))+O(t)-OA;
        end
        DELTA_W(i,j,:)=P;
    end
end
eval(['COR_DY_',num2str(ENS),'=rand(73,144);']);
eval(['Ttest_DY_',num2str(ENS),'=rand(73,144);']);
for i=1:73
    for j=1:144
        A=squeeze(DELTA_O(i,j,2:46));
        B=squeeze(DELTA_DY(i,j,:));
        [r,p]=corrcoef(A,B);
        eval(['COR_DY_',num2str(ENS),'(i,j)=r(1,2);']);
        eval(['Ttest_DY_',num2str(ENS),'(i,j)=p(1,2);']);
        eval(['if(COR_DY_',num2str(ENS),'(i,j)<0)' 'COR_DY_',num2str(ENS),'(i,j)=NaN;end']);
    end
end
%%CORDY WZZR
eval(['COR_DY_W_',num2str(ENS),'=rand(73,144);']);
eval(['Ttest_DY_W_',num2str(ENS),'=rand(73,144);']);
for i=1:73
    for j=1:144
        A=squeeze(DELTA_O(i,j,2:46));
        B=squeeze(DELTA_W(i,j,:));
        [r,p]=corrcoef(A,B);
        eval(['COR_DY_W_',num2str(ENS),'(i,j)=r(1,2);']);
        eval(['Ttest_DY_W_',num2str(ENS),'(i,j)=p(1,2);']);
        eval(['if(COR_DY_W_',num2str(ENS),'(i,j)<0)' 'COR_DY_W_',num2str(ENS),'(i,j)=NaN;end']);
    end
end

eval(['COR_E_',num2str(ENS),'=rand(73,144);']);
eval(['Ttest_E_',num2str(ENS),'=rand(73,144);']);
for i=1:73
    for j=1:144
        A=squeeze(DELTA_O(i,j,2:46));
        B=squeeze(DELTA_E(i,j,2:46));
        [r,p]=corrcoef(A,B);
        eval(['COR_E_',num2str(ENS),'(i,j)=r(1,2);']);
        eval(['Ttest_E_',num2str(ENS),'(i,j)=p(1,2);']);
        eval(['if(COR_E_',num2str(ENS),'(i,j)<0)' 'COR_E_',num2str(ENS),'(i,j)=NaN;end']);
    end
end

eval(['[t1x_',num2str(ENS),',t1y_',num2str(ENS),']','=find(Ttest_DY_',num2str(ENS),'<0.01);']);
eval(['[t2x_',num2str(ENS),',t2y_',num2str(ENS),']','=find(Ttest_E_',num2str(ENS),'<0.01);']);
 end
 
 G=zeros(73,144,3);
 G(:,:,1)=COR_DY_1;
 G(:,:,2)=COR_DY_W_1;
 G(:,:,3)=COR_E_1;

 ncid2=netcdf.create('d:/123/g500ref05cor.nc','clobber');
        % Create NetCDF file,输入文件名.
lon=netcdf.defDim(ncid2,'longitude',144);%定义维
lat=netcdf.defDim(ncid2,'latitude',73);
% time=netcdf.defDim(ncid2,'time',46);
% id=netcdf.defDim(ncid2,'institude',5);
% level=netcdf.defDim(ncid2,'level',5);
kd=netcdf.defDim(ncid2,'kind',3);

g=netcdf.defVar(ncid2,'cor','double',[lat lon kd]);%定义变量
% longitude=netcdf.defVar(ncid2,'longitude','single',lon);
% latitude=netcdf.defVar(ncid2,'latitude','single',lat);
% lev=netcdf.defVar(ncid2,'level','single',level);
netcdf.endDef(ncid2);%关闭定义
netcdf.putVar(ncid2,g,G);%填值
% netcdf.putVar(ncid2,longitude,long);
% netcdf.putVar(ncid2,latitude,lati);
% netcdf.putVar(ncid2,lev,leve);

netcdf.close(ncid2);
%  
%  for i=1:73
%      for j=1:144
%          if(COR_E_1(i,j)<0)
%             COR_E_1(i,j)=NaN; %#ok<SAGROW>
%          end
%      end
%  end
 
% 
% end
% 
% D_E=zeros(144*73,45);
% D_D=zeros(144*73,45);
% D_W=zeros(144*73,45);
% D_O=zeros(144*73,45);
% RMse_E=zeros(45,1);
% RMse_D=zeros(45,1);
% RMse_W=zeros(45,1);
% for t=1:45
%         for i=1:73
%             for j=1:144
%                  D_E(i*j,t)=DELTA_E(i,j,t);
%                  D_D(i*j,t)=DELTA_DY(i,j,t);
%                  D_W(i*j,t)=DELTA_W(i,j,t);
%                  D_O(i*j,t)=DELTA_O(i,j,t);
%             end
%         end
%     RMse_E(t)=RMSE(D_E(:,t),D_O(:,t),144*73);
%     RMse_D(t)=RMSE(D_D(:,t),D_O(:,t),144*73);
%     RMse_W(t)=RMSE(D_W(:,t),D_O(:,t),144*73);
% end
% %-40 40 
% D1_E=zeros(144*33,45);
% D1_D=zeros(144*33,45);
% D1_W=zeros(144*33,45);
% D1_O=zeros(144*33,45);
% RMSe_E=zeros(45,1);
% RMSe_D=zeros(45,1);
% RMSe_W=zeros(45,1);
% for t=1:45
%     
%         for i=21:53
%             for j=1:144
%                  D1_E(i*j,t)=DELTA_E(i,j,t);
%                  D1_D(i*j,t)=DELTA_DY(i,j,t);
%                  D1_W(i*j,t)=DELTA_W(i,j,t);
%                  D1_O(i*j,t)=DELTA_O(i,j,t);
%             end
%         end
%     
%     RMSe_E(t)=RMSE(D1_E(:,t),D1_O(:,t),144*33);
%     RMSe_D(t)=RMSE(D1_D(:,t),D1_O(:,t),144*33);
%     RMSe_W(t)=RMSE(D1_W(:,t),D1_O(:,t),144*33);
% end
% %-23.5 23.5
% D2_E=zeros(144*21,45);
% D2_D=zeros(144*21,45);
% D2_W=zeros(144*21,45);
% D2_O=zeros(144*21,45);
% Rmse_E=zeros(45,1);
% Rmse_D=zeros(45,1);
% Rmse_W=zeros(45,1);
% for t=1:45
%    
%         for i=27:47
%             for j=1:144
%                  D2_E(i*j,t)=DELTA_E(i,j,t);
%                  D2_D(i*j,t)=DELTA_DY(i,j,t);
%                  D2_W(i*j,t)=DELTA_W(i,j,t);
%                  D2_O(i*j,t)=DELTA_O(i,j,t);
%             end
%         end
%     
%     Rmse_E(t)=RMSE(D2_E(:,t),D2_O(:,t),144*21);
%     Rmse_D(t)=RMSE(D2_D(:,t),D2_O(:,t),144*21);
%     Rmse_W(t)=RMSE(D2_W(:,t),D2_O(:,t),144*21);
% end
% 
%  D3_E=zeros(72*33,45);
% D3_D=zeros(72*33,45);
% D3_W=zeros(72*33,45);
% D3_O=zeros(72*33,45);
% Rmse3_E=zeros(45,1);
% Rmse3_D=zeros(45,1);
% Rmse3_W=zeros(45,1);
% for t=1:45
%    
%         for i=21:53
%             for j=1:72
%                  D3_E(i*j,t)=DELTA_E(i,j,t);
%                  D3_D(i*j,t)=DELTA_DY(i,j,t);
%                  D3_W(i*j,t)=DELTA_W(i,j,t);
%                  D3_O(i*j,t)=DELTA_O(i,j,t);
%             end
%         end
%     
%     Rmse3_E(t)=RMSE(D2_E(:,t),D3_O(:,t),72*33);
%     Rmse3_D(t)=RMSE(D2_D(:,t),D3_O(:,t),72*33);
%     Rmse3_W(t)=RMSE(D2_W(:,t),D3_O(:,t),72*33);
% end
% 
% CorE=zeros(45,1);
% CorW=zeros(45,1);
% CorD=zeros(45,1);
% for k=1:45
%     r=corrcoef(D3_E(:,k),D3_O(:,k));
%     CorE(k)=r(1,2);
%     r=corrcoef(D3_W(:,k),D3_O(:,k));
%     CorW(k)=r(1,2);
%      r=corrcoef(D_D(:,k),D_O(:,k));
%     CorD(k)=r(1,2);
% end
% AA=Ensemble(:,:,3)-Ensemble(:,:,2);
% BB=AA.*(S_O./S_E);
% CC=Obs(:,:,3)-Obs(:,:,2);