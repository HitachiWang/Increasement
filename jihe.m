%this program is for analyzied NC data

clear all;
clc;

datadir='d:\data\Ensemble\129\'; %指定批量数据所在文件
filelist=dir([datadir,'*.nc']);
a=filelist(1).name;
b=filelist(2).name;
k=8;
%k=length(filelist);

%临时脚本
q=strcat('d:\data\Ensemble\129\',a);
ncdisp(q);
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
for s=1:2:k
    filename=[datadir,filelist(s).name];
    ncid=netcdf.open(filename,'NC_NOWRITE');
    LonData=ncread(filename,'longitude');
    LatData=ncread(filename,'latitude');
    TimeData=ncread(filename,'leadtime');
    %读取ECWMF数据并平均
    Gdata_E=ncread(q,'g',[1 1 1 1 7],[144 73 1 9 1]); 
    %取相应模态的值 其中level=850(1), time=June(4)
    G_E=reshape(Gdata_E,[144 73 9]);
    G_E_1=flipud(rot90(mean(G_E,3)));%画图格式[73 144 time]
    G_02_E(:,:,(s+1)/2)=G_E_1(:,:);%按照时间填入（应该是+3/4）
    %读取IFM-GEOM数据并平均
    Gdata_I=ncread(q,'g',[1 1 1 10 4],[144 73 1 9 1]);
    G_I=reshape(Gdata_I,[144 73 9]);
    G_I_1=flipud(rot90(mean(G_I,3)));
    G_02_I(:,:,(s+1)/2)=G_I_1(:,:);
    %读取Meteo-France数据并平均
    Gdata_M=ncread(q,'g',[1 1 1 19 4],[144 73 1 9 1]);
    G_M=reshape(Gdata_M,[144 73 9]);
    G_M_1=flipud(rot90(mean(G_M,3)));
    G_02_M(:,:,(s+1)/2)=G_M_1(:,:);
    %读取UK_Met_Office数据并平均
    Gdata_U=ncread(q,'g',[1 1 1 28 4],[144 73 1 9 1]);
    G_U=reshape(Gdata_U,[144 73 9]);
    G_U_1=flipud(rot90(mean(G_U,3)));
    G_02_U(:,:,(s+1)/2)=G_U_1(:,:);
    %读取CMCC-Bologna数据并平均
    Gdata_C=ncread(q,'g',[1 1 1 37 4],[144 73 1 9 1]);
    G_C=reshape(Gdata_C,[144 73 9]);
    G_C_1=flipud(rot90(mean(G_C,3)));
    G_02_C(:,:,(s+1)/2)=G_C_1(:,:);
    %读取所有Ensemble数据
    Gdata=ncread(q,'g',[1 1 1 1 4],[144 73 1 45 1]);
    G=reshape(Gdata,[144 73 45]);
    G_1=flipud(rot90(mean(G,3)));
    G_02(:,:,(s+1)/2)=G_1(:,:);
end
%G_02_E_Y=mean(mean(G_02_E,1),2);%求前两维的平均

%创建6个成员的集合
G_850=rand(73,144,4,6);
G_850(:,:,:,1)=G_02_E;
G_850(:,:,:,2)=G_02_I;
G_850(:,:,:,3)=G_02_M;
G_850(:,:,:,4)=G_02_U;
G_850(:,:,:,5)=G_02_C;
G_850(:,:,:,6)=G_02;
%创建存数据的nc文件
ncid2=netcdf.create('d:\data\Ensemble\129\ncex.nc','clobber');
        % Create NetCDF file,输入文件名.
lon=netcdf.defDim(ncid2,'longitude',144);%定义维
lat=netcdf.defDim(ncid2,'latitude',73);
time=netcdf.defDim(ncid2,'time',4);
id=netcdf.defDim(ncid2,'institude',6);
%ref=netcdf.defDim(ncid,'reference',4);
g_850=netcdf.defVar(ncid2,'g','double',[lat lon time id]);%定义变量
netcdf.endDef(ncid2);%关闭定义
netcdf.putVar(ncid2,g_850,G_850);%填值
netcdf.close(ncid2);

clear G_E G_I G_M G_U G_C ;
clear G_E_1 G_I_1 G_M_1 G_U_1 G_C_1 ; 
clear Gdata_E Gdata_I Gdata_M Gdata_U Gdata_C;


%{
Ens=ncread(q,'institution');
Ense=ncread(q,'source');
level=ncread(q,'level');
Gdata=ncread(q,'g',[1 1 1 1 4],[144 73 1 9 1]);
G_E=reshape(Gdata,[144 73 9]);
G_02_E=flipud(rot90(mean(G_E,3)));
%contourf(rot90(G_02_E));
%}
%huatu
%{
[lon,lat]=meshgrid([-180:2.5:177.5],[-90:2.5:90]);
m_proj('oblique mercator');
m_coast('patch',[.9 .9 .9],'edgecolor','b');
%m_grid('tickdir','out','yticklabels',[], 'xticklabels',[-180 180],'linestyle','none','ticklen',.02);
hold on;
[cs,h]=m_contour(lon,lat,G_02_E);
clabel(cs,h,'fontsize',8);
xlabel('Simulated something else');

[lon,lat]=meshgrid([0:2.5:357.5],[-90:2.5:90]);
m_proj('miller','longitudes',[0 360], 'latitudes',[-90 90],'direction','vertical','aspect',2.5);
m_coast;
m_grid;
hold on;
m_contour(lon,lat,G_02_E)
%}