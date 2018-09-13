x=1:100;
x1=sin(x); %t=2pi
x2=1.1*sin(0.5*x);  %t=4pi
x3=0.9*sin(2*x); %t=pi
y=x1+x2+x3;
[pxx,f]=periodogram(y,[],[],1);
plot(f,pxx);
xlabel('cycle/period');
ylabel('PSD');
set(gca, 'Fontname', 'Times New Roman', 'Fontsize', 10);
r = 0.9 + (1.1-0.9).*rand([1 100]);
% z=y.*r;
z=x1+4*x2+9*x3;
s1=std(y);
s2=std(z);
delta=zeros(1,99);
wzzm=zeros(1,99);
cm=zeros(1,99);
for k=1:99
    wzzm(k)=(z(k+1)-z(k))*s1/(s2);
    cm(k)=y(k+1)-y(k);
end
plot(1:99,cm,1:99,wzzm);
ylim([-3 4]);
legend('Not adjusted','Adjusted');
set(gca, 'Fontname', 'Times New Roman', 'Fontsize', 10);