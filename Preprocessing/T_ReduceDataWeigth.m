clear
close all
clc

%It looks for sessions in the folder "Preprocessing" and saves it in "Ready"

dir_cur = pwd;
dir_list = dir([pwd '\Preprocessed\*.mat']);
n_doc = length(dir_list);
% Define channels list
Channels_MI = {'FC5','FC3','FC1','FC2','FC4','FC6','C5','C3','C1','Cz','C2','C4','C6','CP5','CP3','CP1','CPz','CP2','CP4','CP6'};

for i = 1:n_doc
    tic
    fprintf('(%d/%d) %s:\n',i,n_doc,dir_list(i).name(1:end-4))
    % Load train data
    fprintf('\tLoading data... ')
    load([dir_list(i).folder '\' dir_list(i).name]); 
    Old  = preprocessed;
    fprintf('Done\n')
    %
    fprintf('\tSaving data... ')
   	preprocessed = F_ChannelsForClassi(Old,Channels_MI);
    preprocessed.y = Old.y;
    preprocessed.reject = Old.reject;
    preprocessed.autoreject = Old.autoreject;
    %
    fprintf('Done\n')
    save(['Ready\' dir_list(i).name(1:end-4) '_Ready.mat'],'preprocessed');
    fprintf('Done\n')
    clearvars -except dir_list Channels_MI n_doc i
    t = toc;
    fprintf('\tTime: %5.2f s.\n',t);
    fprintf('\n')
end