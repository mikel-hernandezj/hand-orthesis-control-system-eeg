clear
close all
clc

%It looks for sessions in the folder "Data" and saves it in "Preprocessing"
dir_cur = pwd;
dir_list = dir([pwd '\Ready\*.mat']);
n_doc = length(dir_list);
manual_reject = [];
automatic_reject = [];
for i = 1:n_doc
    tic
    fprintf('(%d/%d) %s:\n',i,n_doc,dir_list(i).name(1:end-4))
    % Load train data
    fprintf('\tAdding data... ')
    load([dir_list(i).folder '\' dir_list(i).name]);   
    manual_reject = [manual_reject preprocessed.reject];
    automatic_reject = [automatic_reject preprocessed.autoreject];
    fprintf('Done\n')
end
plotconfusion(manual_reject,automatic_reject)