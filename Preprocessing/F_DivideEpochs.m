function [smt_lbc] = F_DivideEpochs(x,t,t_init,t_end)
% Description: Divide the data into events. Inputs: x=signal data, t=events, t_init=first sample from event (in samples), t_end=last sample from event (in samples).
n_events = length(t);
n_channels = size(x,2);
smt_lbc = zeros(t_end-t_init,n_events,n_channels);
for i = 1:n_events
    x_mean = mean(x(t(i) - 250:t(i),:),1);
    smt_lbc(:,i,:) = x((t(i)+t_init+1):(t(i)+t_end),:) - x_mean; % Linear Base Correction
end
end