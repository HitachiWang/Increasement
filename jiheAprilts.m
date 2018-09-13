%this program is for jiheuybao

clear all;
clc;

datadir='./Ensemble/139/'; %指定批量数据所在文件
filelist=dir([datadir,'*.nc']);

a=filelist(1).name;
b=filelist(2).name;
k=length(filelist);

%创建TS数据（TS(lat.73, lon.144, time.1960-2005, institution.6(E、I、M、U、C), reference.3 02 05 11 )）

%E: ECWMF, I: IMF-GEOM, 
%M: Meteo-France, U: UK_Met_Office, 
%C: CMCC-Bologna

%创建TS_02系列数据 
TS_02_E=rand(73,144,46); 
TS_02_I=rand(73,144,46);
TS_02_M=rand(73,144,46);
TS_02_U=rand(73,144,46);
TS_02_C=rand(73,144,46);
TS_02=rand(73,144,46);
%创建TS_05系列数据 
TS_05_E=rand(73,144,46); 
TS_05_I=rand(73,144,46);
TS_05_M=rand(73,144,46);
TS_05_U=rand(73,144,46);
TS_05_C=rand(73,144,46);
TS_05=rand(73,144,46);

%创建TS_08系列数据 
TS_08_E=rand(73,144,46); 
TS_08_I=rand(73,144,46);
TS_08_M=rand(73,144,46);
TS_08_U=rand(73,144,46);
TS_08_C=rand(73,144,46);
TS_08=rand(73,144,46);

%创建TS_11系列数据 
TS_11_E=rand(73,144,46); 
TS_11_I=rand(73,144,46);
TS_11_M=rand(73,144,46);
TS_11_U=rand(73,144,46);
TS_11_C=rand(73,144,46);
TS_11=rand(73,144,46);

%读取TS_02数据并做成员平均
for s=1:4:k-3
    filename=[datadir,filelist(s).name];
    filename;
    ncid=netcdf.open(filename,'NC_NOWRITE');
    LonData=ncread(filename,'longitude');
    LatData=ncread(filename,'latitude');
    TimeData=ncread(filename,'leadtime');
    %读取ECWMF数据并平均
    TSdata_E=ncread(filename,'ts',[1 1 1 7],[144 73 9 1]); 
    %取相应模态的值 t time=June(4)
    TS_E=reshape(TSdata_E,[144 73 9]);
    TS_E_1=flipud(rot90(mean(TS_E,3)));%画图格式[73 144 time]
    TS_02_E(:,:,(s+3)/4)=TS_E_1(:,:);%按照时间填入（应该是+3/4）
    %读取IFM-GEOM数据并平均
    TSdata_I=ncread(filename,'ts',[1 1 10 7],[144 73 9 1]);
    TS_I=reshape(TSdata_I,[144 73 9]);
    TS_I_1=flipud(rot90(mean(TS_I,3)));
    TS_02_I(:,:,(s+3)/4)=TS_I_1(:,:);
    %读取Meteo-France数据并平均
    TSdata_M=ncread(filename,'ts',[1 1 19 7],[144 73 9 1]);
    TS_M=reshape(TSdata_M,[144 73 9]);
    TS_M_1=flipud(rot90(mean(TS_M,3)));
    TS_02_M(:,:,(s+3)/4)=TS_M_1(:,:);
    %读取UK_Met_Office数据并平均
    TSdata_U=ncread(filename,'ts',[1 1 28 7],[144 73 9 1]);
    TS_U=reshape(TSdata_U,[144 73 9]);
    TS_U_1=flipud(rot90(mean(TS_U,3)));
    TS_02_U(:,:,(s+3)/4)=TS_U_1(:,:);
    %读取CMCC-Bologna数据并平均
    TSdata_C=ncread(filename,'ts',[1 1 37 7],[144 73 9 1]);
    TS_C=reshape(TSdata_C,[144 73 9]);
    TS_C_1=flipud(rot90(mean(TS_C,3)));
    TS_02_C(:,:,(s+3)/4)=TS_C_1(:,:);
    %读取所有Ensemble数据
    TSdata=ncread(filename,'ts',[1 1 1 7],[144 73 45 1]);
    TS=reshape(TSdata,[144 73 45]);
    TS_1=flipud(rot90(mean(TS,3)));
    TS_02(:,:,(s+3)/4)=TS_1(:,:);
end
%读取TS_05数据并做成员平均
for s=2:4:k-2
    filename=[datadir,filelist(s).name];
    ncid=netcdf.open(filename,'NC_NOWRITE');
    LonData=ncread(filename,'longitude');
    LatData=ncread(filename,'latitude');
    TimeData=ncread(filename,'leadtime');
    %读取ECWMF数据并平均
    TSdata_E=ncread(filename,'ts',[1 1 1 4 ],[144 73 9 1]); 
    %取相应模态的值 其中level=850(1), time=June(4)
    TS_E=reshape(TSdata_E,[144 73 9]);
    TS_E_1=flipud(rot90(mean(TS_E,3)));%画图格式[73 144 time]
    TS_05_E(:,:,(s+2)/4)=TS_E_1(:,:);%按照时间填入（应该是+3/4）
    %读取IFM-GEOM数据并平均
    TSdata_I=ncread(filename,'ts',[1 1 10 4],[144 73 9 1]);
    TS_I=reshape(TSdata_I,[144 73 9]);
    TS_I_1=flipud(rot90(mean(TS_I,3)));
    TS_05_I(:,:,(s+2)/4)=TS_I_1(:,:);
    %读取Meteo-France数据并平均
    TSdata_M=ncread(filename,'ts',[1 1 19 4],[144 73 9 1]);
    TS_M=reshape(TSdata_M,[144 73 9]);
    TS_M_1=flipud(rot90(mean(TS_M,3)));
    TS_05_M(:,:,(s+2)/4)=TS_M_1(:,:);
    %读取UK_Met_Office数据并平均
    TSdata_U=ncread(filename,'ts',[1 1 28 4],[144 73 9 1]);
    TS_U=reshape(TSdata_U,[144 73 9]);
    TS_U_1=flipud(rot90(mean(TS_U,3)));
    TS_05_U(:,:,(s+2)/4)=TS_U_1(:,:);
    %读取CMCC-Bologna数据并平均
    TSdata_C=ncread(filename,'ts',[1 1 37 4],[144 73 9 1]);
    TS_C=reshape(TSdata_C,[144 73 9]);
    TS_C_1=flipud(rot90(mean(TS_C,3)));
    TS_05_C(:,:,(s+2)/4)=TS_C_1(:,:);
    %读取所有Ensemble数据
    TSdata=ncread(filename,'ts',[1 1 1 4],[144 73 45 1]);
    TS=reshape(TSdata,[144 73 45]);
    TS_1=flipud(rot90(mean(TS,3)));
    TS_05(:,:,(s+2)/4)=TS_1(:,:);
end
%读取TS_08数据并做成员平均

for s=3:4:k-1
    filename=[datadir,filelist(s).name];
    ncid=netcdf.open(filename,'NC_NOWRITE');
    LonData=ncread(filename,'longitude');
    LatData=ncread(filename,'latitude');
    TimeData=ncread(filename,'leadtime');
    %读取ECWMF数据并平均
    TSdata_E=ncread(filename,'ts',[1 1 1 1],[144 73 9 1]); 
    %取相应模态的值 其中level=850(1), time=June(4)
    TS_E=reshape(TSdata_E,[144 73 9]);
    TS_E_1=flipud(rot90(mean(TS_E,3)));%画图格式[73 144 time]
    TS_08_E(:,:,(s+1)/4)=TS_E_1(:,:);%按照时间填入（应该是+3/4）
    %读取IFM-GEOM数据并平均
    TSdata_I=ncread(filename,'ts',[1 1 10 1],[144 73 9 1]);
    TS_I=reshape(TSdata_I,[144 73 9]);
    TS_I_1=flipud(rot90(mean(TS_I,3)));
    TS_08_I(:,:,(s+1)/4)=TS_I_1(:,:);
    %读取Meteo-France数据并平均
    TSdata_M=ncread(filename,'ts',[1 1 19 1],[144 73 9 1]);
    TS_M=reshape(TSdata_M,[144 73 9]);
    TS_M_1=flipud(rot90(mean(TS_M,3)));
    TS_08_M(:,:,(s+1)/4)=TS_M_1(:,:);
    %读取UK_Met_Office数据并平均
    TSdata_U=ncread(filename,'ts',[1 1 28 1],[144 73 9 1]);
    TS_U=reshape(TSdata_U,[144 73 9]);
    TS_U_1=flipud(rot90(mean(TS_U,3)));
    TS_08_U(:,:,(s+1)/4)=TS_U_1(:,:);
    %读取CMCC-Bologna数据并平均
    TSdata_C=ncread(filename,'ts',[1 1 37 1],[144 73 9 1]);
    TS_C=reshape(TSdata_C,[144 73 9]);
    TS_C_1=flipud(rot90(mean(TS_C,3)));
    TS_08_C(:,:,(s+1)/4)=TS_C_1(:,:);
    %读取所有Ensemble数据
    TSdata=ncread(filename,'ts',[1 1 1 1],[144 73 45 1]);
    TS=reshape(TSdata,[144 73 45]);
    TS_1=flipud(rot90(mean(TS,3)));
    TS_08(:,:,(s+1)/4)=TS_1(:,:);
end

%读取TS_11数据并做成员平均
for s=4:4:k
    filename=[datadir,filelist(s).name];
    ncid=netcdf.open(filename,'NC_NOWRITE');
    LonData=ncread(filename,'longitude');
    LatData=ncread(filename,'latitude');
    TimeData=ncread(filename,'leadtime');
    %读取ECWMF数据并平均
    TSdata_E=ncread(filename,'ts',[1 1 1 10],[144 73 9 1]); 
    %取相应模态的值 其中level=850(1), time=June(4)
    TS_E=reshape(TSdata_E,[144 73 9]);
    TS_E_1=flipud(rot90(mean(TS_E,3)));%画图格式[73 144 time]
    TS_11_E(:,:,(s+0)/4)=TS_E_1(:,:);%按照时间填入（应该是+3/4）
    %读取IFM-GEOM数据并平均
    TSdata_I=ncread(filename,'ts',[1 1 10 10],[144 73 9 1]);
    TS_I=reshape(TSdata_I,[144 73 9]);
    TS_I_1=flipud(rot90(mean(TS_I,3)));
    TS_11_I(:,:,(s+0)/4)=TS_I_1(:,:);
    %读取Meteo-France数据并平均
    TSdata_M=ncread(filename,'ts',[1 1  19 10],[144 73 9 1]);
    TS_M=reshape(TSdata_M,[144 73 9]);
    TS_M_1=flipud(rot90(mean(TS_M,3)));
    TS_11_M(:,:,(s+0)/4)=TS_M_1(:,:);
    %读取UK_Met_Office数据并平均
    TSdata_U=ncread(filename,'ts',[1 1 28 10],[144 73 9 1]);
    TS_U=reshape(TSdata_U,[144 73 9]);
    TS_U_1=flipud(rot90(mean(TS_U,3)));
    TS_11_U(:,:,(s+0)/4)=TS_U_1(:,:);
    %读取CMCC-Bologna数据并平均
    TSdata_C=ncread(filename,'ts',[1 1 37 10],[144 73 9 1]);
    TS_C=reshape(TSdata_C,[144 73 9]);
    TS_C_1=flipud(rot90(mean(TS_C,3)));
    TS_11_C(:,:,(s+0)/4)=TS_C_1(:,:);
    %读取所有Ensemble数据
    TSdata=ncread(filename,'ts',[1 1 2 10],[144 73 45 1]);
    TS=reshape(TSdata,[144 73 45]);
    TS_1=flipud(rot90(mean(TS,3)));
    TS_11(:,:,(s+0)/4)=TS_1(:,:);
end
TS=rand(73,144,46,6,4);
%创建6个成员的集合 Var_TS
%填充20数据
TS(:,:,:,1,1)=TS_02_E;
TS(:,:,:,2,1)=TS_02_I;
TS(:,:,:,3,1)=TS_02_M;
TS(:,:,:,4,1)=TS_02_U;
TS(:,:,:,5,1)=TS_02_C;
TS(:,:,:,6,1)=TS_02;
%填充05数据
TS(:,:,:,1,2)=TS_05_E;
TS(:,:,:,2,2)=TS_05_I;
TS(:,:,:,3,2)=TS_05_M;
TS(:,:,:,4,2)=TS_05_U;
TS(:,:,:,5,2)=TS_05_C;
TS(:,:,:,6,2)=TS_05;
%填充08数据
TS(:,:,:,1,3)=TS_08_E;
TS(:,:,:,2,3)=TS_08_I;
TS(:,:,:,3,3)=TS_08_M;
TS(:,:,:,4,3)=TS_08_U;
TS(:,:,:,5,3)=TS_08_C;
TS(:,:,:,6,3)=TS_08;
%填充11数据
TS(:,:,:,1,4)=TS_11_E;
TS(:,:,:,2,4)=TS_11_I;
TS(:,:,:,3,4)=TS_11_M;
TS(:,:,:,4,4)=TS_11_U;
TS(:,:,:,5,4)=TS_11_C;
TS(:,:,:,6,4)=TS_11;

ncid2=netcdf.create('./Ensemble/139EnsembleApril.nc','clobber');
        % Create NetCDF file,输入文件名.
lon=netcdf.defDim(ncid2,'longitude',144);%定义维
lat=netcdf.defDim(ncid2,'latitude',73);
time=netcdf.defDim(ncid2,'time',46);
id=netcdf.defDim(ncid2,'institude',6);
ref=netcdf.defDim(ncid2,'reference',4);
TS_NC=netcdf.defVar(ncid2,'ts','double',[lat lon time id ref]);%定义变量
netcdf.endDef(ncid2);%关闭定义
netcdf.putVar(ncid2,TS_NC,TS);%填值
netcdf.close(ncid2);

clear TS_E TS_I TS_M TS_U TS_C ;
clear TS_E_1 TS_I_1 TS_M_1 TS_U_1 TS_C_1 ; 
clear TSdata_E TSdata_I TSdata_M TSdata_U TSdata_C;