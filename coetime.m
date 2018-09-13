%this function is for coecof in timeline
function[COET]=coetime(ENS,OBS,ntime,nlat,nlon)

x=zeros(nlat*nlon,ntime);
for ek=1:ntime
    ec=1;
    for ei=1:nlat
        for ej=1:nlon
            x(ec,ek)=ENS(ei,ej,ek);
            ec=ec+1;
        end
    end
end
y=zeros(nlat*nlon,ntime);
for ek=1:ntime
    ec=1;
    for ei=1:nlat
        for ej=1:nlon
            y(ec,ek)=OBS(ei,ej,ek);
            ec=ec+1;
        end
    end
end

COET=zeros(ntime);

for i=1:ntime
    COE=corrcoef(x(:,i),y(:,i));
    COET(i)=COE(1,2)*100;
end
    
    
    