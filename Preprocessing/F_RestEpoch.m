function [rest_epoch,t] = F_RestEpoch(x,t_raw,y_dec,t_init,t_end)

right_t = t_raw(y_dec==1);
left_t = t_raw(y_dec==2);

t = [right_t(1:2:50) left_t(1:2:50)];

n_events = length(t);
n_channels = size(x,2);
rest_epoch = zeros(t_end-t_init,n_events,n_channels);
for i = 1:n_events
    x_mean = mean(x(t(i)-1000-t_end - 250:t(i)-1000-t_end,:),1);
    rest_epoch(:,i,:) = x((t(i)-1000-t_end):(t(i)-1000-t_init-1),:) - x_mean; % Linear Base Correction
end

end