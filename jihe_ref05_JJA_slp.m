%this program is for jiheuybao G DJF ref=11

clear ;
clc;

datadir='./Ensemble/151/'; %ָ���������������ļ�
filelist=dir([datadir,'*.nc']);

% a=filelist(1).name;
% b=filelist(2).name;
k=length(filelist);
% long=ncread(a,'longitude');
% lati=ncread(a,'latitude');
% leve=ncread(a,'level');
%����G���ݣ�g500(lat.73, lon.144, time.1960-2005, institution.6(E��I��M��U��C), referencr 11 )��
G=rand(144,73,46,5); %lat,lon,level,year,ins
%E: ECWMF, I: IMF-GEOM, 
%M: Meteo-France, U: UK_Met_Office, 
%C: CMCC-Bologna
G_11_Ens=zeros(144,73,45,46);
%��ȡG_11���ݲ�����Աƽ��
for s=2:4:k
    filename=[datadir,filelist(s).name];
    ncid=netcdf.open(filename,'NC_NOWRITE');
    LonData=ncread(filename,'longitude');
    LatData=ncread(filename,'latitude');
    TimeData=ncread(filename,'leadtime');
    %��ȡECWMF���ݲ�ƽ��
    Gdata=ncread(filename,'psl',[1 1 1 2],[144 73 45 3]); 
    %ȡ��Ӧģ̬��ֵ ����
    G_11=squeeze(mean(Gdata,4));  %mean DJF
    G_11_Ens(:,:,:,(s+2)/4)=G_11;  %����ʱ�����루Ӧ����+3/4��
end
for i=1:5
    k=1;
    G(:,:,:,i)=squeeze(mean(G_11_Ens(:,:,k:i*9,:),3));
    k=i*9+1;
end
ncid2=netcdf.create('./Ensemble/151.ref05.JJA.nc','clobber');
        % Create NetCDF file,�����ļ���.
lon=netcdf.defDim(ncid2,'longitude',144);%����ά
lat=netcdf.defDim(ncid2,'latitude',73);
time=netcdf.defDim(ncid2,'time',46);
id=netcdf.defDim(ncid2,'institude',5);
% level=netcdf.defDim(ncid2,'level',5);
g=netcdf.defVar(ncid2,'slp','double',[lon lat  time id]);%�������
% longitude=netcdf.defVar(ncid2,'longitude','single',lon);
% latitude=netcdf.defVar(ncid2,'latitude','single',lat);
% lev=netcdf.defVar(ncid2,'level','single',level);
netcdf.endDef(ncid2);%�رն���
netcdf.putVar(ncid2,g,G);%��ֵ
% netcdf.putVar(ncid2,longitude,long);
% netcdf.putVar(ncid2,latitude,lati);
% netcdf.putVar(ncid2,lev,leve);
netcdf.close(ncid2);
