function ppl= ppl_plot(UIAxes, ppl)

plotOpt = ppl.plotOpt;

if plotOpt.timeAvg
    boxchart(UIAxes, ppl.trialGroup, ppl.avg_pupil, 'GroupByColor', ppl.trialGroup)
    axis(UIAxes, 'auto');
else

legendLabels  = {};
if plotOpt.groupAvg
    nGroups = unique( ppl.trialGroup);
    nGroups(isnan(nGroups)) = [];
    for i_group = 1:length(nGroups)
        idx = ppl.trialGroup==nGroups(i_group);
        n_group = sum(~isnan(ppl.trial_pupil(1,  idx)));
        data2plot = mean( ppl.trial_pupil(:,  idx)', 'omitnan');
        time2plot =  ppl.trial_time(:, ppl.i_trial);

        se2plot = std( ppl.trial_pupil(:,  idx)', 'omitnan') ./ sqrt(sum( idx));
        patchX = [ time2plot', fliplr(time2plot')];
        patchY = [ data2plot+se2plot,  fliplr( data2plot-se2plot)];

        h = plot( UIAxes,  time2plot,  data2plot,'LineWidth', 1.5); % get color after plot from handle
        hold( UIAxes, 'on')
        patch( UIAxes, patchX, patchY,  h.Color, 'FaceAlpha',.3, 'EdgeColor', 'none'); % use color from handle
        
        legendLabels{end+1} = ['group' num2str(i_group) ' N: ' num2str(n_group)];
        legendLabels{end+1} = '';
    end
    
else
    
    if plotOpt.raw
        data2plot =  ppl.trial_raw(:, ppl.i_trial);
        time2plot =  ppl.trial_time(:, ppl.i_trial);
        plot( UIAxes,  time2plot,  data2plot, 'LineWidth', 1.5);
        hold( UIAxes, 'on')
        legendLabels{end+1} = 'raw data';
    end
    
    data2plot =  ppl.trial_pupil(:, ppl.i_trial);
    time2plot =  ppl.trial_time(:, ppl.i_trial);
    plot( UIAxes,  time2plot,  data2plot, 'LineWidth', 1.5);
    hold( UIAxes, 'on')
    legendLabels{end+1} = 'trial data';
end

if plotOpt.stats
    yLim = ylim( UIAxes);
    x =  time2plot(logical( ppl.H));
    y = repmat(yLim(1) - diff(yLim)*.1, 1, length(x));
    plot( UIAxes, x, y, 'rs')
    legendLabels{end+1} = 'p<.05';
end

if plotOpt.baseline
    patchX = [plotOpt.baselineRange(1) plotOpt.baselineRange(1) plotOpt.baselineRange(2) plotOpt.baselineRange(2)];
    patchY = [ylim( UIAxes) fliplr(ylim( UIAxes)) ];
    patch( UIAxes, patchX, patchY, [.3 .3 .3], 'FaceAlpha', .5, 'EdgeColor', 'none')
    legendLabels{end+1} = 'baseline';
end


if plotOpt.legend
    % use grouplabels for legend
    legend(UIAxes,'on')
    legend(UIAxes, legendLabels, 'location', 'northwest')
else
    legend(UIAxes,'off')
end

axis(UIAxes, 'tight');
hold(UIAxes, 'off');
end
end