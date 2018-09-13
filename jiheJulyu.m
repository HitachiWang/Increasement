%this program is for jiheuybao 

clear all;
clc;

datadir='./Ensemble/132/'; %指定批量数据所在文件
filelist=dir([datadir,'*.nc']);

a=filelist(1).name;
b=filelist(2).name;
k=length(filelist);

%创建ua850数据（ua850(lat.73, lon.144, time.1960-2005, institution.6(E、I、M、U、C), referencr.3 02 05 11 )）
V_850=rand(73,144,46,6,3);
%E: ECWMF, I: IMF-GEOM, 
%M: Meteo-France, U: UK_Met_Office, 
%C: CMCC-Bologna

%创建G_02系列数据 
V_02_E=rand(73,144,4); 
V_02_I=rand(73,144,4);
V_02_M=rand(73,144,4);
V_02_U=rand(73,144,4);
V_02_C=rand(73,144,4);
V_02=rand(73,144,4);
%创建V_05系列数据 
V_05_E=rand(73,144,4); 
V_05_I=rand(73,144,4);
V_05_M=rand(73,144,4);
V_05_U=rand(73,144,4);
V_05_C=rand(73,144,4);
V_05=rand(73,144,4);
%{
%创建V_08系列数据 
V_08_E=rand(73,144,4); 
V_08_I=rand(73,144,4);
V_08_M=rand(73,144,4);
V_08_U=rand(73,144,4);
V_08_C=rand(73,144,4);
V_08=rand(73,144,4);
%}
%创建V_11系列数据 
V_11_E=rand(73,144,4); 
V_11_I=rand(73,144,4);
V_11_M=rand(73,144,4);
V_11_U=rand(73,144,4);
V_11_C=rand(73,144,4);
V_11=rand(73,144,4);

%读取V_02数据并做成员平均
for s=1:4:k-3
    filename=[datadir,filelist(s).name];
    filename;
    ncid=netcdf.open(filename,'NC_NOWRITE');
    LonData=ncread(filename,'longitude');
    LatData=ncread(filename,'latitude');
    TimeData=ncread(filename,'leadtime');
    %读取ECWMF数据并平均
    Vdata_E=ncread(filename,'va',[1 1 1 1 6],[144 73 1 9 1]); 
    %取相应模态的值 其中level=850(1), time=June(4)
    V_E=reshape(Vdata_E,[144 73 9]);
    V_E_1=flipud(rot90(mean(V_E,3)));%画图格式[73 144 time]
    V_02_E(:,:,(s+3)/4)=V_E_1(:,:);%按照时间填入（应该是+3/4）
    %读取IFM-GEOM数据并平均
    Vdata_I=ncread(filename,'va',[1 1 1 10 6],[144 73 1 9 1]);
    V_I=reshape(Vdata_I,[144 73 9]);
    V_I_1=flipud(rot90(mean(V_I,3)));
    V_02_I(:,:,(s+3)/4)=V_I_1(:,:);
    %读取Meteo-France数据并平均
    Vdata_M=ncread(filename,'va',[1 1 1 19 6],[144 73 1 9 1]);
    V_M=reshape(Vdata_M,[144 73 9]);
    V_M_1=flipud(rot90(mean(V_M,3)));
    V_02_M(:,:,(s+3)/4)=V_M_1(:,:);
    %读取UK_Met_Office数据并平均
    Vdata_U=ncread(filename,'va',[1 1 1 28 6],[144 73 1 9 1]);
    V_U=reshape(Vdata_U,[144 73 9]);
    V_U_1=flipud(rot90(mean(V_U,3)));
    V_02_U(:,:,(s+3)/4)=V_U_1(:,:);
    %读取CMCC-Bologna数据并平均
    Vdata_C=ncread(filename,'va',[1 1 1 37 6],[144 73 1 9 1]);
    V_C=reshape(Vdata_C,[144 73 9]);
    V_C_1=flipud(rot90(mean(V_C,3)));
    V_02_C(:,:,(s+3)/4)=V_C_1(:,:);
    %读取所有Ensemble数据
    Vdata=ncread(filename,'va',[1 1 1 1 6],[144 73 1 45 1]);
    V=reshape(Vdata,[144 73 45]);
    V_1=flipud(rot90(mean(V,3)));
    V_02(:,:,(s+3)/4)=V_1(:,:);
end
%读取V_05数据并做成员平均
for s=2:4:k-2
    filename=[datadir,filelist(s).name];
    ncid=netcdf.open(filename,'NC_NOWRITE');
    LonData=ncread(filename,'longitude');
    LatData=ncread(filename,'latitude');
    TimeData=ncread(filename,'leadtime');
    %读取ECWMF数据并平均
    Vdata_E=ncread(filename,'va',[1 1 1 1 3 ],[144 73 1 9 1]); 
    %取相应模态的值 其中level=850(1), time=June(4)
    V_E=reshape(Vdata_E,[144 73 9]);
    V_E_1=flipud(rot90(mean(V_E,3)));%画图格式[73 144 time]
    V_05_E(:,:,(s+2)/4)=V_E_1(:,:);%按照时间填入（应该是+3/4）
    %读取IFM-GEOM数据并平均
    Vdata_I=ncread(filename,'va',[1 1 1 10 3],[144 73 1 9 1]);
    V_I=reshape(Vdata_I,[144 73 9]);
    V_I_1=flipud(rot90(mean(V_I,3)));
    V_05_I(:,:,(s+2)/4)=V_I_1(:,:);
    %读取Meteo-France数据并平均
    Vdata_M=ncread(filename,'va',[1 1 1 19 3],[144 73 1 9 1]);
    V_M=reshape(Vdata_M,[144 73 9]);
    V_M_1=flipud(rot90(mean(V_M,3)));
    V_05_M(:,:,(s+2)/4)=V_M_1(:,:);
    %读取UK_Met_Office数据并平均
    Vdata_U=ncread(filename,'va',[1 1 1 28 3],[144 73 1 9 1]);
    V_U=reshape(Vdata_U,[144 73 9]);
    V_U_1=flipud(rot90(mean(V_U,3)));
    V_05_U(:,:,(s+2)/4)=V_U_1(:,:);
    %读取CMCC-Bologna数据并平均
    Vdata_C=ncread(filename,'va',[1 1 1 37 3],[144 73 1 9 1]);
    V_C=reshape(Vdata_C,[144 73 9]);
    V_C_1=flipud(rot90(mean(V_C,3)));
    V_05_C(:,:,(s+2)/4)=V_C_1(:,:);
    %读取所有Ensemble数据
    Vdata=ncread(filename,'va',[1 1 1 1 3],[144 73 1 45 1]);
    V=reshape(Vdata,[144 73 45]);
    V_1=flipud(rot90(mean(V,3)));
    V_05(:,:,(s+2)/4)=V_1(:,:);
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
    LonData=ncread(filename,'longitude');
    LatData=ncread(filename,'latitude');
    TimeData=ncread(filename,'leadtime');
    %读取ECWMF数据并平均
    Udata_E=ncread(filename,'va',[1 1 1 1 9],[144 73 1 9 1]); 
    %取相应模态的值 其中level=850(1), time=June(4)
    U_E=reshape(Udata_E,[144 73 9]);
    U_E_1=flipud(rot90(mean(U_E,3)));%画图格式[73 144 time]
    U_11_E(:,:,(s+0)/4)=U_E_1(:,:);%按照时间填入（应该是+3/4）
    %读取IFM-GEOM数据并平均
    Udata_I=ncread(filename,'va',[1 1 1 10 9],[144 73 1 9 1]);
    U_I=reshape(Udata_I,[144 73 9]);
    U_I_1=flipud(rot90(mean(U_I,3)));
    U_11_I(:,:,(s+0)/4)=U_I_1(:,:);
    %读取Meteo-France数据并平均
    Udata_M=ncread(filename,'va',[1 1 1 19 9],[144 73 1 9 1]);
    U_M=reshape(Udata_M,[144 73 9]);
    U_M_1=flipud(rot90(mean(U_M,3)));
    U_11_M(:,:,(s+0)/4)=U_M_1(:,:);
    %读取UK_Met_Office数据并平均
    Udata_U=ncread(filename,'ua',[1 1 1 28 9],[144 73 1 9 1]);
    U_U=reshape(Udata_U,[144 73 9]);
    U_U_1=flipud(rot90(mean(U_U,3)));
    U_11_U(:,:,(s+0)/4)=U_U_1(:,:);
    %读取CMCC-BoloUna数据并平均
    Udata_C=ncread(filename,'ua',[1 1 1 37 9],[144 73 1 9 1]);
    U_C=reshape(Udata_C,[144 73 9]);
    U_C_1=flipud(rot90(mean(U_C,3)));
    U_11_C(:,:,(s+0)/4)=U_C_1(:,:);
    %读取所有Ensemble数据
    Udata=ncread(filename,'ua',[1 1 1 1 9],[144 73 1 45 1]);
    U=reshape(Udata,[144 73 45]);
    U_1=flipud(rot90(mean(U,3)));
    U_11(:,:,(s+0)/4)=U_1(:,:);
end

%创建6个成员的集合 Var_U850
%填充20数据
V_850(:,:,:,1,1)=V_02_E;
V_850(:,:,:,2,1)=U_02_I;
V_850(:,:,:,3,1)=U_02_M;
V_850(:,:,:,4,1)=U_02_U;
V_850(:,:,:,5,1)=U_02_C;
V_850(:,:,:,6,1)=U_02;
%填充05数据
V_850(:,:,:,1,2)=U_05_E;
V_850(:,:,:,2,2)=U_05_I;
V_850(:,:,:,3,2)=U_05_M;
V_850(:,:,:,4,2)=U_05_U;
V_850(:,:,:,5,2)=U_05_C;
V_850(:,:,:,6,2)=U_05;
%填充11数据
V_850(:,:,:,1,3)=U_11_E;
V_850(:,:,:,2,3)=U_11_I;
V_850(:,:,:,3,3)=U_11_M;
V_850(:,:,:,4,3)=U_11_U;
V_850(:,:,:,5,3)=U_11_C;
V_850(:,:,:,6,3)=U_11;

ncid2=netcdf.create('./Ensemble/131EnsembleJuly.nc','clobber');
        % Create NetCDF file,输入文件名.
lon=netcdf.defDim(ncid2,'longitude',144);%定义维
lat=netcdf.defDim(ncid2,'latitude',73);
time=netcdf.defDim(ncid2,'time',46);
id=netcdf.defDim(ncid2,'institude',6);
ref=netcdf.defDim(ncid2,'reference',3);
u_850=netcdf.defVar(ncid2,'u850','double',[lat lon time id ref]);%定义变量
netcdf.endDef(ncid2);%关闭定义
netcdf.putVar(ncid2,u_850,V_850);%填值
netcdf.close(ncid2);

clear G_E G_I G_M G_U G_C ;
clear G_E_1 G_I_1 G_M_1 G_U_1 G_C_1 ; 
clear Gdata_E Gdata_I Gdata_M Gdata_U Gdata_C;