function r=cor_self(x,p,q)
%连续计算一个序列(列向量）的自相关系数，其中滞后时间k由p变化到q
n=size(x,1);
for k=p:q
    sum=0;
    for i=1:n-k
        sum=sum+(x(i)-mean(x(1:n-k)))*(x(i+k)-mean(x(1+k:n)));
    end
    r(k+1)=sum/std(x(1:n-k))/std(x(1+k:n))/(n-k);
end