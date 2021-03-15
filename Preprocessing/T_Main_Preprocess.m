clear
close all
clc

%It looks for sessions in the folder "Data" and saves it in "Preprocessing"

dir_cur = pwd;
dir_list = dir([pwd '\Data\*MI.mat']);
n_doc = length(dir_list);
% Define channels list
Channels_MI = {'FC5','FC3','FC1','FC2','FC4','FC6','C5','C3','C1','Cz','C2','C4','C6','CP5','CP3','CP1','CPz','CP2','CP4','CP6'};


for i = 3:10%:n_doc
    tic
    fprintf('(%d/%d) %s:\n',i,n_doc,dir_list(i).name(1:end-4))
    
    % Load train data
    fprintf('\tLoading data... ')
    load([dir_list(i).folder '\' dir_list(i).name]);   
    fprintf('Done\n')
    
    % Reference channels
    fprintf('\tReferencing data... ')
    EEG_MI_train = F_RefChan(EEG_MI_train, EEG_MI_train.chan);
    EEG_MI_test = F_RefChan(EEG_MI_test, EEG_MI_test.chan);
    fprintf('Done\n')
    
    % Select channels
%     fprintf('\tSelecting channels... ')
%     EEG_MI_train = F_SelectChannels(EEG_MI_train,Channels_MI);
%     EEG_MI_test = F_SelectChannels(EEG_MI_test,Channels_MI);
%     fprintf('Done\n')
    
    % Filter frequency
    fprintf('\tFiltering data... ')
    x_train = F_FreqFilter(EEG_MI_train.x,EEG_MI_train.fs,'bandpass',[8 30],5);
    x_test = F_FreqFilter(EEG_MI_test.x,EEG_MI_test.fs,'bandpass',[8 30],5);
    fprintf('Done\n')
    
    % Calculate statistics
    fprintf('\tCalculating statistics... ')
    N = size(x_train,1);
    mu_train = 1/N * sum(x_train,1);
    sgm_train = sqrt(1/N * sum((x_train - mu_train).^2,1));
    Z_t_train = (x_train - mu_train) ./ max(sgm_train);
    Zsum_t_train = sum(abs(Z_t_train),2) / sqrt(size(x_train,2));
    
    
    N = size(x_test,1);
    mu_test = 1/N * sum(x_test,1);
    sgm_test = sqrt(1/N * sum((x_test - mu_test).^2,1));
    Z_t_test = (x_test - mu_test) ./ max(sgm_test);
    Zsum_t_test = sum(abs(Z_t_test),2) / sqrt(size(x_test,2));
    fprintf('Done\n')
    
    % Check if its already inspected
    fprintf('\tChecking existance... ')
    dir_preprocessed_list = dir([pwd '\Preprocessed\' dir_list(i).name(1:end-4) '*.mat']);
    n_preprocessed_doc = length(dir_preprocessed_list);
    if n_preprocessed_doc > 0
        load([dir_preprocessed_list(1).folder '\' dir_preprocessed_list(1).name]);
        if isfield(preprocessed,'reject') == 1
            reject_test = preprocessed.reject;
            autoreject_test = preprocessed.autoreject;
            rejected_datapoints_test = preprocessed.rejected_datapoints;
            thr_test = preprocessed.thr_auto;
        end
        
        load([dir_preprocessed_list(2).folder '\' dir_preprocessed_list(2).name]);
        if isfield(preprocessed,'reject') == 1
            reject_train = preprocessed.reject;
            autoreject_train = preprocessed.autoreject;
            rejected_datapoints_train = preprocessed.rejected_datapoints;
            thr_train = preprocessed.thr_auto;
        end
        
        clearvars preprocessed
    end
    fprintf('Done\n')
    
    % Divide filtered in epochs
    fprintf('\tDividing epochs and savind data... ')
    [preprocessed.smt]= F_DivideEpochs(x_train,EEG_MI_train.t,0,4000);
    preprocessed.smt(:,101:150,:)= F_RestEpoch(x_train,EEG_MI_train.t,EEG_MI_train.y_dec,0,4000);
    preprocessed.Channels = EEG_MI_train.chan;
    EEG_MI_train.y_dec(1,101:150) = 0;
    preprocessed.y = EEG_MI_train.y_dec;
    preprocessed.fs = EEG_MI_train.fs;
    preprocessed.mu = mu_train;
    preprocessed.sgm = sgm_train;
    preprocessed.Z_t =F_DivideEpochs(Z_t_train,[EEG_MI_train.t],0,4000);
    preprocessed.Z_t(:,101:150,:)= F_RestEpoch(Z_t_train,EEG_MI_train.t,EEG_MI_train.y_dec,0,4000);
    preprocessed.Zsum_t =F_DivideEpochs(Zsum_t_train,[EEG_MI_train.t],0,4000);
    preprocessed.Zsum_t(:,101:150,:)= F_RestEpoch(Zsum_t_train,EEG_MI_train.t,EEG_MI_train.y_dec,0,4000);
    preprocessed.Channels_MI = Channels_MI;
    if isfield(preprocessed,'reject') == 1
        preprocessed.reject = reject_train;
        preprocessed.autoreject = autoreject_train;
        preprocessed.rejected_datapoints = rejected_datapoints_train;
        preprocessed.thr_auto = thr_train;
    end
    save(['Preprocessed\' dir_list(i).name(1:end-4) '_train.mat'],'preprocessed');
    
    clearvars preprocessed
    
    [preprocessed.smt]= F_DivideEpochs(x_test,EEG_MI_test.t,0,4000);
    preprocessed.smt(:,101:150,:) = F_RestEpoch(x_test,EEG_MI_test.t,EEG_MI_test.y_dec,0,4000);
    preprocessed.Channels = EEG_MI_test.chan;
    EEG_MI_test.y_dec(1,101:150) = 0;
    preprocessed.y = EEG_MI_test.y_dec;
    preprocessed.fs = EEG_MI_test.fs;
    preprocessed.mu = mu_test;
    preprocessed.sgm = sgm_test;
    preprocessed.Z_t =F_DivideEpochs(Z_t_test,EEG_MI_test.t,0,4000);
    preprocessed.Z_t(:,101:150,:)= F_RestEpoch(Z_t_test,EEG_MI_test.t,EEG_MI_test.y_dec,0,4000);
    preprocessed.Zsum_t =F_DivideEpochs(Zsum_t_test,EEG_MI_test.t,0,4000);
    preprocessed.Zsum_t(:,101:150,:)= F_RestEpoch(Zsum_t_test,EEG_MI_test.t,EEG_MI_test.y_dec,0,4000);
    preprocessed.Channels_MI = Channels_MI;
    if isfield(preprocessed,'reject') == 1
        preprocessed.reject = reject_test;
        preprocessed.autoreject = autoreject_test;
        preprocessed.rejected_datapoints = rejected_datapoints_test;
        preprocessed.thr_auto = thr_test;
    end
    save(['Preprocessed\' dir_list(i).name(1:end-4) '_test.mat'],'preprocessed');
    fprintf('Done\n')
    clearvars -except dir_list Channels Channels_MI n_doc i
    t = toc;
    fprintf('\tTime: %5.2f s.\n',t);
    fprintf('\n')
    
end