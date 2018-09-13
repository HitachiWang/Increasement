%this program is for jiheuybao 

clear all;
clc;

datadir='./Ensemble/131/'; %指定批量数据所在文件
filelist=dir([datadir,'*.nc']);

a=filelist(1).name;
b=filelist(2).name;
k=length(filelist);

%创建ua850数据（ua850(lat.73, lon.144, time.1960-2005, institution.6(E、I、M、U、C), referencr.3 02 05 11 )）
U_850=rand(73,144,46,6,3);
%E: ECWMF, I: IMF-GEOM, 
%M: Meteo-France, U: UK_Met_Office, 
%C: CMCC-Bologna

%创建G_02系列数据 
U_02_E=rand(73,144,4); 
U_02_I=rand(73,144,4);
U_02_M=rand(73,144,4);
U_02_U=rand(73,144,4);
U_02_C=rand(73,144,4);
U_02=rand(73,144,4);
%创建U_05系列数据 
U_05_E=rand(73,144,4); 
U_05_I=rand(73,144,4);
U_05_M=rand(73,144,4);
U_05_U=rand(73,144,4);
U_05_C=rand(73,144,4);
U_05=rand(73,144,4);
%{
%创建U_08系列数据 
U_08_E=rand(73,144,4); 
U_08_I=rand(73,144,4);
U_08_M=rand(73,144,4);
U_08_U=rand(73,144,4);
U_08_C=rand(73,144,4);
U_08=rand(73,144,4);
%}
%创建U_11系列数据 
U_11_E=rand(73,144,4); 
U_11_I=rand(73,144,4);
U_11_M=rand(73,144,4);
U_11_U=rand(73,144,4);
U_11_C=rand(73,144,4);
U_11=rand(73,144,4);

%读取U_02数据并做成员平均
for s=1:4:k-3
    filename=[datadir,filelist(s).name];
    filename;
    ncid=netcdf.open(filename,'NC_NOWRITE');
    LonData=ncread(filename,'longitude');
    LatData=ncread(filename,'latitude');
    TimeData=ncread(filename,'leadtime');
    %读取ECWMF数据并平均
    Udata_E=ncread(filename,'ua',[1 1 1 1 5],[144 73 1 9 1]); 
    %取相应模态的值 其中level=850(1), time=June(4)
    U_E=reshape(Udata_E,[144 73 9]);
    U_E_1=flipud(rot90(mean(U_E,3)));%画图格式[73 144 time]
    U_02_E(:,:,(s+3)/4)=U_E_1(:,:);%按照时间填入（应该是+3/4）
    %读取IFM-GEOM数据并平均
    Udata_I=ncread(filename,'ua',[1 1 1 10 5],[144 73 1 9 1]);
    U_I=reshape(Udata_I,[144 73 9]);
    U_I_1=flipud(rot90(mean(U_I,3)));
    U_02_I(:,:,(s+3)/4)=U_I_1(:,:);
    %读取Meteo-France数据并平均
    Udata_M=ncread(filename,'ua',[1 1 1 19 5],[144 73 1 9 1]);
    U_M=reshape(Udata_M,[144 73 9]);
    U_M_1=flipud(rot90(mean(U_M,3)));
    U_02_M(:,:,(s+3)/4)=U_M_1(:,:);
    %读取UK_Met_Office数据并平均
    Udata_U=ncread(filename,'ua',[1 1 1 28 5],[144 73 1 9 1]);
    U_U=reshape(Udata_U,[144 73 9]);
    U_U_1=flipud(rot90(mean(U_U,3)));
    U_02_U(:,:,(s+3)/4)=U_U_1(:,:);
    %读取CMCC-Bologna数据并平均
    Udata_C=ncread(filename,'ua',[1 1 1 37 5],[144 73 1 9 1]);
    U_C=reshape(Udata_C,[144 73 9]);
    U_C_1=flipud(rot90(mean(U_C,3)));
    U_02_C(:,:,(s+3)/4)=U_C_1(:,:);
    %读取所有Ensemble数据
    Udata=ncread(filename,'ua',[1 1 1 1 5],[144 73 1 45 1]);
    U=reshape(Udata,[144 73 45]);
    U_1=flipud(rot90(mean(U,3)));
    U_02(:,:,(s+3)/4)=U_1(:,:);
end
%读取U_05数据并做成员平均
for s=2:4:k-2
    filename=[datadir,filelist(s).name];
    ncid=netcdf.open(filename,'NC_NOWRITE');
    LonData=ncread(filename,'longitude');
    LatData=ncread(filename,'latitude');
    TimeData=ncread(filename,'leadtime');
    %读取ECWMF数据并平均
    Udata_E=ncread(filename,'ua',[1 1 1 1 2 ],[144 73 1 9 1]); 
    %取相应模态的值 其中level=850(1), time=June(4)
    U_E=reshape(Udata_E,[144 73 9]);
    U_E_1=flipud(rot90(mean(U_E,3)));%画图格式[73 144 time]
    U_05_E(:,:,(s+2)/4)=U_E_1(:,:);%按照时间填入（应该是+3/4）
    %读取IFM-GEOM数据并平均
    Udata_I=ncread(filename,'ua',[1 1 1 10 2],[144 73 1 9 1]);
    U_I=reshape(Udata_I,[144 73 9]);
    U_I_1=flipud(rot90(mean(U_I,3)));
    U_05_I(:,:,(s+2)/4)=U_I_1(:,:);
    %读取Meteo-France数据并平均
    Udata_M=ncread(filename,'ua',[1 1 1 19 2],[144 73 1 9 1]);
    U_M=reshape(Udata_M,[144 73 9]);
    U_M_1=flipud(rot90(mean(U_M,3)));
    U_05_M(:,:,(s+2)/4)=U_M_1(:,:);
    %读取UK_Met_Office数据并平均
    Udata_U=ncread(filename,'ua',[1 1 1 28 2],[144 73 1 9 1]);
    U_U=reshape(Udata_U,[144 73 9]);
    U_U_1=flipud(rot90(mean(U_U,3)));
    U_05_U(:,:,(s+2)/4)=U_U_1(:,:);
    %读取CMCC-Bologna数据并平均
    Udata_C=ncread(filename,'ua',[1 1 1 37 2],[144 73 1 9 1]);
    U_C=reshape(Udata_C,[144 73 9]);
    U_C_1=flipud(rot90(mean(U_C,3)));
    U_05_C(:,:,(s+2)/4)=U_C_1(:,:);
    %读取所有Ensemble数据
    Udata=ncread(filename,'ua',[1 1 1 1 2],[144 73 1 45 1]);
    U=reshape(Udata,[144 73 45]);
    U_1=flipud(rot90(mean(U,3)));
    U_05(:,:,(s+2)/4)=U_1(:,:);
end
%读取U_08数据并做成员平均
%{
for s=3:4:k-1
    filename=[datadir,filelist(s).name];
    ncid=netcdf.open(filename,'NC_NOWRITE');
    LonData=ncread(filename,'longitude');
    LatData=ncread(filename,'latitude');
    TimeData=ncread(filename,'leadtime');
    %读取ECWMF数据并平均
    Udata_E=ncread(filename,'ua',[1 1 1 1 4],[144 73 1 9 1]); 
    %取相应模态的值 其中level=850(1), time=June(4)
    U_E=reshape(Udata_E,[144 73 9]);
    U_E_1=flipud(rot90(mean(U_E,3)));%画图格式[73 144 time]
    U_08_E(:,:,(s+3)/4)=U_E_1(:,:);%按照时间填入（应该是+3/4）
    %读取IFM-GEOM数据并平均
    Udata_I=ncread(filename,'ua',[1 1 1 10 4],[144 73 1 9 1]);
    U_I=reshape(Udata_I,[144 73 9]);
    U_I_1=flipud(rot90(mean(U_I,3)));
    U_08_I(:,:,(s+3)/4)=U_I_1(:,:);
    %读取Meteo-France数据并平均
    Udata_M=ncread(filename,'ua',[1 1 1 19 4],[144 73 1 9 1]);
    U_M=reshape(Udata_M,[144 73 9]);
    U_M_1=flipud(rot90(mean(U_M,3)));
    U_08_M(:,:,(s+3)/4)=U_M_1(:,:);
    %读取UK_Met_Office数据并平均
    Udata_U=ncread(filename,'ua',[1 1 1 28 4],[144 73 1 9 1]);
    U_U=reshape(Udata_U,[144 73 9]);
    U_U_1=flipud(rot90(mean(U_U,3)));
    U_08_U(:,:,(s+3)/4)=U_U_1(:,:);
    %读取CMCC-Bologna数据并平均
    Udata_C=ncread(filename,'ua',[1 1 1 37 4],[144 73 1 9 1]);
    U_C=reshape(Udata_C,[144 73 9]);
    U_C_1=flipud(rot90(mean(U_C,3)));
    U_08_C(:,:,(s+3)/4)=U_C_1(:,:);
    %读取所有Ensemble数据
    Udata=ncread(filename,'ua',[1 1 1 1 4],[144 73 1 45 1]);
    U=reshape(Udata,[144 73 45]);
    U_1=flipud(rot90(mean(U,3)));
    U_08(:,:,(s+3)/4)=U_1(:,:);
end
%}
%读取U_11数据并做成员平均
for s=4:4:k
    filename=[datadir,filelist(s).name];
    ncid=netcdf.open(filename,'NC_NOWRITE');
    LonData=ncread(filename,'lonUitude');
    LatData=ncread(filename,'latitude');
    TimeData=ncread(filename,'leadtime');
    %读取ECWMF数据并平均
    Udata_E=ncread(filename,'ua',[1 1 1 1 8],[144 73 1 9 1]); 
    %取相应模态的值 其中level=850(1), time=June(4)
    U_E=reshape(Udata_E,[144 73 9]);
    U_E_1=flipud(rot90(mean(U_E,3)));%画图格式[73 144 time]
    U_11_E(:,:,(s+0)/4)=U_E_1(:,:);%按照时间填入（应该是+3/4）
    %读取IFM-GEOM数据并平均
    Udata_I=ncread(filename,'ua',[1 1 1 10 8],[144 73 1 9 1]);
    U_I=reshape(Udata_I,[144 73 9]);
    U_I_1=flipud(rot90(mean(U_I,3)));
    U_11_I(:,:,(s+0)/4)=U_I_1(:,:);
    %读取Meteo-France数据并平均
    Udata_M=ncread(filename,'ua',[1 1 1 19 8],[144 73 1 9 1]);
    U_M=reshape(Udata_M,[144 73 9]);
    U_M_1=flipud(rot90(mean(U_M,3)));
    U_11_M(:,:,(s+0)/4)=U_M_1(:,:);
    %读取UK_Met_Office数据并平均
    Udata_U=ncread(filename,'ua',[1 1 1 28 8],[144 73 1 9 1]);
    U_U=reshape(Udata_U,[144 73 9]);
    U_U_1=flipud(rot90(mean(U_U,3)));
    U_11_U(:,:,(s+0)/4)=U_U_1(:,:);
    %读取CMCC-BoloUna数据并平均
    Udata_C=ncread(filename,'ua',[1 1 1 37 8],[144 73 1 9 1]);
    U_C=reshape(Udata_C,[144 73 9]);
    U_C_1=flipud(rot90(mean(U_C,3)));
    U_11_C(:,:,(s+0)/4)=U_C_1(:,:);
    %读取所有Ensemble数据
    Udata=ncread(filename,'ua',[1 1 1 1 8],[144 73 1 45 1]);
    U=reshape(Udata,[144 73 45]);
    U_1=flipud(rot90(mean(U,3)));
    U_11(:,:,(s+0)/4)=U_1(:,:);
end

%创建6个成员的集合 Var_U850
%填充20数据
U_850(:,:,:,1,1)=U_02_E;
U_850(:,:,:,2,1)=U_02_I;
U_850(:,:,:,3,1)=U_02_M;
U_850(:,:,:,4,1)=U_02_U;
U_850(:,:,:,5,1)=U_02_C;
U_850(:,:,:,6,1)=U_02;
%填充05数据
U_850(:,:,:,1,2)=U_05_E;
U_850(:,:,:,2,2)=U_05_I;
U_850(:,:,:,3,2)=U_05_M;
U_850(:,:,:,4,2)=U_05_U;
U_850(:,:,:,5,2)=U_05_C;
U_850(:,:,:,6,2)=U_05;
%填充11数据
U_850(:,:,:,1,3)=U_11_E;
U_850(:,:,:,2,3)=U_11_I;
U_850(:,:,:,3,3)=U_11_M;
U_850(:,:,:,4,3)=U_11_U;
U_850(:,:,:,5,3)=U_11_C;
U_850(:,:,:,6,3)=U_11;

ncid2=netcdf.create('./Ensemble/131EnsembleJune.nc','clobber');
        % Create NetCDF file,输入文件名.
lon=netcdf.defDim(ncid2,'longitude',144);%定义维
lat=netcdf.defDim(ncid2,'latitude',73);
time=netcdf.defDim(ncid2,'time',46);
id=netcdf.defDim(ncid2,'institude',6);
ref=netcdf.defDim(ncid2,'reference',3);
U_850=netcdf.defVar(ncid2,'u850','double',[lat lon time id ref]);%定义变量
netcdf.endDef(ncid2);%关闭定义
netcdf.putVar(ncid2,u_850,U_850);%填值
netcdf.close(ncid2);

clear G_E G_I G_M G_U G_C ;
clear G_E_1 G_I_1 G_M_1 G_U_1 G_C_1 ; 
clear Gdata_E Gdata_I Gdata_M Gdata_U Gdata_C;