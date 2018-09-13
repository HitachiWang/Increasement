


%对于明显不符合区域做分析
%该区域为120w-180w;40s-80s

% HGE=HG_Ensemble(53:69,97:129,:);
% HGO=HG_Obs(53:69,97:129,:);

% HGE=rand(16*32,42);
HGO=rand(144*73,46);
c=1;
for i=1:73
    for j=1:144
%         HGE(c,:)=DELTA_DY(i,j,:);
        HGO(c,:)=DELTA_O(i,j,:);
        c=c+1;
    end
end

hgte=squeeze(mean(HGO,1))';
% hgto=squeeze(mean(HGO,1))';

 variance=std(hgte)^2;
 hgte = (hgte - mean(hgte))/sqrt(variance) ;

n=length(hgte);
dt=1;
time=[0:length(hgte)-1]*dt+1960.0;
xlim=[1960,2005];
pad=1;
dj=0.25;
s0=2;
j1=5/dj;
lag1=0.5;
mother='Morlet';

% Wavelet transform:
[wave,period,scale,coi] = wavelet(hgte,dt,pad,dj,s0,j1,mother);
power = (abs(wave)).^2 ;        % compute wavelet power spectrum

% Significance levels: (variance=1 for the normalized SST)
[signif,fft_theor] = wave_signif(1.0,dt,scale,0,lag1,-1,-1,mother);
sig95 = (signif')*(ones(1,n));  % expand signif --> (J+1)x(N) array
sig95 = power ./ sig95;         % where ratio > 1, power is significant

% Global wavelet spectrum & significance levels:
global_ws = variance*(sum(power')/n);   % time-average over all times
dof = n - scale;  % the -scale corrects for padding at edges
global_signif = wave_signif(variance,dt,scale,1,lag1,-1,dof,mother);

% Scale-average between El Nino periods of 2--8 years
avg = find((scale >= 2) & (scale < 8));
Cdelta = 0.776;   % this is for the MORLET wavelet
scale_avg = (scale')*(ones(1,n));  % expand scale --> (J+1)x(N) array
scale_avg = power ./ scale_avg;   % [Eqn(24)]
scale_avg = variance*dj*dt/Cdelta*sum(scale_avg(avg,:));   % [Eqn(24)]
scaleavg_signif = wave_signif(variance,dt,scale,2,lag1,-1,[2,7.9],mother);

whos

%------------------------------------------------------ Plotting

%--- Plot time series
subplot('position',[0.1 0.75 0.65 0.2])
plot(time,hgte)
set(gca,'XLim',xlim(:))
xlabel('Time (year)')
ylabel('DY Gzone Anomaly HGT (m)')
title('a)DY Qzone Anomaly HGT500 (JJA-Annuel)')
hold off

%--- Contour plot wavelet power spectrum
subplot('position',[0.1 0.37 0.65 0.28])
levels = [0.0625,0.125,0.25,0.5,1,2,4,8,16] ;
Yticks = 2.^(fix(log2(min(period))):fix(log2(max(period))));
contour(time,log2(period),log2(power),log2(levels));  %*** or use 'contourfill'
%imagesc(time,log2(period),log2(power));  %*** uncomment for 'image' plot
xlabel('Time (year)')
ylabel('Period (years)')
title('b)DY Qzone HGT Wavelet Power Spectrum')
set(gca,'XLim',xlim(:))
set(gca,'YLim',log2([min(period),max(period)]), ...
	'YDir','reverse', ...
	'YTick',log2(Yticks(:)), ...
	'YTickLabel',Yticks)
% 95% significance contour, levels at -99 (fake) and 1 (95% signif)
hold on
contour(time,log2(period),sig95,[-99,1],'k');
hold on
% cone-of-influence, anything "below" is dubious
plot(time,log2(coi),'k')
hold off

%--- Plot global wavelet spectrum
subplot('position',[0.77 0.37 0.2 0.28])
plot(global_ws,log2(period))
hold on
plot(global_signif,log2(period),'--')
hold off
xlabel('Power (m^2)')
title('c) DY QZONE Wavelet Spectrum')
set(gca,'YLim',log2([min(period),max(period)]), ...
	'YDir','reverse', ...
	'YTick',log2(Yticks(:)), ...
	'YTickLabel','')
set(gca,'XLim',[0,1.25*max(global_ws)])

%--- Plot 2--8 yr scale-average time series
subplot('position',[0.1 0.07 0.65 0.2])
plot(time,scale_avg)
set(gca,'XLim',xlim(:))
xlabel('Time (year)')
ylabel('DY Anomaly HGT500 (m^2)')
title('d) 2-8 yr Scale-average Time Series')
hold on
plot(xlim,scaleavg_signif+[0,0],'--')
hold off

% end of code











