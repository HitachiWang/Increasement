Xais=zeros(73*144,1);
Yais=zeros(1,73*144);
YaisE=zeros(1,73*144);
for i=1:73
    for j=1:144
    Xais(i*j)=VarCon_8Copy(i,j);
    Yais(i*j)=COR_DY_W_6(i,j);
    YaisE(i*j)=COR_E_6(i,j);
    end
end
scatter(Xais,Yais',[],'filled','b');
hold on;
scatter(Xais,YaisE',[],'*','r');