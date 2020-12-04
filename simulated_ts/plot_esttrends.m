% From the simulated examples, plot the original and the estimated trends
%
% INPUTS:
% trend: the original trend of the time series
% imfs: the imfs of the time series
% res: the EMD residual of the time series
% istars_ests_arr: the estimated istars for the ratio, energy, energy-ratio
% and linear regressions approach. (0 if no istar was found)

function plot_esttrends(trend, imfs, res, istars_ests_arr)
    istars_ests_unique = unique(istars_ests_arr);
    istars_ests_cell = cell(1, length(istars_ests_unique));
    for j=1:length(istars_ests_unique)
        istars_ests_cell{j} = istars_ests_unique(j);
    end
    if istars_ests_cell{1} == 0
        istars_ests_cell{1} = [];
    end
    
    labels = label_esttrends(istars_ests_arr);
    figure('Name', 'Trend vs estimated trends', 'Renderer', 'painters', 'Position', [0 0 900 300]);
    legend_list = [{'Original Trend'} labels];
    plot(trend, 'red', 'LineWidth', 1);
    colors = {'green', 'magenta', 'cyan'};
    for i=1:length(istars_ests_cell)
        hold on;
        plot(sum(imfs(istars_ests_cell{i}:end,:), 1) + res, colors{i}, 'LineWidth',1);
    end
    legend(legend_list, 'Location','best');
    set(gca,'FontSize',20)
end