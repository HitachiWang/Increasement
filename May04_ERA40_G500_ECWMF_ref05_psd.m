%% 描述文件
%从现在起选择数据为 Ensembles G500 ECWMF JJA ref=05
%part1 对每一个格点的时间序列做周期图谱 然后做全球及8_Area的平均 找出显著周期
%part2 对每一个序列做滤波 计算方差贡献率
%part3 考征功率图谱的区别
%part4 考征方差贡献率空间分布
%part5 小波分析
clc;
clear ;
ncdisp('D:/data/Ensemble/129EnsembleJune.nc');
ncdisp('D:/data/Ensemble/ERA40_G.nc');

%% 选取数据 构建数据模块
%this program is for WZZM
%ENSEMBLE Project   Observation: ECWMF ERA-40 Reanalysis
%Dataset
%time Ensemble 1960-2005/46   Obs 1958-2002/45  =》 1960-2002/43

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
 ENS=1;  %ECWMF
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
%未带有方差调整的年际增量法
DELTA_DY=rand(73,144,42);
for i=2:43
    DELTA_DY(:,:,i-1)=DELTA_O(:,:,i-1)+(Ensemble(:,:,i)-Ensemble(:,:,i-1));
end
%带有方差调整的年际增量法
DELTA_WZZM=rand(73,144,42);
for i=1:73
    for j=1:144
        OA=squeeze(OAVE(i,j));
        A=squeeze(DELTA_O(i,j,2:43));
        O=squeeze(Obs(i,j,:));
        E=squeeze(Ensemble(i,j,:));
        S_O=std(O);
        S_E=std(E);
        P=zeros(42,1);
        for t=1:42
            P(t)=(E(t+1)-E(t))*S_O/S_E+O(t)-OA;
        end
        DELTA_WZZM(i,j,:)=P;
    end
end
clear A AVE E ENS Ensemble_April Ensemble_June Ensemble_July 
clear ENSEMBLE_JUNE ENSEMBLE_JULY ENSEMBLE_APRIL
clear P ref S_E S_O t O OA OAVE

%% 8Aera数据生成
%
NLAT=[9,9,9,9,9,9,9,13];
NLON=[29,13,7,13,37,25,37,13];
LAT={29:37;29:37;21:29;45:53;33:41;33:41;65:73;17:29};
LON={17:45;45:57;45:51;51:61;73:109;109:133;73:109;17:29};
for k=1:8
     eval(['DELTA_WZZM_',num2str(k),'=DELTA_WZZM(cell2mat(LAT(k)),cell2mat(LON(k)),:);']);
     eval(['DELTA_DY_',num2str(k),'=DELTA_DY(cell2mat(LAT(k)),cell2mat(LON(k)),:);']);
     eval(['DELTA_E_',num2str(k),'=DELTA_E(cell2mat(LAT(k)),cell2mat(LON(k)),:);']);
     eval(['DELTA_O_',num2str(k),'=DELTA_O(cell2mat(LAT(k)),cell2mat(LON(k)),:);']);
end

% 很难受 又写了一个计算效率非常低的
%  PXX_WZZM_8Aera=rand(129,8);
%  RedConf_WZZM_8Aera=rand(129,2,8);
% for k=1:8
%     PXX_WZZM=zeros(NLAT(k),NLON(k),129);
%     RedConf_WZZM=zeros(NLAT(k),NLON(k),129,2);
%     for i=1:NLAT(k)
%         for j=1:NLON(k)
%             eval(['datax=DELTA_WZZM_',num2str(k),'(i,j,:);']);
%             datax=squeeze(datax);
%             [pxx1,f1] = periodogram(datax,[],[],1);
%             PXX_WZZM(i,j,:)=pxx1;
%             r=rhoAR1(datax);
%             [~,~,~,~,~,~,~,tabtchi,~,~]=RedConf(pxx1,f1,1,1000,4);
%             RedConf_WZZM(i,j,:,1)=tabtchi(:,3);  % 95%
%             RedConf_WZZM(i,j,:,2)=tabtchi(:,4);  % 99%
%         end
%     end
%     PXX_WZZM_8Aera(:,k)=squeeze(mean(mean(PXX_WZZM,1),2));
%     RedConf_WZZM_8Aera(:,:,k)=squeeze(mean(mean(RedConf_WZZM,1),2));
% end

 PXX_WZZM_8Aera=rand(129,8);
 RedConf_WZZM_8Aera=rand(129,2,8);
for k=1:8
    eval(['datax=squeeze(mean(mean(DELTA_WZZM_',num2str(k),',1),2));']);
    datax=squeeze(datax);
    [pxx1,f1] = periodogram(datax,[],[],1);
    PXX_WZZM_8Aera(:,k)=pxx1;
    r=rhoAR1(datax);
    [~,~,~,~,~,~,~,tabtchi,~,~]=RedConf(pxx1,f1,1,1000,4);
    RedConf_WZZM_8Aera(:,1,k)=tabtchi(:,3);  % 95%
    RedConf_WZZM_8Aera(:,2,k)=tabtchi(:,4);  % 99%
end
PXX_DY_8Aera=rand(129,8);
RedConf_DY_8Aera=rand(129,2,8);
for k=1:8
    eval(['datax=squeeze(mean(mean(DELTA_DY_',num2str(k),',1),2));']);
    datax=squeeze(datax);
    [pxx1,f1] = periodogram(datax,[],[],1);
    PXX_DY_8Aera(:,k)=pxx1;
    r=rhoAR1(datax);
    [~,~,~,~,~,~,~,tabtchi,~,~]=RedConf(pxx1,f1,1,1000,4);
    RedConf_DY_8Aera(:,1,k)=tabtchi(:,3);  % 95%
    RedConf_DY_8Aera(:,2,k)=tabtchi(:,4);  % 99%
end
PXX_E_8Aera=rand(129,8);
RedConf_E_8Aera=rand(129,2,8);
for k=1:8
    eval(['datax=squeeze(mean(mean(DELTA_E_',num2str(k),',1),2));']);
    datax=squeeze(datax);
    [pxx1,f1] = periodogram(datax,[],[],1);
    PXX_E_8Aera(:,k)=pxx1;
    r=rhoAR1(datax);
    [~,~,~,~,~,~,~,tabtchi,~,~]=RedConf(pxx1,f1,1,1000,4);
    RedConf_E_8Aera(:,1,k)=tabtchi(:,3);  % 95%
    RedConf_E_8Aera(:,2,k)=tabtchi(:,4);  % 99%
end
PXX_O_8Aera=rand(129,8);
RedConf_O_8Aera=rand(129,2,8);
for k=1:8
    eval(['datax=squeeze(mean(mean(DELTA_O_',num2str(k),',1),2));']);
    datax=squeeze(datax);
    [pxx1,f1] = periodogram(datax,[],[],1);
    PXX_O_8Aera(:,k)=pxx1;
    r=rhoAR1(datax);
    [~,~,~,~,~,~,~,tabtchi,~,~]=RedConf(pxx1,f1,1,1000,4);
    RedConf_O_8Aera(:,1,k)=tabtchi(:,3);  % 95%
    RedConf_O_8Aera(:,2,k)=tabtchi(:,4);  % 99%
end


%% 格点序列周期图谱
% 周期图谱法 窗口函数选择矩形窗口 DFT Point
% nfft=(max(256,2^nextpow2(length(datax))/2+1)=129
%采样率 fs=1 Monte Carlo Loop = 1000

% 下面这个方法粗略估计得14个小时 暂时先不用
% PXX_WZZM=rand(73,144,129);
% RedConf_WZZM=rand(73,144,129,2);
% for i=1:73
%     for j=1:144
%         datax=DELTA_WZZM(i,j,:);
%         datax=squeeze(datax);
%         [pxx1,f1] = periodogram(datax,[],[],1);
%         PXX_WZZM(i,j,:)=pxx1;
%         r=rhoAR1(datax);
%         [~,~,~,~,~,~,~,tabtchi,~,~]=RedConf(pxx1,f1,1,1000,4);
%         RedConf_WZZM(i,j,:,1)=tabtchi(:,3);  % 95%
%         RedConf_WZZM(i,j,:,2)=tabtchi(:,4);  % 99%
%     end
%  end
% PXX_WZZM_GlobalAve=squeeze(mean(mean(PXX_WZZM,1),2)); %全球平均
% RedConf_WZZM_GlobalAve=squeeze(mean(mean(RedConf_WZZM,1),2)); %全球平均

RedConf_WZZM=rand(129,2);
DELTA_WZZM_GlobalAve=mean(mean(DELTA_WZZM(:,:,:),1),2);
datax=DELTA_WZZM_GlobalAve;
datax=squeeze(datax);
[pxx1,f1] = periodogram(datax,[],[],1);
PXX_WZZM_GlobalAve=pxx1;
r=rhoAR1(datax);
[~,~,~,~,~,~,~,tabtchi,~,~]=RedConf(pxx1,f1,1,1000,4);
RedConf_WZZM_GlobalAve(:,1)=tabtchi(:,3)./10000;  % 95%
RedConf_WZZM_GlobalAve(:,2)=tabtchi(:,4)./10000;  % 99%

RedConf_DY=rand(129,2);
DELTA_DY_GlobalAve=mean(mean(DELTA_DY(:,:,:),1),2);
datax=DELTA_DY_GlobalAve;
datax=squeeze(datax);
[pxx1,f1] = periodogram(datax,[],[],1);
PXX_DY_GlobalAve=pxx1;
r=rhoAR1(datax);
[~,~,~,~,~,~,~,tabtchi,~,~]=RedConf(pxx1,f1,1,1000,4);
RedConf_DY_GlobalAve(:,1)=tabtchi(:,3)./10000;  % 95%
RedConf_DY_GlobalAve(:,2)=tabtchi(:,4)./10000;  % 99%

RedConf_E=rand(129,2);
DELTA_E_GlobalAve=mean(mean(DELTA_E(:,:,:),1),2);
datax=DELTA_E_GlobalAve;
datax=squeeze(datax);
[pxx1,f1] = periodogram(datax,[],[],1);
PXX_E_GlobalAve=pxx1;
r=rhoAR1(datax);
[~,~,~,~,~,~,~,tabtchi,~,~]=RedConf(pxx1,f1,1,1000,4);
RedConf_E_GlobalAve(:,1)=tabtchi(:,3)./10000;  % 95%
RedConf_E_GlobalAve(:,2)=tabtchi(:,4)./10000;  % 99%

RedConf_O=rand(129,2);
DELTA_O_GlobalAve=mean(mean(DELTA_O(:,:,:),1),2);
datax=DELTA_O_GlobalAve;
datax=squeeze(datax);
[pxx1,f1] = periodogram(datax,[],[],1);
PXX_O_GlobalAve=pxx1;
r=rhoAR1(datax);
[~,~,~,~,~,~,~,tabtchi,~,~]=RedConf(pxx1,f1,1,1000,4);
RedConf_O_GlobalAve(:,1)=tabtchi(:,3)./10000;  % 95%
RedConf_O_GlobalAve(:,2)=tabtchi(:,4)./10000;  % 99%



% %% A1 周期图功率谱
% RedConf_WZZM=rand(129,2);
% DELTA_WZZM_GlobalAve=mean(mean(DELTA_WZZM(i,j,:),1),2);
% datax=DELTA_WZZM_GlobalAve;
% datax=squeeze(datax);
% [pxx1,f1] = periodogram(datax,[],[],1);
% PXX_WZZM_GlobalAve=pxx1;
% r=rhoAR1(datax);
% [~,~,~,~,~,~,~,tabtchi,~,~]=RedConf(pxx1,f1,1,1000,4);
% RedConf_WZZM_GlobalAve(:,1)=tabtchi(:,3)./10000;  % 95%
% RedConf_WZZM_GlobalAve(:,2)=tabtchi(:,4)./10000;  % 99%
%% 滤波 滑动平均
%Variance contribution
Lowpass2_WZZM=zeros(73,144,42);
Lowpass10_WZZM=zeros(73,144,42);
VarCon_WZZM=zeros(73,144,3);
for i=1:73
    for j=1:144
        datax=squeeze(DELTA_WZZM(i,j,:));
        windowSize1=2;
        b= (1/windowSize1)*ones(1,windowSize1);
        Lowpass2=filter(b,1,datax);
        Lowpass2_WZZM(i,j,:)=Lowpass2;
        windowSize1=10;
        b= (1/windowSize1)*ones(1,windowSize1);
        Lowpass10=filter(b,1,datax);
        Lowpass10_WZZM(i,j,:)=Lowpass10;
        S_ALL=std(datax)^2;
        S_Lowpass2=std(Lowpass2)^2;
        S_Lowpass10=std(Lowpass10)^2;
        S_Bandpass=(std(Lowpass2-Lowpass10))^2;
        VarCon_WZZM(i,j,1)=S_Lowpass2./S_ALL*100;
        VarCon_WZZM(i,j,2)=S_Lowpass10./S_ALL*100;
        VarCon_WZZM(i,j,3)=S_Bandpass./S_ALL*100;
    end
end

% 滑动平均滤波
test=squeeze(DELTA_WZZM(1,1,:));
windowSize1=2;
b= (1/windowSize1)*ones(1,windowSize1);
Lowpass_2=filter(b,1,test);
windowSize2=10;
b= (1/windowSize2)*ones(1,windowSize2);
Lowpass_10=filter(b,1,test);
ts=1:42;
figure(2)
plot(ts,test,ts,Lowpass_2,ts,Lowpass_10);
legend('t','2','10');

%% 滤波 butterworth滤波器
%butterworth滤波器
[b,a]=butter(1,[0.1,0.5]);
ButterBand_2to10=filter(b,a,test);
[b,a]=butter(1,0.1);
ButterLow_10=filter(b,a,test);
[b,a]=butter(1,0.5);
ButterLow_2=filter(b,a,test);

% WZZM Form
ButterLowpass2_WZZM=zeros(73,144,42);
ButterLowpass10_WZZM=zeros(73,144,42);
ButterBandpass_WZZM=zeros(73,144,42);
ButterVarCon_WZZM=zeros(73,144,3);
for i=1:73
    for j=1:144
        datax=squeeze(DELTA_WZZM(i,j,:));
        [b,a]=butter(1,0.5);
        ButterLow2=filter(b,a,datax);
        ButterLowpass2_WZZM(i,j,:)=ButterLow2;
        [b,a]=butter(1,0.2);
        ButterLow10=filter(b,a,datax);
        ButterLowpass10_WZZM(i,j,:)=ButterLow10;
        [b,a]=butter(1,[0.1,0.5]);
        ButterBand_2to10=filter(b,a,datax);
        ButterBandpass_WZZM(i,j,:)=ButterBand_2to10;
        S_ALL=std(datax)^2;
        S_BLowpass2=std(ButterLow2)^2;
        S_BLowpass10=std(ButterLow10)^2;
        S_BBandpass=(std(ButterBand_2to10))^2;
        ButterVarCon_WZZM(i,j,1)=S_BLowpass2./S_ALL*100; %周期大于2
        ButterVarCon_WZZM(i,j,2)=S_BLowpass10./S_ALL*100; %周期大于10
        ButterVarCon_WZZM(i,j,3)=S_BBandpass./S_ALL*100; %周期介于2-10
    end
end

% DY Form
ButterLowpass2_DY=zeros(73,144,42);
ButterLowpass10_DY=zeros(73,144,42);
ButterBandpass_DY=zeros(73,144,42);
ButterVarCon_DY=zeros(73,144,3);
for i=1:73
    for j=1:144
        datax=squeeze(DELTA_DY(i,j,:));
        [b,a]=butter(1,0.5);
        ButterLow2=filter(b,a,datax);
        ButterLowpass2_DY(i,j,:)=ButterLow2;
        [b,a]=butter(1,0.2);
        ButterLow10=filter(b,a,datax);
        ButterLowpass10_DY(i,j,:)=ButterLow10;
        [b,a]=butter(1,[0.1,0.5]);
        ButterBand_2to10=filter(b,a,datax);
        ButterBandpass_DY(i,j,:)=ButterBand_2to10;
        S_ALL=std(datax)^2;
        S_BLowpass2=std(ButterLow2)^2;
        S_BLowpass10=std(ButterLow10)^2;
        S_BBandpass=(std(ButterBand_2to10))^2;
        ButterVarCon_DY(i,j,1)=S_BLowpass2./S_ALL*100; %周期大于2
        ButterVarCon_DY(i,j,2)=S_BLowpass10./S_ALL*100; %周期大于10
        ButterVarCon_DY(i,j,3)=S_BBandpass./S_ALL*100; %周期介于2-10
    end
end

% E Form
ButterLowpass2_E=zeros(73,144,42);
ButterLowpass10_E=zeros(73,144,42);
ButterBandpass_E=zeros(73,144,42);
ButterVarCon_E=zeros(73,144,3);
for i=1:73
    for j=1:144
        datax=squeeze(DELTA_E(i,j,2:43));
        [b,a]=butter(1,0.5);
        ButterLow2=filter(b,a,datax);
        ButterLowpass2_E(i,j,:)=ButterLow2;
        [b,a]=butter(1,0.2);
        ButterLow10=filter(b,a,datax);
        ButterLowpass10_E(i,j,:)=ButterLow10;
        [b,a]=butter(1,[0.1,0.5]);
        ButterBand_2to10=filter(b,a,datax);
        ButterBandpass_E(i,j,:)=ButterBand_2to10;
        S_ALL=std(datax)^2;
        S_BLowpass2=std(ButterLow2)^2;
        S_BLowpass10=std(ButterLow10)^2;
        S_BBandpass=(std(ButterBand_2to10))^2;
        ButterVarCon_E(i,j,1)=S_BLowpass2./S_ALL*100; %周期大于2
        ButterVarCon_E(i,j,2)=S_BLowpass10./S_ALL*100; %周期大于10
        ButterVarCon_E(i,j,3)=S_BBandpass./S_ALL*100; %周期介于2-10
    end
end
% O Form
ButterLowpass2_O=zeros(73,144,42);
ButterLowpass10_O=zeros(73,144,42);
ButterBandpass_O=zeros(73,144,42);
ButterVarCon_O=zeros(73,144,3);
for i=1:73
    for j=1:144
        datax=squeeze(DELTA_O(i,j,2:43));
        [b,a]=butter(1,0.5);
        ButterLow2=filter(b,a,datax);
        ButterLowpass2_O(i,j,:)=ButterLow2;
        [b,a]=butter(1,0.2);
        ButterLow10=filter(b,a,datax);
        ButterLowpass10_O(i,j,:)=ButterLow10;
        [b,a]=butter(1,[0.1,0.5]);
        ButterBand_2to10=filter(b,a,datax);
        ButterBandpass_O(i,j,:)=ButterBand_2to10;
        S_ALL=std(datax)^2;
        S_BLowpass2=std(ButterLow2)^2;
        S_BLowpass10=std(ButterLow10)^2;
        S_BBandpass=(std(ButterBand_2to10))^2;
        ButterVarCon_O(i,j,1)=S_BLowpass2./S_ALL*100; %周期大于2
        ButterVarCon_O(i,j,2)=S_BLowpass10./S_ALL*100; %周期大于10
        ButterVarCon_O(i,j,3)=S_BBandpass./S_ALL*100; %周期介于2-10
    end
end
figure(3)
plot(ts,ButterLow_2-ButterLow_10,ts,ButterBand_2to10);

%% 考察年代际分量的相关系数
Band_DY=rand(73,144,42);
Band_WZZM=rand(73,144,42);
Band_O=rand(73,144,42);
Band_E=rand(73,144,42);
BandCOR_WZZM=rand(73,144);
BandCOR_DY=rand(73,144);
BandCOR_E=rand(73,144);
[b1,a1]=butter(1,0.5,'low');
[b2,a2]=butter(1,0.1,'low');
for i=1:73
    for j=1:144
        Band_WZZM(i,j,:)=filter(b1,a1,DELTA_WZZM(i,j,:))-filter(b2,a2,DELTA_WZZM(i,j,:));
        Band_DY(i,j,:)=filter(b1,a1,DELTA_DY(i,j,:))-filter(b2,a2,DELTA_DY(i,j,:));
        Band_E(i,j,:)=filter(b1,a1,DELTA_E(i,j,2:43))-filter(b2,a2,DELTA_E(i,j,2:43));
        Band_O(i,j,:)=filter(b1,a1,DELTA_O(i,j,2:43))-filter(b2,a2,DELTA_O(i,j,2:43));
        r=corrcoef(Band_WZZM(i,j,:),Band_O(i,j,:));
        BandCOR_WZZM(i,j)=r(1,2);
        r=corrcoef(Band_DY(i,j,:),Band_O(i,j,:));
        BandCOR_DY(i,j)=r(1,2);
        r=corrcoef(Band_E(i,j,:),Band_O(i,j,:));
        BandCOR_E(i,j)=r(1,2);
    end
end

High_WZZM=rand(73,144,42);
High_DY=rand(73,144,42);
High_E=rand(73,144,42);
High_O=rand(73,144,42);
HighCOR_WZZM=rand(73,144);
HighCOR_DY=rand(73,144);
HighCOR_E=rand(73,144);
[b3,a3]=butter(1,0.5,'high');
for i=1:73
    for j=1:144
        High_WZZM(i,j,:)=filter(b3,a3,DELTA_WZZM(i,j,:));
        High_DY(i,j,:)=filter(b3,a3,DELTA_DY(i,j,:));
        High_E(i,j,:)=filter(b3,a3,DELTA_E(i,j,2:43));
        High_O(i,j,:)=filter(b3,a3,DELTA_O(i,j,2:43));
        r=corrcoef(High_WZZM(i,j,:),High_O(i,j,:));
        HighCOR_WZZM(i,j)=r(1,2);
        r=corrcoef(High_DY(i,j,:),High_O(i,j,:));
        HighCOR_DY(i,j)=r(1,2);
        r=corrcoef(High_E(i,j,:),High_O(i,j,:));
        HighCOR_E(i,j)=r(1,2);
    end
end
VC=rand(73,144);
LOW=rand(73,144,42);
[bb,aa]=butter(1,0.1,'low');
for i=1:73
    for j=1:144
        datax=squeeze(DELTA_O(i,j,2:43));
        LOW(i,j,:)=filter(bb,aa,datax);
        S1=std(datax)^2;
        S2=std(squeeze(LOW(i,j,:)))^2;
        VC(i,j)=S2/S1;
    end
end



figure(1)
t = linspace(-pi,pi,100);
rng default
x = sin(t) + 0.25*rand(size(t));
[b,a]=butter(1,0.5);
y=filter(b,a,x);
plot(t,x,t,y)