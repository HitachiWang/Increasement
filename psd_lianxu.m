function[px,tk]=psd_lianxu(x,n,m);

r=cor_self(x,0,m);
sl=zeros(m+1,1);
for l=0:m
for t=1:m-1
    sl(l+1)=2*r(t+1)*cos(pi*l/m*t);
end
sl(l+1)=1/m*(r(1)+sl(l+1)+r(m+1)*cos(l*pi));
end
s=zeros(m+1,1);
s(1)=0.5*sl(1)+0.5*sl(2);
s(m+1)=0.5*sl(m)+0.5*sl(m+1);
for l=1:m-1
    s(l+1)=0.25*sl(l)+0.5*sl(l+1)+0.25*sl(l+2);
end
px=sl;
tk=n/l;
