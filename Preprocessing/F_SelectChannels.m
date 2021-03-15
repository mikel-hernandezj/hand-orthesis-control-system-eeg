function EEG_MI_train_new = F_SelectChannels(EEG_MI_train,Channels)
l_chan = length(Channels);
ChanIndex = zeros(l_chan,1);
for k = 1:l_chan
    ChanIndex(k) = find(strcmp(EEG_MI_train.chan,Channels{k}));
end
EEG_MI_train_new = EEG_MI_train;
% Select channels for various data
EEG_MI_train_new.smt = EEG_MI_train.smt(:,:,ChanIndex); % smt
EEG_MI_train_new.x = EEG_MI_train.x(:,ChanIndex); % x
EEG_MI_train_new.chan = EEG_MI_train.chan(ChanIndex); % chan
if isfield(EEG_MI_train,'pre_rest')
    EEG_MI_train_new.pre_rest = EEG_MI_train.pre_rest(:,ChanIndex); % pre_rest
    EEG_MI_train_new.post_rest = EEG_MI_train.post_rest(:,ChanIndex); % post_rest
end