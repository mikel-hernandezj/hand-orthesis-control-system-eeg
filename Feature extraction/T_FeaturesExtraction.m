clear all
close all
clc
addpath('FeaturesExtraction');
addpath('Preprocessed data');
warning('off');

% Iterate over data to get the features from the training data
% load('sess1_subj01_filtered.mat');
%Get the names of the files
% new = 1;
numLevels = 3;
% Channels = {'FC5','FC3','FC1','FC2','FC4','FC6','C5','C3','C1','Cz','C2','C4','C6','CP5','CP3','CP1','CPz','CP2','CP4','CP6'};
% combinations = nchoosek(Channels,2);
% [featuresStatistics, featuresPSD, featuresPLV, labels] = F_GetFeaturesTables(new,'train');
list = dir('Preprocessed data');
for i = 1 : length(list)
    if (contains(list(i).name,'subj'))
        filename = list(i).name;
        subject = regexp(filename, '\d+', 'match');
        subject = (subject{1,1});
        data = load(list(i).name);
        disp('-----------------------------------------');
        disp(['Extracting features from subject ',num2str(subject)]);
        featuresStatistics = F_ExtractStatisticalFeatures(data.preprocessed, str2double(subject));
        disp('Statistical features extracted');
        featuresPSD = F_ExtractPSDFeatures(data.preprocessed,numLevels, str2double(subject));
        disp('PSD features extracted');
        featuresPLV = F_ExtractPLVFeatures(data.preprocessed, str2double(subject));
        disp('PLV features extracted');
        labels = F_ExtractLabels(data.preprocessed, str2double(subject));
        disp('Labels extracted');
        features = join(featuresStatistics, featuresPSD);
        features = join(features,featuresPLV);
        features = join(features,labels);
        path = ['Subjects Features\features_subject',subject,'.csv'];
        writetable(features,path);
    end
end

