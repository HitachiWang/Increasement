function[EOF_R,PC,g]=eof(OR,nlat,nlon,ntime,mod)

ave=mean(OR,3);
ave=squeeze(ave);
STD=zeros(nlat,nlon,ntime);
for ei=1:ntime
    STD(:,:,ei)=OR(:,:,ei)-ave;
end

x=zeros(nlat*nlon,ntime);
for ek=1:ntime
    ec=1;
    for ei=1:nlat
        for ej=1:nlon
            x(ec,ek)=STD(ei,ej,ek);
            ec=ec+1;
        end
    end
end

s=x'*x;
[vq,dq]=eig(s);
[d,idx] = sort(diag(dq),'descend');
vq = vq(:,idx); 
for l=1:ntime
    vq(:,l)=vq(:,l)/sqrt(d(l));
end
v=x*vq;
t=v'*x;

R=zeros(nlat,nlon,mod);
EOF_R=zeros(nlat,nlon,mod);
g=zeros(mod);
for ek=1:mod
    count=1;
    for l=1:nlat
        for m=1:nlon
            R(l,m,ek)=v(count,ek);
            count=count+1;
        end
    end
    g(ek)=d(ek)/sum(d)*100;
  
end
for kk=1:mod
    EOF_R(:,:,kk)=R(:,:,kk)+ave;
end
PC=t;
