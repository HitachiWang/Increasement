%%一些与SST相关的代码 time 1854-2017.2
%%Get SST 1*1->2.5*2.5
ncdisp('d:/data/Ensemble/sst.mnmean.v4.nc');
SST=ncread('d:/data/Ensemble/sst.mnmean.v4.nc','sst',[1 1 1274],[180 89 47*12]);
SST_lon=ncread('d:/data/Ensemble/sst.mnmean.v4.nc','lon');
SST_lat=ncread('d:/data/Ensemble/sst.mnmean.v4.nc','lat');
SST_time=ncread('d:/data/Ensemble/sst.mon.mean.nc','time');
SST_timeb=ncread('d:/data/Ensemble/sst.mnmean.v4.nc','time_bnds');
 [x,y]=meshgrid((0:2:358),(88:-2:-88));
[lon,lat]=meshgrid((0:2.5:357.5),(90:-2.5:-90));
sst=zeros(73,144,47*12);
for t=1:47*12
c=interp2(x,y,(squeeze(SST(:,:,t)))',lon,lat);
sst(:,:,t)=c;
end
Sst=zeros(144,73,46);
for i=1:46
    Sst(:,:,i)=((sst(:,:,i*12)+sst(:,:,i*12+1)+sst(:,:,i*12+2))/3)';
end
for i=1:144
    for j=1:73
        for k=1:46
        if(Sst(i,j,k)<-100)
            Sst(i,j,k)=NaN;
        end
        end
    end
end

        
% ncid2=netcdf.create('d:/data/Ensemble/sst2.mon.mean.nc','clobber');
%         % Create NetCDF file,输入文件名.
% lon=netcdf.defDim(ncid2,'longitude',144);%定义维
% lat=netcdf.defDim(ncid2,'latitude',73);
% time=netcdf.defDim(ncid2,'time',46);
% sea=netcdf.defVar(ncid2,'sst','double',[lon lat time]);%定义变量
% netcdf.endDef(ncid2);%关闭定义
% netcdf.putVar(ncid2,sea,Sst);%填值
% netcdf.close(ncid2);

[lon,lat]=meshgrid([0:2.5:357.5],[90:-2.5:-90]);
m_proj('Equidistant','longitudes',[0 357.5], 'latitudes',[-90 90]);
m_coast('color','k');
m_grid('FontSize',6);
title('ECWMF','FontSize',6);
hold on;
[cs,h]=m_contourf(lon,lat,(Obs(:,:,1))',[-10:5:40]);
clabel(cs,h,'FontSize',8);
colorbar;
