function EEGNonRef = F_RefChan(EEGNonRef,UsedChannels)

chan_idx = find(ismember(EEGNonRef.chan,UsedChannels)); 
Used_x = EEGNonRef.x(:,chan_idx);
% x
MeanPerTimePoint = mean(Used_x,2);
EEGNonRef.x = EEGNonRef.x - MeanPerTimePoint;
% pre_rest
MeanPerTimePoint = mean(EEGNonRef.pre_rest,2);
EEGNonRef.pre_rest = EEGNonRef.pre_rest - MeanPerTimePoint;
% post_rest
MeanPerTimePoint = mean(EEGNonRef.post_rest,2);
EEGNonRef.post_rest = EEGNonRef.post_rest - MeanPerTimePoint;

% vale = 0;