function x_filtered = F_FreqFilter(x,fs,type,frequencies,order)
% Description: This function performs a frequecy filter based on the
% specified parameters: Signal with N channels (cols), fs, filter type
% (highpass, bandpass or lowpass), frequency range (0.5 or [0.5 10]) and
% the order.
x_filtered = zeros(size(x)); 
fn = fs/2;
switch type
    case 'highpass'
        WNdown = frequencies/fn;
        [b, a] = butter(order,WNdown,'high');
        x_filtered = filter(b,a,x,[],1);
    case 'bandpass'
        WNdown = frequencies(1)/fn;
        WNup = frequencies(2)/fn;
        [b, a] = butter(order,[WNdown WNup],'bandpass');
%         d = designfilt('bandpassiir','FilterOrder',10, 'HalfPowerFrequency1',8,'HalfPowerFrequency2',30,'SampleRate',1000);
%         sos = ss2sos(A,B,C,D); fvt = fvtool(sos,d,'Fs',1000); legend(fvt,'butter','designfilt')
        x_filtered = filter(b,a,x,[],1);
    case 'lowpass'
        WNup = frequencies/fn;
        [b, a] = butter(order,WNup,'low');
        x_filtered = filter(b,a,x,[],1);  
end
% vale = 1;