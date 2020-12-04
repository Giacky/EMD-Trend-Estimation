function [mu, sigma] = plot_rzcn_hist(rzcns, binw, xmax)
    [mu, sigma] = normfit(rzcns);
    x = 0:.01:4;
    y = normpdf(x,mu,sigma) .* binw .* length(rzcns);
    figure;
    histogram(rzcns, 'BinWidth', binw);
    hold on;
%     plot(x, y, 'LineWidth', 2);
    xlim([0 xmax])
    xlabel('R')
    ylabel('Frequency of R')
    set(gca,'FontSize', 15)
end