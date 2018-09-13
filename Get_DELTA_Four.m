delta=rand(73,144,42,4);
delta(:,:,:,1)=DELTA_WZZM;
delta(:,:,:,2)=DELTA_DY;
delta(:,:,:,3)=DELTA_E(:,:,2:43);
delta(:,:,:,4)=DELTA_O(:,:,2:43);
kk=['delta_wzzm';'delta_dy  ';'delta_e   ';'delta_o   '];
ncid2=netcdf.create('d:/data/Ensemble/ERA40.G500.ref05.ECWMF.1961-2002.nc','clobber');
        % Create NetCDF file,输入文件名.
lon=netcdf.defDim(ncid2,'longitude',144);%定义维
lat=netcdf.defDim(ncid2,'latitude',73);
time=netcdf.defDim(ncid2,'time',42);
kind=netcdf.defDim(ncid2,'kind',4);
len=netcdf.defDim(ncid2,'length',10);
Kind=netcdf.defVar(ncid2,'Kind','char',[kind len]);
Delta=netcdf.defVar(ncid2,'Delta','double',[lat lon time kind]);%定义变量
netcdf.endDef(ncid2);%关闭定义
netcdf.putVar(ncid2,Kind,kk);
netcdf.putVar(ncid2,Delta,delta);%填值
netcdf.close(ncid2);