% this program is  for ensembles 
% two kinds of Data have same surface_dimension 144*73
clc;
clear;
ncdisp('k:/Data/ensemble/FC_01.nc');
ncdisp('K:\Data\NCEP-DOE Reanalysis 2\Pressure Data\hgt.mon.mean.nc');
ncload('k:/Data/ensemble/FC_01.nc');
ncload('K:\Data\NCEP-DOE Reanalysis 2\Pressure Data\hgt.mon.mean.nc');

%access Data from ensembles
lat = ncread('k:/Data/ensemble/FC_01.nc'，'latitude');
lon = ncread('k:/Data/ensemble/FC_01.nc'，'longitude');
time_start = ncread('k:/Data/ensemble/FC_01.nc'，'reftime');%unit=month
time_elasped = ncread('k:/Data/ensemble/FC_01.nc'，'leadtime');%unit=hour
ensemble = ncread('k:/Data/ensemble/FC_01.nc','realization');
level = ncread('k:/Data/ensemble/FC_01.nc'，'level');
g_org = ncread('k:/Data/ensemble/FC_01.nc','g');

%change time size !! this change make present time in month elasped 
for(i=0:1:6)
  time_p(i) = time_start(i) + time_elasped(i);
end

%access Data from NCEP
% add a text
% If i need change this doc
% I shuould do something



