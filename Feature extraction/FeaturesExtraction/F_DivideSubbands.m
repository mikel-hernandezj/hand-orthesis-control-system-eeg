function subbands = F_DivideSubbands(x,fs,numLevels)
% Description: Divide the EEG signal from one epoch and one channel in
% different frequency subbands
% Decompose the waveform
signal = x;
waveletFunction = 'db4';
[wCoe,L] = wavedec(signal,numLevels,waveletFunction);
for i=1:numLevels
    subbands.(['D',num2str(i)]) = detcoef(wCoe,L,i);
end
%Plot the resulting subbands
% F_VisualizeFrequencySubbands(x,subbands,fs,numLevels);