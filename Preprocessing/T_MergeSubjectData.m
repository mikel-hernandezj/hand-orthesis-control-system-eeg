clear all
close all
clc

dir_cur = pwd;
dir_list = dir([pwd '\Ready\*.mat']);
n_doc = length(dir_list);

Subjectlist = {};
subj_idx = 1;
for i = 1:n_doc
    if (contains(dir_list(i).name,'MI'))
        filename = strsplit(dir_list(i).name,'_');
        subject = filename{1,2};
        % Load data
        fprintf('\tLoading data... ')
        load([dir_list(i).folder '\' dir_list(i).name]);   
        fprintf('Done\n')
    %Does the patient exist already?
    ispresent = contains(subject, Subjectlist);
    if ~ispresent
        % Does no exits yet -->
        Subjectlist{subj_idx} = subject;
        subj_idx = subj_idx + 1;
        % Take data for the first time
%         my_field = strcat('v',num2str(k));
%         variable.(my_field) = k*2;
        Data.(subject) = preprocessed;
    else
        % Already exists
        % Add data to the corresponding subject 
        Data.(subject).smt = cat(2,Data.(subject).smt, preprocessed.smt);
        Data.(subject).y = cat(2,Data.(subject).y, preprocessed.y);
        Data.(subject).reject = cat(2,Data.(subject).reject, preprocessed.reject);
        Data.(subject).autoreject = cat(2,Data.(subject).autoreject, preprocessed.autoreject);
    end
    end
end

% Save data 
for i = 1:length(Subjectlist)
    fprintf('\tSaving data... ')
    Subject_trials = Data.(Subjectlist{i});
    save(['Subjects\' Subjectlist{i} '.mat'],'Subject_trials');
    fprintf('Done\n')
end




