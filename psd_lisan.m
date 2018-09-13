function[px,tk]=psd_lisan(x,n,k)
a0=mean(x);
ak=0;
bk=0;

for t=1:n
    ak=x(t)*cos(2*pi*k/n*(t-1));
    ak=x(t)*cos(2*pi*k/n*(t-1));
end
ak=2/n*ak;
bk=2/n*bk;
sk2=0.5*(ak^2+bk^2);
tk=n/k;
px=sk2;
end