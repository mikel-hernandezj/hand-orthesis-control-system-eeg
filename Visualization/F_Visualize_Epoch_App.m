function F_Visualize_Epoch_App(app,fs,trial)

x_20chan = squeeze(app.preprocessed.smt(:,trial,:));
Channels = app.preprocessed.Channels;
% rejected_datapoints = app.preprocessed.rejected_datapoints(:,trial);
scale = app.ScaleEditField.Value;

cla(app.UIAxes,'reset');
l_chan = length(Channels);
% Plot signals
T = 1/fs;
TimeVect = 0:T:T*size(x_20chan,1)-T;
ylim(app.UIAxes,[-scale scale*l_chan]);
yticks(app.UIAxes,0:scale:scale*l_chan);
yticklabels(app.UIAxes,Channels);
% Give color to MI channels
MI_chan_idx = [33,9,10,34,11,35,13,36,14,37,15,38,18,39,19,40,20,41,21];
for k = 1:l_chan
    hold (app.UIAxes,'on');
    if sum(k == MI_chan_idx) == 0
        plot(app.UIAxes,TimeVect, x_20chan(:,k) + scale*(k-1),'black')
    else
        plot(app.UIAxes,TimeVect, x_20chan(:,k) + scale*(k-1),'blue')
        app.UIAxes.YTickLabel{k} =  ['\color{blue}' app.UIAxes.YTickLabel{k}];
    end
end

app.EditField_2.Value = trial;
app.EditField.Value = app.preprocessed.reject(trial);


if (app.preprocessed.autoreject(trial) == 0)
    app.Lamp.Color = [0.00,1.00,0.00];
else
    app.Lamp.Color = [1.00,0.00,0.00];
end
    

end