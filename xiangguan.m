 function[r]=xiangguan(x,y,n)
%XIANGGUAN means Correlation coefficiens
%  Hitachi Wang
%  根据魏凤英的书的公式写的
%  r=cov(x,y)/(s_x*s_y);
%  x,y are array x(:),y(:)
%  n means count of x&y

avex=mean(x);
avey=mean(y);

cov=0;
deltax=0;
deltay=0;

for i=1:n
    cov=cov+(x(i)-avex)*(y(i)-avey);
    deltax=deltax+(x(i)-avex)^2;
    deltay=deltay+(y(i)-avey)^2;
end

sx=sqrt(1.0/n*deltax);
sy=sqrt(1.0/n*deltay);
cov=1.0/n*cov;

r=cov/(sx*sy);




