function psdFeatures = F_CalculatePSDFeaturesSubbands(subbands,fs,numLevels)
%Descrtiption: Computes the PSD features from the different subbands
for i=1:numLevels
    x = subbands.(['D',num2str(i)]);
    fs = fs/2;
%     N = length(x);
    %Calculate the PSD of the subband
%     xfft = fft(x);
%     xfft = xfft(1:N/2+1);
%     psd_x = (1/(2*pi*N))*abs(xfft).^2;
%     psd_x(2:end-1) = 2*psd_x(2:end-1);
%     p = sum(psd_x);
    [psd_x, ~] = pwelch(x,[],[],[],fs);
%     F_VisualizePSD(psd_x,fs,N);
    %Get the total PSD
    psd_x = sum(psd_x);
    psdFeatures.(['PSD_D',num2str(i)]) = psd_x;
end