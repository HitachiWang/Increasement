%this program is for jiheuybao

clear all;
clc;

datadir='./Ensemble/131/'; %指定批量数据所在文件
filelist=dir([datadir,'*.nc']);

a=filelist(1).name;
b=filelist(2).name;
k=length(filelist);

%创建g500数据（g500(lat.73, lon.144, time.1960-2005, institution.6(E、I、M、U、C), referencr.3 02 05 11 )）
G_500=rand(73,144,46,6,3);
%E: ECWMF, I: IMF-GEOM, 
%M: Meteo-France, U: UK_Met_Office, 
%C: CMCC-Bologna

%创建G_02系列数据 
G_02_E=rand(73,144,4); 
G_02_I=rand(73,144,4);
G_02_M=rand(73,144,4);
G_02_U=rand(73,144,4);
G_02_C=rand(73,144,4);
G_02=rand(73,144,4);
%创建G_05系列数据 
G_05_E=rand(73,144,4); 
G_05_I=rand(73,144,4);
G_05_M=rand(73,144,4);
G_05_U=rand(73,144,4);
G_05_C=rand(73,144,4);
G_05=rand(73,144,4);
%{
%创建G_08系列数据 
G_08_E=rand(73,144,4); 
G_08_I=rand(73,144,4);
G_08_M=rand(73,144,4);
G_08_U=rand(73,144,4);
G_08_C=rand(73,144,4);
G_08=rand(73,144,4);
%}
%创建G_11系列数据 
G_11_E=rand(73,144,4); 
G_11_I=rand(73,144,4);
G_11_M=rand(73,144,4);
G_11_U=rand(73,144,4);
G_11_C=rand(73,144,4);
G_11=rand(73,144,4);

%读取G_02数据并做成员平均
for s=1:4:k-3
    filename=[datadir,filelist(s).name];
    filename;
    ncid=netcdf.open(filename,'NC_NOWRITE');
    LonData=ncread(filename,'longitude');
    LatData=ncread(filename,'latitude');
    TimeData=ncread(filename,'leadtime');
    %读取ECWMF数据并平均
    Gdata_E=ncread(filename,'ua',[1 1 2 1 5],[144 73 1 9 1]); 
    %取相应模态的值 其中level=850(1), time=June(4)
    G_E=reshape(Gdata_E,[144 73 9]);
    G_E_1=flipud(rot90(mean(G_E,3)));%画图格式[73 144 time]
    G_02_E(:,:,(s+3)/4)=G_E_1(:,:);%按照时间填入（应该是+3/4）
    %读取IFM-GEOM数据并平均
    Gdata_I=ncread(filename,'ua',[1 1 2 10 5],[144 73 1 9 1]);
    G_I=reshape(Gdata_I,[144 73 9]);
    G_I_1=flipud(rot90(mean(G_I,3)));
    G_02_I(:,:,(s+3)/4)=G_I_1(:,:);
    %读取Meteo-France数据并平均
    Gdata_M=ncread(filename,'ua',[1 1 2 19 5],[144 73 1 9 1]);
    G_M=reshape(Gdata_M,[144 73 9]);
    G_M_1=flipud(rot90(mean(G_M,3)));
    G_02_M(:,:,(s+3)/4)=G_M_1(:,:);
    %读取UK_Met_Office数据并平均
    Gdata_U=ncread(filename,'ua',[1 1 2 28 5],[144 73 1 9 1]);
    G_U=reshape(Gdata_U,[144 73 9]);
    G_U_1=flipud(rot90(mean(G_U,3)));
    G_02_U(:,:,(s+3)/4)=G_U_1(:,:);
    %读取CMCC-Bologna数据并平均
    Gdata_C=ncread(filename,'ua',[1 1 2 37 5],[144 73 1 9 1]);
    G_C=reshape(Gdata_C,[144 73 9]);
    G_C_1=flipud(rot90(mean(G_C,3)));
    G_02_C(:,:,(s+3)/4)=G_C_1(:,:);
    %读取所有Ensemble数据
    Gdata=ncread(filename,'ua',[1 1 2 1 5],[144 73 1 45 1]);
    G=reshape(Gdata,[144 73 45]);
    G_1=flipud(rot90(mean(G,3)));
    G_02(:,:,(s+3)/4)=G_1(:,:);
end
%读取G_05数据并做成员平均
for s=2:4:k-2
    filename=[datadir,filelist(s).name];
    ncid=netcdf.open(filename,'NC_NOWRITE');
    LonData=ncread(filename,'longitude');
    LatData=ncread(filename,'latitude');
    TimeData=ncread(filename,'leadtime');
    %读取ECWMF数据并平均
    Gdata_E=ncread(filename,'ua',[1 1 2 1 2 ],[144 73 1 9 1]); 
    %取相应模态的值 其中level=850(1), time=June(4)
    G_E=reshape(Gdata_E,[144 73 9]);
    G_E_1=flipud(rot90(mean(G_E,3)));%画图格式[73 144 time]
    G_05_E(:,:,(s+2)/4)=G_E_1(:,:);%按照时间填入（应该是+3/4）
    %读取IFM-GEOM数据并平均
    Gdata_I=ncread(filename,'ua',[1 1 2 10 2],[144 73 1 9 1]);
    G_I=reshape(Gdata_I,[144 73 9]);
    G_I_1=flipud(rot90(mean(G_I,3)));
    G_05_I(:,:,(s+2)/4)=G_I_1(:,:);
    %读取Meteo-France数据并平均
    Gdata_M=ncread(filename,'ua',[1 1 2 19 2],[144 73 1 9 1]);
    G_M=reshape(Gdata_M,[144 73 9]);
    G_M_1=flipud(rot90(mean(G_M,3)));
    G_05_M(:,:,(s+2)/4)=G_M_1(:,:);
    %读取UK_Met_Office数据并平均
    Gdata_U=ncread(filename,'ua',[1 1 2 28 2],[144 73 1 9 1]);
    G_U=reshape(Gdata_U,[144 73 9]);
    G_U_1=flipud(rot90(mean(G_U,3)));
    G_05_U(:,:,(s+2)/4)=G_U_1(:,:);
    %读取CMCC-Bologna数据并平均
    Gdata_C=ncread(filename,'ua',[1 1 2 37 2],[144 73 1 9 1]);
    G_C=reshape(Gdata_C,[144 73 9]);
    G_C_1=flipud(rot90(mean(G_C,3)));
    G_05_C(:,:,(s+2)/4)=G_C_1(:,:);
    %读取所有Ensemble数据
    Gdata=ncread(filename,'ua',[1 1 2 1 2],[144 73 1 45 1]);
    G=reshape(Gdata,[144 73 45]);
    G_1=flipud(rot90(mean(G,3)));
    G_05(:,:,(s+2)/4)=G_1(:,:);
end
%读取G_08数据并做成员平均
%{
for s=3:4:k-1
    filename=[datadir,filelist(s).name];
    ncid=netcdf.open(filename,'NC_NOWRITE');
    LonData=ncread(filename,'longitude');
    LatData=ncread(filename,'latitude');
    TimeData=ncread(filename,'leadtime');
    %读取ECWMF数据并平均
    Gdata_E=ncread(filename,'g',[1 1 1 1 4],[144 73 1 9 1]); 
    %取相应模态的值 其中level=850(1), time=June(4)
    G_E=reshape(Gdata_E,[144 73 9]);
    G_E_1=flipud(rot90(mean(G_E,3)));%画图格式[73 144 time]
    G_08_E(:,:,(s+3)/4)=G_E_1(:,:);%按照时间填入（应该是+3/4）
    %读取IFM-GEOM数据并平均
    Gdata_I=ncread(filename,'g',[1 1 1 10 4],[144 73 1 9 1]);
    G_I=reshape(Gdata_I,[144 73 9]);
    G_I_1=flipud(rot90(mean(G_I,3)));
    G_08_I(:,:,(s+3)/4)=G_I_1(:,:);
    %读取Meteo-France数据并平均
    Gdata_M=ncread(filename,'g',[1 1 1 19 4],[144 73 1 9 1]);
    G_M=reshape(Gdata_M,[144 73 9]);
    G_M_1=flipud(rot90(mean(G_M,3)));
    G_08_M(:,:,(s+3)/4)=G_M_1(:,:);
    %读取UK_Met_Office数据并平均
    Gdata_U=ncread(filename,'g',[1 1 1 28 4],[144 73 1 9 1]);
    G_U=reshape(Gdata_U,[144 73 9]);
    G_U_1=flipud(rot90(mean(G_U,3)));
    G_08_U(:,:,(s+3)/4)=G_U_1(:,:);
    %读取CMCC-Bologna数据并平均
    Gdata_C=ncread(filename,'g',[1 1 1 37 4],[144 73 1 9 1]);
    G_C=reshape(Gdata_C,[144 73 9]);
    G_C_1=flipud(rot90(mean(G_C,3)));
    G_08_C(:,:,(s+3)/4)=G_C_1(:,:);
    %读取所有Ensemble数据
    Gdata=ncread(filename,'g',[1 1 1 1 4],[144 73 1 45 1]);
    G=reshape(Gdata,[144 73 45]);
    G_1=flipud(rot90(mean(G,3)));
    G_08(:,:,(s+3)/4)=G_1(:,:);
end
%}
%读取G_11数据并做成员平均
for s=4:4:k
    filename=[datadir,filelist(s).name];
    ncid=netcdf.open(filename,'NC_NOWRITE');
    LonData=ncread(filename,'longitude');
    LatData=ncread(filename,'latitude');
    TimeData=ncread(filename,'leadtime');
    %读取ECWMF数据并平均
    Gdata_E=ncread(filename,'g',[1 1 2 1 8],[144 73 1 9 1]); 
    %取相应模态的值 其中level=850(1), time=June(4)
    G_E=reshape(Gdata_E,[144 73 9]);
    G_E_1=flipud(rot90(mean(G_E,3)));%画图格式[73 144 time]
    G_11_E(:,:,(s+0)/4)=G_E_1(:,:);%按照时间填入（应该是+3/4）
    %读取IFM-GEOM数据并平均
    Gdata_I=ncread(filename,'g',[1 1 2 10 8],[144 73 1 9 1]);
    G_I=reshape(Gdata_I,[144 73 9]);
    G_I_1=flipud(rot90(mean(G_I,3)));
    G_11_I(:,:,(s+0)/4)=G_I_1(:,:);
    %读取Meteo-France数据并平均
    Gdata_M=ncread(filename,'g',[1 1 2 19 8],[144 73 1 9 1]);
    G_M=reshape(Gdata_M,[144 73 9]);
    G_M_1=flipud(rot90(mean(G_M,3)));
    G_11_M(:,:,(s+0)/4)=G_M_1(:,:);
    %读取UK_Met_Office数据并平均
    Gdata_U=ncread(filename,'g',[1 1 2 28 8],[144 73 1 9 1]);
    G_U=reshape(Gdata_U,[144 73 9]);
    G_U_1=flipud(rot90(mean(G_U,3)));
    G_11_U(:,:,(s+0)/4)=G_U_1(:,:);
    %读取CMCC-Bologna数据并平均
    Gdata_C=ncread(filename,'g',[1 1 2 37 8],[144 73 1 9 1]);
    G_C=reshape(Gdata_C,[144 73 9]);
    G_C_1=flipud(rot90(mean(G_C,3)));
    G_11_C(:,:,(s+0)/4)=G_C_1(:,:);
    %读取所有Ensemble数据
    Gdata=ncread(filename,'g',[1 1 2 1 8],[144 73 1 45 1]);
    G=reshape(Gdata,[144 73 45]);
    G_1=flipud(rot90(mean(G,3)));
    G_11(:,:,(s+0)/4)=G_1(:,:);
end

%创建6个成员的集合 Var_g850
%填充20数据
G_500(:,:,:,1,1)=G_02_E;
G_500(:,:,:,2,1)=G_02_I;
G_500(:,:,:,3,1)=G_02_M;
G_500(:,:,:,4,1)=G_02_U;
G_500(:,:,:,5,1)=G_02_C;
G_500(:,:,:,6,1)=G_02;
%填充05数据
G_500(:,:,:,1,2)=G_05_E;
G_500(:,:,:,2,2)=G_05_I;
G_500(:,:,:,3,2)=G_05_M;
G_500(:,:,:,4,2)=G_05_U;
G_500(:,:,:,5,2)=G_05_C;
G_500(:,:,:,6,2)=G_05;
%填充11数据
G_500(:,:,:,1,3)=G_11_E;
G_500(:,:,:,2,3)=G_11_I;
G_500(:,:,:,3,3)=G_11_M;
G_500(:,:,:,4,3)=G_11_U;
G_500(:,:,:,5,3)=G_11_C;
G_500(:,:,:,6,3)=G_11;

ncid2=netcdf.create('./Ensemble/131EnsembleJune.nc','clobber');
        % Create NetCDF file,输入文件名.
lon=netcdf.defDim(ncid2,'longitude',144);%定义维
lat=netcdf.defDim(ncid2,'latitude',73);
time=netcdf.defDim(ncid2,'time',46);
id=netcdf.defDim(ncid2,'institude',6);
ref=netcdf.defDim(ncid2,'reference',3);
g_500=netcdf.defVar(ncid2,'g500','double',[lat lon time id ref]);%定义变量
netcdf.endDef(ncid2);%关闭定义
netcdf.putVar(ncid2,g_500,G_500);%填值
netcdf.close(ncid2);

clear G_E G_I G_M G_U G_C ;
clear G_E_1 G_I_1 G_M_1 G_U_1 G_C_1 ; 
clear Gdata_E Gdata_I Gdata_M Gdata_U Gdata_C;