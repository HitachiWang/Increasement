%this program is for jiheuybao G DJF ref=11

clear ;
clc;

datadir='./Ensemble/129/'; %指定批量数据所在文件
filelist=dir([datadir,'*.nc']);

% a=filelist(1).name;
% b=filelist(2).name;
k=length(filelist);
% long=ncread(a,'longitude');
% lati=ncread(a,'latitude');
% leve=ncread(a,'level');
%创建G数据（g500(lat.73, lon.144, time.1960-2005, institution.6(E、I、M、U、C), referencr 11 )）
G=rand(144,73,5,46,5); %lat,lon,level,year,ins
%E: ECWMF, I: IMF-GEOM, 
%M: Meteo-France, U: UK_Met_Office, 
%C: CMCC-Bologna
G_11_Ens=zeros(144,73,5,45,46);
%读取G_11数据并做成员平均
for s=2:4:k
    filename=[datadir,filelist(s).name];
    ncid=netcdf.open(filename,'NC_NOWRITE');
    LonData=ncread(filename,'longitude');
    LatData=ncread(filename,'latitude');
    TimeData=ncread(filename,'leadtime');
    %读取ECWMF数据并平均
    Gdata=ncread(filename,'g',[1 1 1 1 2],[144 73 5 45 3]); 
    %取相应模态的值 其中
    G_11=squeeze(mean(Gdata,5));  %mean JJA
    G_11_Ens(:,:,:,:,(s+2)/4)=G_11;  %按照时间填入（应该是+3/4）
end
for i=1:5
    k=1;
    G(:,:,:,:,i)=squeeze(mean(G_11_Ens(:,:,:,k:i*9,:),4));
    k=i*9+1;
end
ncid2=netcdf.create('./Ensemble/129.ref05.JJA.nc','clobber');
        % Create NetCDF file,输入文件名.
lon=netcdf.defDim(ncid2,'longitude',144);%定义维
lat=netcdf.defDim(ncid2,'latitude',73);
time=netcdf.defDim(ncid2,'time',46);
id=netcdf.defDim(ncid2,'institude',5);
level=netcdf.defDim(ncid2,'level',5);
g=netcdf.defVar(ncid2,'G','double',[lon lat level time id]);%定义变量
% longitude=netcdf.defVar(ncid2,'longitude','single',lon);
% latitude=netcdf.defVar(ncid2,'latitude','single',lat);
% lev=netcdf.defVar(ncid2,'level','single',level);
netcdf.endDef(ncid2);%关闭定义
netcdf.putVar(ncid2,g,G);%填值
% netcdf.putVar(ncid2,longitude,long);
% netcdf.putVar(ncid2,latitude,lati);
% netcdf.putVar(ncid2,lev,leve);
netcdf.close(ncid2);
