function F_VisualizePSD(psd_x,fs,N)
%Description plot the PSD of a signal
figure();
freq = 0:fs/N:fs/2;
plot(freq,10*log10(psd_x))
grid on
title('Periodogram Using FFT')
xlabel('Frequency (Hz)')
ylabel('Power/Frequency (dB/Hz)')