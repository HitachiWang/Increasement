%this program is for jiheuybao

clear all;
clc;

datadir='./Ensemble/228/'; %指定批量数据所在文件
filelist=dir([datadir,'*.nc']);

a=filelist(1).name;
b=filelist(2).name;
k=length(filelist);

%创建PRLR数据（PRLR(lat.73, lon.144, time.1960-2005, institution.6(E、I、M、U、C), reference.3 02 05 11 )）

%E: ECWMF, I: IMF-GEOM, 
%M: Meteo-France, U: UK_Met_Office, 
%C: CMCC-Bologna

%创建PRLR_02系列数据 
PRLR_02_E=rand(73,144,46); 
PRLR_02_I=rand(73,144,46);
PRLR_02_M=rand(73,144,46);
PRLR_02_U=rand(73,144,46);
PRLR_02_C=rand(73,144,46);
PRLR_02=rand(73,144,46);
%创建PRLR_05系列数据 
PRLR_05_E=rand(73,144,46); 
PRLR_05_I=rand(73,144,46);
PRLR_05_M=rand(73,144,46);
PRLR_05_U=rand(73,144,46);
PRLR_05_C=rand(73,144,46);
PRLR_05=rand(73,144,46);

%创建PRLR_08系列数据 
PRLR_08_E=rand(73,144,46); 
PRLR_08_I=rand(73,144,46);
PRLR_08_M=rand(73,144,46);
PRLR_08_U=rand(73,144,46);
PRLR_08_C=rand(73,144,46);
PRLR_08=rand(73,144,46);

%创建PRLR_11系列数据 
PRLR_11_E=rand(73,144,46); 
PRLR_11_I=rand(73,144,46);
PRLR_11_M=rand(73,144,46);
PRLR_11_U=rand(73,144,46);
PRLR_11_C=rand(73,144,46);
PRLR_11=rand(73,144,46);

%读取PRLR_02数据并做成员平均
for s=1:4:k-3
    filename=[datadir,filelist(s).name];
    filename;
    ncid=netcdf.open(filename,'NC_NOWRITE');
    LonData=ncread(filename,'longitude');
    LatData=ncread(filename,'latitude');
    TimeData=ncread(filename,'leadtime');
    %读取ECWMF数据并平均
    PRLRdata_E=ncread(filename,'prlr',[1 1 1 7],[144 73 9 1]); 
    %取相应模态的值 t time=June(4)
    PRLR_E=reshape(PRLRdata_E,[144 73 9]);
    PRLR_E_1=flipud(rot90(mean(PRLR_E,3)));%画图格式[73 144 time]
    PRLR_02_E(:,:,(s+3)/4)=PRLR_E_1(:,:);%按照时间填入（应该是+3/4）
    %读取IFM-GEOM数据并平均
    PRLRdata_I=ncread(filename,'prlr',[1 1 10 7],[144 73 9 1]);
    PRLR_I=reshape(PRLRdata_I,[144 73 9]);
    PRLR_I_1=flipud(rot90(mean(PRLR_I,3)));
    PRLR_02_I(:,:,(s+3)/4)=PRLR_I_1(:,:);
    %读取Meteo-France数据并平均
    PRLRdata_M=ncread(filename,'prlr',[1 1 19 7],[144 73 9 1]);
    PRLR_M=reshape(PRLRdata_M,[144 73 9]);
    PRLR_M_1=flipud(rot90(mean(PRLR_M,3)));
    PRLR_02_M(:,:,(s+3)/4)=PRLR_M_1(:,:);
    %读取UK_Met_Office数据并平均
    PRLRdata_U=ncread(filename,'prlr',[1 1 28 7],[144 73 9 1]);
    PRLR_U=reshape(PRLRdata_U,[144 73 9]);
    PRLR_U_1=flipud(rot90(mean(PRLR_U,3)));
    PRLR_02_U(:,:,(s+3)/4)=PRLR_U_1(:,:);
    %读取CMCC-Bologna数据并平均
    PRLRdata_C=ncread(filename,'prlr',[1 1 37 7],[144 73 9 1]);
    PRLR_C=reshape(PRLRdata_C,[144 73 9]);
    PRLR_C_1=flipud(rot90(mean(PRLR_C,3)));
    PRLR_02_C(:,:,(s+3)/4)=PRLR_C_1(:,:);
    %读取所有Ensemble数据
    PRLRdata=ncread(filename,'prlr',[1 1 1 7],[144 73 45 1]);
    PRLR=reshape(PRLRdata,[144 73 45]);
    PRLR_1=flipud(rot90(mean(PRLR,3)));
    PRLR_02(:,:,(s+3)/4)=PRLR_1(:,:);
end
%读取PRLR_05数据并做成员平均
for s=2:4:k-2
    filename=[datadir,filelist(s).name];
    ncid=netcdf.open(filename,'NC_NOWRITE');
    LonData=ncread(filename,'longitude');
    LatData=ncread(filename,'latitude');
    TimeData=ncread(filename,'leadtime');
    %读取ECWMF数据并平均
    PRLRdata_E=ncread(filename,'prlr',[1 1 1 4 ],[144 73 9 1]); 
    %取相应模态的值 其中level=850(1), time=June(4)
    PRLR_E=reshape(PRLRdata_E,[144 73 9]);
    PRLR_E_1=flipud(rot90(mean(PRLR_E,3)));%画图格式[73 144 time]
    PRLR_05_E(:,:,(s+2)/4)=PRLR_E_1(:,:);%按照时间填入（应该是+3/4）
    %读取IFM-GEOM数据并平均
    PRLRdata_I=ncread(filename,'prlr',[1 1 10 4],[144 73 9 1]);
    PRLR_I=reshape(PRLRdata_I,[144 73 9]);
    PRLR_I_1=flipud(rot90(mean(PRLR_I,3)));
    PRLR_05_I(:,:,(s+2)/4)=PRLR_I_1(:,:);
    %读取Meteo-France数据并平均
    PRLRdata_M=ncread(filename,'prlr',[1 1 19 4],[144 73 9 1]);
    PRLR_M=reshape(PRLRdata_M,[144 73 9]);
    PRLR_M_1=flipud(rot90(mean(PRLR_M,3)));
    PRLR_05_M(:,:,(s+2)/4)=PRLR_M_1(:,:);
    %读取UK_Met_Office数据并平均
    PRLRdata_U=ncread(filename,'prlr',[1 1 28 4],[144 73 9 1]);
    PRLR_U=reshape(PRLRdata_U,[144 73 9]);
    PRLR_U_1=flipud(rot90(mean(PRLR_U,3)));
    PRLR_05_U(:,:,(s+2)/4)=PRLR_U_1(:,:);
    %读取CMCC-Bologna数据并平均
    PRLRdata_C=ncread(filename,'prlr',[1 1 37 4],[144 73 9 1]);
    PRLR_C=reshape(PRLRdata_C,[144 73 9]);
    PRLR_C_1=flipud(rot90(mean(PRLR_C,3)));
    PRLR_05_C(:,:,(s+2)/4)=PRLR_C_1(:,:);
    %读取所有Ensemble数据
    PRLRdata=ncread(filename,'prlr',[1 1 1 4],[144 73 45 1]);
    PRLR=reshape(PRLRdata,[144 73 45]);
    PRLR_1=flipud(rot90(mean(PRLR,3)));
    PRLR_05(:,:,(s+2)/4)=PRLR_1(:,:);
end
%读取PRLR_08数据并做成员平均

for s=3:4:k-1
    filename=[datadir,filelist(s).name];
    ncid=netcdf.open(filename,'NC_NOWRITE');
    LonData=ncread(filename,'longitude');
    LatData=ncread(filename,'latitude');
    TimeData=ncread(filename,'leadtime');
    %读取ECWMF数据并平均
    PRLRdata_E=ncread(filename,'prlr',[1 1 1 1],[144 73 9 1]); 
    %取相应模态的值 其中level=850(1), time=June(4)
    PRLR_E=reshape(PRLRdata_E,[144 73 9]);
    PRLR_E_1=flipud(rot90(mean(PRLR_E,3)));%画图格式[73 144 time]
    PRLR_08_E(:,:,(s+1)/4)=PRLR_E_1(:,:);%按照时间填入（应该是+3/4）
    %读取IFM-GEOM数据并平均
    PRLRdata_I=ncread(filename,'prlr',[1 1 10 1],[144 73 9 1]);
    PRLR_I=reshape(PRLRdata_I,[144 73 9]);
    PRLR_I_1=flipud(rot90(mean(PRLR_I,3)));
    PRLR_08_I(:,:,(s+1)/4)=PRLR_I_1(:,:);
    %读取Meteo-France数据并平均
    PRLRdata_M=ncread(filename,'prlr',[1 1 19 1],[144 73 9 1]);
    PRLR_M=reshape(PRLRdata_M,[144 73 9]);
    PRLR_M_1=flipud(rot90(mean(PRLR_M,3)));
    PRLR_08_M(:,:,(s+1)/4)=PRLR_M_1(:,:);
    %读取UK_Met_Office数据并平均
    PRLRdata_U=ncread(filename,'prlr',[1 1 28 1],[144 73 9 1]);
    PRLR_U=reshape(PRLRdata_U,[144 73 9]);
    PRLR_U_1=flipud(rot90(mean(PRLR_U,3)));
    PRLR_08_U(:,:,(s+1)/4)=PRLR_U_1(:,:);
    %读取CMCC-Bologna数据并平均
    PRLRdata_C=ncread(filename,'prlr',[1 1 37 1],[144 73 9 1]);
    PRLR_C=reshape(PRLRdata_C,[144 73 9]);
    PRLR_C_1=flipud(rot90(mean(PRLR_C,3)));
    PRLR_08_C(:,:,(s+1)/4)=PRLR_C_1(:,:);
    %读取所有Ensemble数据
    PRLRdata=ncread(filename,'prlr',[1 1 1 1],[144 73 45 1]);
    PRLR=reshape(PRLRdata,[144 73 45]);
    PRLR_1=flipud(rot90(mean(PRLR,3)));
    PRLR_08(:,:,(s+1)/4)=PRLR_1(:,:);
end

%读取PRLR_11数据并做成员平均
for s=4:4:k
    filename=[datadir,filelist(s).name];
    ncid=netcdf.open(filename,'NC_NOWRITE');
    LonData=ncread(filename,'longitude');
    LatData=ncread(filename,'latitude');
    TimeData=ncread(filename,'leadtime');
    %读取ECWMF数据并平均
    PRLRdata_E=ncread(filename,'prlr',[1 1 1 10],[144 73 9 1]); 
    %取相应模态的值 其中level=850(1), time=June(4)
    PRLR_E=reshape(PRLRdata_E,[144 73 9]);
    PRLR_E_1=flipud(rot90(mean(PRLR_E,3)));%画图格式[73 144 time]
    PRLR_11_E(:,:,(s+0)/4)=PRLR_E_1(:,:);%按照时间填入（应该是+3/4）
    %读取IFM-GEOM数据并平均
    PRLRdata_I=ncread(filename,'prlr',[1 1 10 10],[144 73 9 1]);
    PRLR_I=reshape(PRLRdata_I,[144 73 9]);
    PRLR_I_1=flipud(rot90(mean(PRLR_I,3)));
    PRLR_11_I(:,:,(s+0)/4)=PRLR_I_1(:,:);
    %读取Meteo-France数据并平均
    PRLRdata_M=ncread(filename,'prlr',[1 1  19 10],[144 73 9 1]);
    PRLR_M=reshape(PRLRdata_M,[144 73 9]);
    PRLR_M_1=flipud(rot90(mean(PRLR_M,3)));
    PRLR_11_M(:,:,(s+0)/4)=PRLR_M_1(:,:);
    %读取UK_Met_Office数据并平均
    PRLRdata_U=ncread(filename,'prlr',[1 1 28 10],[144 73 9 1]);
    PRLR_U=reshape(PRLRdata_U,[144 73 9]);
    PRLR_U_1=flipud(rot90(mean(PRLR_U,3)));
    PRLR_11_U(:,:,(s+0)/4)=PRLR_U_1(:,:);
    %读取CMCC-Bologna数据并平均
    PRLRdata_C=ncread(filename,'prlr',[1 1 37 10],[144 73 9 1]);
    PRLR_C=reshape(PRLRdata_C,[144 73 9]);
    PRLR_C_1=flipud(rot90(mean(PRLR_C,3)));
    PRLR_11_C(:,:,(s+0)/4)=PRLR_C_1(:,:);
    %读取所有Ensemble数据
    PRLRdata=ncread(filename,'prlr',[1 1 2 10],[144 73 45 1]);
    PRLR=reshape(PRLRdata,[144 73 45]);
    PRLR_1=flipud(rot90(mean(PRLR,3)));
    PRLR_11(:,:,(s+0)/4)=PRLR_1(:,:);
end
PRLR=rand(73,144,46,6,4);
%创建6个成员的集合 Var_PRLR
%填充20数据
PRLR(:,:,:,1,1)=PRLR_02_E;
PRLR(:,:,:,2,1)=PRLR_02_I;
PRLR(:,:,:,3,1)=PRLR_02_M;
PRLR(:,:,:,4,1)=PRLR_02_U;
PRLR(:,:,:,5,1)=PRLR_02_C;
PRLR(:,:,:,6,1)=PRLR_02;
%填充05数据
PRLR(:,:,:,1,2)=PRLR_05_E;
PRLR(:,:,:,2,2)=PRLR_05_I;
PRLR(:,:,:,3,2)=PRLR_05_M;
PRLR(:,:,:,4,2)=PRLR_05_U;
PRLR(:,:,:,5,2)=PRLR_05_C;
PRLR(:,:,:,6,2)=PRLR_05;

%填充08数据
PRLR(:,:,:,1,3)=PRLR_08_E;
PRLR(:,:,:,2,3)=PRLR_08_I;
PRLR(:,:,:,3,3)=PRLR_08_M;
PRLR(:,:,:,4,3)=PRLR_08_U;
PRLR(:,:,:,5,3)=PRLR_08_C;
PRLR(:,:,:,6,3)=PRLR_08;

%填充11数据
PRLR(:,:,:,1,4)=PRLR_11_E;
PRLR(:,:,:,2,4)=PRLR_11_I;
PRLR(:,:,:,3,4)=PRLR_11_M;
PRLR(:,:,:,4,4)=PRLR_11_U;
PRLR(:,:,:,5,4)=PRLR_11_C;
PRLR(:,:,:,6,4)=PRLR_11;

ncid2=netcdf.create('./Ensemble/228EnsembleApril.nc','clobber');
        % Create NetCDF file,输入文件名.
lon=netcdf.defDim(ncid2,'longitude',144);%定义维
lat=netcdf.defDim(ncid2,'latitude',73);
time=netcdf.defDim(ncid2,'time',46);
id=netcdf.defDim(ncid2,'institude',6);
ref=netcdf.defDim(ncid2,'reference',4);
PRLR_NC=netcdf.defVar(ncid2,'prlr','double',[lat lon time id ref]);%定义变量
netcdf.endDef(ncid2);%关闭定义
netcdf.putVar(ncid2,PRLR_NC,PRLR);%填值
netcdf.close(ncid2);

clear PRLR_E PRLR_I PRLR_M PRLR_U PRLR_C ;
clear PRLR_E_1 PRLR_I_1 PRLR_M_1 PRLR_U_1 PRLR_C_1 ; 
clear PRLRdata_E PRLRdata_I PRLRdata_M PRLRdata_U PRLRdata_C