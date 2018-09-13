HGX=rand(73,144,27);
HGX=HG_Ensemble(:,:,20:46);
HGY=HG_O;
COV_1=rand(73,144);
for i=1:73
    for j=1:144
        A=reshape(HGX(i,j,:),1,27);
        B=reshape(HGY(i,j,:),1,27);
        r=corrcoef(A,B);
        COV_1(i,j)=r(1,2);
    end
end
[lon,lat]=meshgrid([0:2.5:357.5],[-90:2.5:90]);
m_proj('miller','longitudes',[0 360], 'latitudes',[-90 90],'direction','vertical','aspect',2.5);
m_coast('patch',[.7 .7 .7],'edgecolor','none');
m_grid;
hold on;
m_contourf(lon,lat,COV_1)
%}