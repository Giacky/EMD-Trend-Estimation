% Plot the linear regression lines/planes with the points assigned.
%
% INPUTS:
% X: points to be plotted (can be either 2D or 3D)
% W: regression weights for each line/plane (can be either 2D or 3D)
% Y_pred: predicted assignment of the points to the lines/planes
% Y_real: real assignment of the points to the lines/planes (for simulated
% time series)

function plot_regmix(X, W, Y_pred, Y_real)
    noise_pred = X(~Y_pred,:);
    trend_pred = X(Y_pred,:);
    
    figure('Name', 'RegMix Approach', 'Renderer', 'painters', 'Position', [0 0 900 300]);
    % Real values
    real_legend = {};
    if nargin == 4
        noise_real = X(~Y_real,:);
        trend_real = X(Y_real,:);
        if size(X, 2) == 3 % If X is 3D
            scatter3(noise_real(:,1), noise_real(:,2), noise_real(:,3), OPTIONS().mars*10, 'blue', 'o', 'LineWidth', OPTIONS().linew);
            hold on;
            scatter3(trend_real(:,1), trend_real(:,2), trend_real(:,3), OPTIONS().mars*10, 'red', 'o', 'LineWidth', OPTIONS().linew);
        else % If X is 2D
            scatter(noise_real(:,1), noise_real(:,2), OPTIONS().mars*10, 'blue', 'o', 'LineWidth', OPTIONS().linew);
            hold on;
            scatter(trend_real(:,1), trend_real(:,2), OPTIONS().mars*10, 'red', 'o', 'LineWidth', OPTIONS().linew);
        end
        hold on;
        real_legend = {'Real Noise', 'Real Trend'};
    end
    
    % Predicted values
    if size(X, 2) == 3 % If X is 3D
        scatter3(noise_pred(:,1), noise_pred(:,2), noise_pred(:,3), OPTIONS().mars*10, 'blue', 'x', 'LineWidth', OPTIONS().linew);
        hold on;
        scatter3(trend_pred(:,1), trend_pred(:,2), trend_pred(:,3), OPTIONS().mars*10, 'red', 'x', 'LineWidth', OPTIONS().linew);
    else % If X is 2D
        scatter(noise_pred(:,1), noise_pred(:,2), OPTIONS().mars*10, 'blue', 'x', 'LineWidth', OPTIONS().linew);
        hold on;
        scatter(trend_pred(:,1), trend_pred(:,2), OPTIONS().mars*10, 'red', 'x', 'LineWidth', OPTIONS().linew);
    end  
    hold on;
    
    % Regression planes/lines
%     min_x = floor(min(X(:,1)));
    min_x = 0;
    max_x_n = ceil(max(X(~Y_pred,1)));
    max_x_t = ceil(max(X(Y_pred,1)));
    if size(X, 2) == 3 % If X is 3D
        min_y = floor(min(X(:,2)));
        max_y = ceil(max(X(:,2)));
        [xx, yy] = meshgrid([min_x,max_x], [min_y,max_y]);
        zz1 = W(1,1) + W(2,1).*xx + W(3,1).*yy;
        zz2 = W(1,2) + W(2,2).*xx + W(3,2).*yy;
        edge_alpha = 0.8;
        face_alpha = 0.1;
        mesh(xx, yy, zz1, 'EdgeAlpha', edge_alpha, 'FaceAlpha', face_alpha, 'EdgeColor', 'blue', 'FaceColor', 'blue');
        hold on;
        mesh(xx, yy, zz2, 'EdgeAlpha', edge_alpha, 'FaceAlpha', face_alpha, 'EdgeColor', 'red', 'FaceColor', 'red');
        ylabel('G^i');
        zlabel('D^i');
    else % If X is 2D
        xx1 = [min_x, max_x_n];
        xx2 = [min_x, max_x_t];
        yy1 = W(1,1) + W(2,1).*xx1;
        yy2 = W(1,2) + W(2,2).*xx2;
        plot(xx1, yy1, 'blue', 'LineWidth',OPTIONS().linew);
        plot(xx2, yy2, 'red', 'LineWidth',OPTIONS().linew);
        for i=1:size(X,1)-1 % Show IMF index
            text(X(i,1), X(i,2), strcat("      ", string(i)), 'FontSize', OPTIONS().fonts/2, 'VerticalAlignment','bottom','HorizontalAlignment','center');
        end
        text(X(end,1), X(end,2),"     res", 'FontSize', OPTIONS().fonts/2, 'VerticalAlignment','bottom','HorizontalAlignment','center');
        ylabel('D^i');
    end
    
    legend([real_legend, {'Predicted Noise', 'Predicted Trend'}], 'Location','best');
%     legend([real_legend, {'Noise IMF', 'Trend IMF'}], 'Location','best');
    hold off;
    xlabel('G^i');
    set(gca,'FontSize',OPTIONS().fonts)
end