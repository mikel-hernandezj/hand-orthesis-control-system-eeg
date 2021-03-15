function featuresStatistics = F_ExtractStatisticalFeatures(data,subject)
%Description: Extracts statistical features from the channels
Channels = data.Channels;
% create table to save the features
channelNum = length(Channels);
% Create table for statistical features
varsNames = {'Subject','Epoch'};
contVars = 3;

for k = 1 : channelNum
    varsNames{contVars} = ['Mean_', Channels{k}];
    contVars = contVars+1;
    varsNames{contVars} = ['Variance_', Channels{k}];
    contVars = contVars+1;
    varsNames{contVars} = ['Kurtosis_', Channels{k}];
    contVars = contVars+1;
end
featuresStatistics = array2table(zeros(0,length(varsNames)), 'VariableNames',varsNames);
% Read filtered EEG from different channels and epochs
smt = data.smt(:,~data.reject,:);
[~, epochsNum, channelNum] = size(smt);
lastRow = size(featuresStatistics,1);
for i = 1 : epochsNum
    row = i + lastRow;
    featuresStatistics{row,'Subject'} = subject;
    featuresStatistics{row,'Epoch'} = i;
    for k = 1 : channelNum
        featuresStatistics{row,['Mean_', Channels{k}]} = mean(smt(:,i,k));
        featuresStatistics{row,['Variance_', Channels{k}]} = var(smt(:,i,k));
        featuresStatistics{row,['Kurtosis_', Channels{k}]} = kurtosis(smt(:,i,k));
    end
end