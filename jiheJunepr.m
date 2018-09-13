%this program is for jiheuybao

clear all;
clc;

datadir='./Ensemble/228/'; %ָ���������������ļ�
filelist=dir([datadir,'*.nc']);

a=filelist(1).name;
b=filelist(2).name;
k=length(filelist);

%����PRLR���ݣ�PRLR(lat.73, lon.144, time.1960-2005, institution.6(E��I��M��U��C), reference.3 02 05 11 )��

%E: ECWMF, I: IMF-GEOM, 
%M: Meteo-France, U: UK_Met_Office, 
%C: CMCC-Bologna

%����PRLR_02ϵ������ 
PRLR_02_E=rand(73,144,46); 
PRLR_02_I=rand(73,144,46);
PRLR_02_M=rand(73,144,46);
PRLR_02_U=rand(73,144,46);
PRLR_02_C=rand(73,144,46);
PRLR_02=rand(73,144,46);
%����PRLR_05ϵ������ 
PRLR_05_E=rand(73,144,46); 
PRLR_05_I=rand(73,144,46);
PRLR_05_M=rand(73,144,46);
PRLR_05_U=rand(73,144,46);
PRLR_05_C=rand(73,144,46);
PRLR_05=rand(73,144,46);
%{
%����PRLR_08ϵ������ 
PRLR_08_E=rand(73,144,46); 
PRLR_08_I=rand(73,144,46);
PRLR_08_M=rand(73,144,46);
PRLR_08_U=rand(73,144,46);
PRLR_08_C=rand(73,144,46);
PRLR_08=rand(73,144,46);
%}
%����PRLR_11ϵ������ 
PRLR_11_E=rand(73,144,46); 
PRLR_11_I=rand(73,144,46);
PRLR_11_M=rand(73,144,46);
PRLR_11_U=rand(73,144,46);
PRLR_11_C=rand(73,144,46);
PRLR_11=rand(73,144,46);

%��ȡPRLR_02���ݲ�����Աƽ��
for s=1:4:k-3
    filename=[datadir,filelist(s).name];
    filename;
    ncid=netcdf.open(filename,'NC_NOWRITE');
    LonData=ncread(filename,'longitude');
    LatData=ncread(filename,'latitude');
    TimeData=ncread(filename,'leadtime');
    %��ȡECWMF���ݲ�ƽ��
    PRLRdata_E=ncread(filename,'prlr',[1 1 1 5],[144 73 9 1]); 
    %ȡ��Ӧģ̬��ֵ t time=June(4)
    PRLR_E=reshape(PRLRdata_E,[144 73 9]);
    PRLR_E_1=flipud(rot90(mean(PRLR_E,3)));%��ͼ��ʽ[73 144 time]
    PRLR_02_E(:,:,(s+3)/4)=PRLR_E_1(:,:);%����ʱ�����루Ӧ����+3/4��
    %��ȡIFM-GEOM���ݲ�ƽ��
    PRLRdata_I=ncread(filename,'prlr',[1 1 10 5],[144 73 9 1]);
    PRLR_I=reshape(PRLRdata_I,[144 73 9]);
    PRLR_I_1=flipud(rot90(mean(PRLR_I,3)));
    PRLR_02_I(:,:,(s+3)/4)=PRLR_I_1(:,:);
    %��ȡMeteo-France���ݲ�ƽ��
    PRLRdata_M=ncread(filename,'prlr',[1 1 19 5],[144 73 9 1]);
    PRLR_M=reshape(PRLRdata_M,[144 73 9]);
    PRLR_M_1=flipud(rot90(mean(PRLR_M,3)));
    PRLR_02_M(:,:,(s+3)/4)=PRLR_M_1(:,:);
    %��ȡUK_Met_Office���ݲ�ƽ��
    PRLRdata_U=ncread(filename,'prlr',[1 1 28 5],[144 73 9 1]);
    PRLR_U=reshape(PRLRdata_U,[144 73 9]);
    PRLR_U_1=flipud(rot90(mean(PRLR_U,3)));
    PRLR_02_U(:,:,(s+3)/4)=PRLR_U_1(:,:);
    %��ȡCMCC-Bologna���ݲ�ƽ��
    PRLRdata_C=ncread(filename,'prlr',[1 1 37 5],[144 73 9 1]);
    PRLR_C=reshape(PRLRdata_C,[144 73 9]);
    PRLR_C_1=flipud(rot90(mean(PRLR_C,3)));
    PRLR_02_C(:,:,(s+3)/4)=PRLR_C_1(:,:);
    %��ȡ����Ensemble����
    PRLRdata=ncread(filename,'prlr',[1 1 1 5],[144 73 45 1]);
    PRLR=reshape(PRLRdata,[144 73 45]);
    PRLR_1=flipud(rot90(mean(PRLR,3)));
    PRLR_02(:,:,(s+3)/4)=PRLR_1(:,:);
end
%��ȡPRLR_05���ݲ�����Աƽ��
for s=2:4:k-2
    filename=[datadir,filelist(s).name];
    ncid=netcdf.open(filename,'NC_NOWRITE');
    LonData=ncread(filename,'longitude');
    LatData=ncread(filename,'latitude');
    TimeData=ncread(filename,'leadtime');
    %��ȡECWMF���ݲ�ƽ��
    PRLRdata_E=ncread(filename,'prlr',[1 1 1 2 ],[144 73 9 1]); 
    %ȡ��Ӧģ̬��ֵ ����level=850(1), time=June(4)
    PRLR_E=reshape(PRLRdata_E,[144 73 9]);
    PRLR_E_1=flipud(rot90(mean(PRLR_E,3)));%��ͼ��ʽ[73 144 time]
    PRLR_05_E(:,:,(s+2)/4)=PRLR_E_1(:,:);%����ʱ�����루Ӧ����+3/4��
    %��ȡIFM-GEOM���ݲ�ƽ��
    PRLRdata_I=ncread(filename,'prlr',[1 1 10 2],[144 73 9 1]);
    PRLR_I=reshape(PRLRdata_I,[144 73 9]);
    PRLR_I_1=flipud(rot90(mean(PRLR_I,3)));
    PRLR_05_I(:,:,(s+2)/4)=PRLR_I_1(:,:);
    %��ȡMeteo-France���ݲ�ƽ��
    PRLRdata_M=ncread(filename,'prlr',[1 1 19 2],[144 73 9 1]);
    PRLR_M=reshape(PRLRdata_M,[144 73 9]);
    PRLR_M_1=flipud(rot90(mean(PRLR_M,3)));
    PRLR_05_M(:,:,(s+2)/4)=PRLR_M_1(:,:);
    %��ȡUK_Met_Office���ݲ�ƽ��
    PRLRdata_U=ncread(filename,'prlr',[1 1 28 2],[144 73 9 1]);
    PRLR_U=reshape(PRLRdata_U,[144 73 9]);
    PRLR_U_1=flipud(rot90(mean(PRLR_U,3)));
    PRLR_05_U(:,:,(s+2)/4)=PRLR_U_1(:,:);
    %��ȡCMCC-Bologna���ݲ�ƽ��
    PRLRdata_C=ncread(filename,'prlr',[1 1 37 2],[144 73 9 1]);
    PRLR_C=reshape(PRLRdata_C,[144 73 9]);
    PRLR_C_1=flipud(rot90(mean(PRLR_C,3)));
    PRLR_05_C(:,:,(s+2)/4)=PRLR_C_1(:,:);
    %��ȡ����Ensemble����
    PRLRdata=ncread(filename,'prlr',[1 1 1 2],[144 73 45 1]);
    PRLR=reshape(PRLRdata,[144 73 45]);
    PRLR_1=flipud(rot90(mean(PRLR,3)));
    PRLR_05(:,:,(s+2)/4)=PRLR_1(:,:);
end
%��ȡPRLR_08���ݲ�����Աƽ��
%{
for s=3:4:k-1
    filename=[datadir,filelist(s).name];
    ncid=netcdf.open(filename,'NC_NOWRITE');
    LonData=ncread(filename,'longitude');
    LatData=ncread(filename,'latitude');
    TimeData=ncread(filename,'leadtime');
    %��ȡECWMF���ݲ�ƽ��
    PRLRdata_E=ncread(filename,'prlr',[1 1 1 1],[144 73 9 1]); 
    %ȡ��Ӧģ̬��ֵ ����level=850(1), time=June(4)
    PRLR_E=reshape(PRLRdata_E,[144 73 9]);
    PRLR_E_1=flipud(rot90(mean(PRLR_E,3)));%��ͼ��ʽ[73 144 time]
    PRLR_08_E(:,:,(s+1)/4)=PRLR_E_1(:,:);%����ʱ�����루Ӧ����+3/4��
    %��ȡIFM-GEOM���ݲ�ƽ��
    PRLRdata_I=ncread(filename,'prlr',[1 1 10 1],[144 73 9 1]);
    PRLR_I=reshape(PRLRdata_I,[144 73 9]);
    PRLR_I_1=flipud(rot90(mean(PRLR_I,3)));
    PRLR_08_I(:,:,(s+1)/4)=PRLR_I_1(:,:);
    %��ȡMeteo-France���ݲ�ƽ��
    PRLRdata_M=ncread(filename,'prlr',[1 1 19 1],[144 73 9 1]);
    PRLR_M=reshape(PRLRdata_M,[144 73 9]);
    PRLR_M_1=flipud(rot90(mean(PRLR_M,3)));
    PRLR_08_M(:,:,(s+1)/4)=PRLR_M_1(:,:);
    %��ȡUK_Met_Office���ݲ�ƽ��
    PRLRdata_U=ncread(filename,'prlr',[1 1 28 1],[144 73 9 1]);
    PRLR_U=reshape(PRLRdata_U,[144 73 9]);
    PRLR_U_1=flipud(rot90(mean(PRLR_U,3)));
    PRLR_08_U(:,:,(s+1)/4)=PRLR_U_1(:,:);
    %��ȡCMCC-Bologna���ݲ�ƽ��
    PRLRdata_C=ncread(filename,'prlr',[1 1 37 1],[144 73 9 1]);
    PRLR_C=reshape(PRLRdata_C,[144 73 9]);
    PRLR_C_1=flipud(rot90(mean(PRLR_C,3)));
    PRLR_08_C(:,:,(s+1)/4)=PRLR_C_1(:,:);
    %��ȡ����Ensemble����
    PRLRdata=ncread(filename,'prlr',[1 1 1 1],[144 73 45 1]);
    PRLR=reshape(PRLRdata,[144 73 45]);
    PRLR_1=flipud(rot90(mean(PRLR,3)));
    PRLR_08(:,:,(s+1)/4)=PRLR_1(:,:);
end
%}
%��ȡPRLR_11���ݲ�����Աƽ��
for s=4:4:k
    filename=[datadir,filelist(s).name];
    ncid=netcdf.open(filename,'NC_NOWRITE');
    LonData=ncread(filename,'longitude');
    LatData=ncread(filename,'latitude');
    TimeData=ncread(filename,'leadtime');
    %��ȡECWMF���ݲ�ƽ��
    PRLRdata_E=ncread(filename,'prlr',[1 1 1 8],[144 73 9 1]); 
    %ȡ��Ӧģ̬��ֵ ����level=850(1), time=June(4)
    PRLR_E=reshape(PRLRdata_E,[144 73 9]);
    PRLR_E_1=flipud(rot90(mean(PRLR_E,3)));%��ͼ��ʽ[73 144 time]
    PRLR_11_E(:,:,(s+0)/4)=PRLR_E_1(:,:);%����ʱ�����루Ӧ����+3/4��
    %��ȡIFM-GEOM���ݲ�ƽ��
    PRLRdata_I=ncread(filename,'prlr',[1 1 10 8],[144 73 9 1]);
    PRLR_I=reshape(PRLRdata_I,[144 73 9]);
    PRLR_I_1=flipud(rot90(mean(PRLR_I,3)));
    PRLR_11_I(:,:,(s+0)/4)=PRLR_I_1(:,:);
    %��ȡMeteo-France���ݲ�ƽ��
    PRLRdata_M=ncread(filename,'prlr',[1 1  19 8],[144 73 9 1]);
    PRLR_M=reshape(PRLRdata_M,[144 73 9]);
    PRLR_M_1=flipud(rot90(mean(PRLR_M,3)));
    PRLR_11_M(:,:,(s+0)/4)=PRLR_M_1(:,:);
    %��ȡUK_Met_Office���ݲ�ƽ��
    PRLRdata_U=ncread(filename,'prlr',[1 1 28 8],[144 73 9 1]);
    PRLR_U=reshape(PRLRdata_U,[144 73 9]);
    PRLR_U_1=flipud(rot90(mean(PRLR_U,3)));
    PRLR_11_U(:,:,(s+0)/4)=PRLR_U_1(:,:);
    %��ȡCMCC-Bologna���ݲ�ƽ��
    PRLRdata_C=ncread(filename,'prlr',[1 1 37 8],[144 73 9 1]);
    PRLR_C=reshape(PRLRdata_C,[144 73 9]);
    PRLR_C_1=flipud(rot90(mean(PRLR_C,3)));
    PRLR_11_C(:,:,(s+0)/4)=PRLR_C_1(:,:);
    %��ȡ����Ensemble����
    PRLRdata=ncread(filename,'prlr',[1 1 2 8],[144 73 45 1]);
    PRLR=reshape(PRLRdata,[144 73 45]);
    PRLR_1=flipud(rot90(mean(PRLR,3)));
    PRLR_11(:,:,(s+0)/4)=PRLR_1(:,:);
end
PRLR=rand(73,144,46,6,3);
%����6����Ա�ļ��� Var_PRLR
%���20����
PRLR(:,:,:,1,1)=PRLR_02_E;
PRLR(:,:,:,2,1)=PRLR_02_I;
PRLR(:,:,:,3,1)=PRLR_02_M;
PRLR(:,:,:,4,1)=PRLR_02_U;
PRLR(:,:,:,5,1)=PRLR_02_C;
PRLR(:,:,:,6,1)=PRLR_02;
%���05����
PRLR(:,:,:,1,2)=PRLR_05_E;
PRLR(:,:,:,2,2)=PRLR_05_I;
PRLR(:,:,:,3,2)=PRLR_05_M;
PRLR(:,:,:,4,2)=PRLR_05_U;
PRLR(:,:,:,5,2)=PRLR_05_C;
PRLR(:,:,:,6,2)=PRLR_05;
%{
%���08����
PRLR(:,:,:,1,3)=PRLR_08_E;
PRLR(:,:,:,2,3)=PRLR_08_I;
PRLR(:,:,:,3,3)=PRLR_08_M;
PRLR(:,:,:,4,3)=PRLR_08_U;
PRLR(:,:,:,5,3)=PRLR_08_C;
PRLR(:,:,:,6,3)=PRLR_08;
%}
%���11����
PRLR(:,:,:,1,3)=PRLR_11_E;
PRLR(:,:,:,2,3)=PRLR_11_I;
PRLR(:,:,:,3,3)=PRLR_11_M;
PRLR(:,:,:,4,3)=PRLR_11_U;
PRLR(:,:,:,5,3)=PRLR_11_C;
PRLR(:,:,:,6,3)=PRLR_11;

ncid2=netcdf.create('./Ensemble/228EnsembleJune.nc','clobber');
        % Create NetCDF file,�����ļ���.
lon=netcdf.defDim(ncid2,'longitude',144);%����ά
lat=netcdf.defDim(ncid2,'latitude',73);
time=netcdf.defDim(ncid2,'time',46);
id=netcdf.defDim(ncid2,'institude',6);
ref=netcdf.defDim(ncid2,'reference',3);
PRLR_NC=netcdf.defVar(ncid2,'prlr','double',[lat lon time id ref]);%�������
netcdf.endDef(ncid2);%�رն���
netcdf.putVar(ncid2,PRLR_NC,PRLR);%��ֵ
netcdf.close(ncid2);

clear PRLR_E PRLR_I PRLR_M PRLR_U PRLR_C ;
clear PRLR_E_1 PRLR_I_1 PRLR_M_1 PRLR_U_1 PRLR_C_1 ; 
clear PRLRdata_E PRLRdata_I PRLRdata_M PRLRdata_U PRLRdata_C