function featuresPLV = F_ExtractPLVFeatures(data, subject)
%Description: extracts PLV features of previously filtered data from one
%patient and session.
% load('featuresPSD.mat','featuresPSD');
Channels = data.Channels;
%Create table for PLV features
varsNamesPLV = {'Subject','Epoch'};
contVars = 3;
combinations = nchoosek(Channels,2);
last = size(combinations,1);

for i = 1 : last
    varsNamesPLV{contVars} = ['PLV_', combinations{i,1}, '_', combinations{i,2}];
    contVars = contVars + 1;
end
featuresPLV = array2table(zeros(0,length(varsNamesPLV)), 'VariableNames',varsNamesPLV);
% Read filtered EEG from different channels and epochs
smt = data.smt(:,~data.reject,:);
[~, epochsNum, ~] = size(smt);
lenCombinations = size(combinations,1);
lastRow = size(featuresPLV,1);
for i = 1 : epochsNum
    row = lastRow+i;
    featuresPLV{row,'Subject'} = subject;
    featuresPLV{row,'Epoch'} = i;
    for k = 1 : lenCombinations
        channel1 = strcmp(Channels,combinations{k,1});
        channel2 = strcmp(Channels,combinations{k,2});
        plvValue = F_CalculatePLVFeature(smt(:,i,channel1),smt(:,i,channel2));
        featuresPLV{row,['PLV_', combinations{k,1}, '_', combinations{k,2}]} = plvValue;
    end
end
