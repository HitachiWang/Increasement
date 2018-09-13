%lowpass filter dengquanhuadongpingjun
function[H]=lowpass_Hf(m,f)
H=1/(2*m+1)*sin((2*m+1)*pi*f)/sin(pi*f);
