function plvValue = F_CalculatePLVFeature(channel1,channel2)
% Decription: Calculates the PLV synchronization value between two channels
%Hilbert transform
hilbert_channel1 = hilbert(channel1);
hilbert_channel2 = hilbert(channel2);
%Phase angle
% phase_channel1 = atan(hilbert_channel1./channel1);
% phase_channel2 = atan(hilbert_channel2./channel2);
phase_channel1 = angle(hilbert_channel1);
phase_channel2 = angle(hilbert_channel2);
%PLV
N = length(channel1);
plvValue = (1/N)*abs(sum(exp(1i*(phase_channel1 - phase_channel2))));