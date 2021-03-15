function featuresPSD = F_ExtractPSDFeatures(data, numLevels, subject)
%Description: extracts PSD features of previously filtered data from one
%patient and session.
% channels list
% load('featuresPSD.mat','featuresPSD');
Channels = data.Channels;
channelNum = length(Channels);
%Create table for PSD features
varsNamesPSD = {'Subject','Epoch'};
contVars = 3;

for k = 1 : channelNum
    for p = 1 : numLevels
        varsNamesPSD{contVars} = ['PSD_', Channels{k},'_D',num2str(p)];
        contVars = contVars+1;
    end
end
featuresPSD = array2table(zeros(0,length(varsNamesPSD)), 'VariableNames',varsNamesPSD);
fs = 1000;
% Read filtered EEG from different channels and epochs
smt = data.smt(:,~data.reject,:);
[~, epochsNum, channelNum] = size(smt);
lastRow = size(featuresPSD,1);

for i = 1 : epochsNum
    row = lastRow+i;
    featuresPSD{row,'Subject'} = subject;
    featuresPSD{row,'Epoch'} = i;
    for k = 1 : channelNum
        subbands = F_DivideSubbands(smt(:,i,k),fs,numLevels);
        psdFeatures = F_CalculatePSDFeaturesSubbands(subbands,fs,numLevels);
        for p = 1 : numLevels
            featuresPSD{row,['PSD_', Channels{k},'_D',num2str(p)]} = psdFeatures.(['PSD_D',num2str(p)]);
        end
    end
end
