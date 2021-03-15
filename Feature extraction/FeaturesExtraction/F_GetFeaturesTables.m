function [featuresStatistics, featuresPSD, featuresPLV, labels] = F_GetFeaturesTables(new,type)
%Description: Get tables that contain the features. If new = 0, creates new
%tables, otherwise loads the existing tables.
if new
    [featuresStatistics, featuresPSD, featuresPLV, labels] = F_CreateTables();
else
    if strcmp(type,'test')
        load('featuresTest.mat');
        featuresStatistics = featuresTest.featuresStatistics;
        featuresPSD = featuresTest.featuresPSD;
        featuresPLV = featuresTest.featuresPLV;
        labels = featuresTest.labels;
    else
        load('featuresTrain.mat');
        featuresStatistics = featuresTrain.featuresStatistics;
        featuresPSD = featuresTrain.featuresPSD;
        featuresPLV = featuresTrain.featuresPLV;
        labels = featuresTrain.labels;
    end
end

function [featuresStatistics, featuresPSD, featuresPLV, labels] = F_CreateTables()
%Description: Creates the tables to save the features.
% channels list
Channels = {'FC5','FC3','FC1','FC2','FC4','FC6','C5','C3','C1','Cz','C2','C4','C6','CP5','CP3','CP1','CPz','CP2','CP4','CP6'};
channelNum = length(Channels);
% Create table for statistical features
varsNames = {'Subject','Session','Epoch'};
contVars = 4;

for k = 1 : channelNum
    varsNames{contVars} = ['Mean_', Channels{k}];
    contVars = contVars+1;
    varsNames{contVars} = ['Variance_', Channels{k}];
    contVars = contVars+1;
    varsNames{contVars} = ['Kurtosis_', Channels{k}];
    contVars = contVars+1;
end
featuresStatistics = array2table(zeros(0,length(varsNames)), 'VariableNames',varsNames);

%Create table for PSD features
varsNamesPSD = {'Subject','Session','Epoch'};
contVars = 4;
numLevels = 3;

for k = 1 : channelNum
    for p = 1 : numLevels
        varsNamesPSD{contVars} = ['PSD_', Channels{k},'_D',num2str(p)];
        contVars = contVars+1;
    end
end
featuresPSD = array2table(zeros(0,length(varsNamesPSD)), 'VariableNames',varsNamesPSD);

%Create table for PLV features
varsNamesPLV = {'Subject','Session','Epoch'};
contVars = 4;
combinations = nchoosek(Channels,2);
last = size(combinations,1);

for i = 1 : last
    varsNamesPLV{contVars} = ['PLV_', combinations{i,1}, '_', combinations{i,2}];
    contVars = contVars + 1;
end
featuresPLV = array2table(zeros(0,length(varsNamesPLV)), 'VariableNames',varsNamesPLV);

%Create table for labels
varsNamesLabels = {'Subject','Session','Epoch','Label'};
labels = array2table(zeros(0,length(varsNamesLabels)), 'VariableNames',varsNamesLabels);