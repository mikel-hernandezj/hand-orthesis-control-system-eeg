function F_VisualizeFrequencySubbands(x,subbands,fs,numLevels)
%Description: Plots the frequency subbands of a channel
figure(1);
subplot(numLevels+1,1,1);
time = (0:1/fs:((length(x)-1)*1/fs));
plot(time,x);
title('Original signal');
ylim([min(x)-10,max(x)+10]);

cont = 1;
for i=1:numLevels
    D = subbands.(['D',num2str(i)]);
    fs = fs/2;
    time = (0:1/fs:((length(D)-1)*1/fs));
    
    figure(1);
    cont = cont + 1;
    subplot(numLevels+1,1,cont);
    plot(time,D);
    xlabel('Time (s)');
    title(['D', num2str(i)]);
    ylim([min(D)-10,max(D)+10]);
    xlim([min(time),max(time)]);
    
end