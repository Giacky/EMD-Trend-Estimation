% Energy approach implementation based on the description given in [1].
%
% INPUTS:
% imfs: matrix of the IMFs of the time series. Each row is an IMF. Each
%       column is a point
%
% OUTPUTS:
% istars: array of IMF indices where G_i > G_{i-1}
% G: array of the energies calculated for each IMF

function [istars, G] = energy_approach(imfs)
    istars = zeros(size(imfs, 1), 1);
    G = zeros(size(imfs, 1), 1);
    
    % Calculate the energy for each IMF
    for j = 1:length(G)
        G(j) = sum(imfs(j,:).^2);
    end
    
    % Save in istars all the indices i where G_i > G_{i-1}
    i = 1;
    for j = 2:length(G)
        if G(j) > G(j-1)
            istars(i) = j;
            i = i + 1;
        end
    end
    istars(i:end) = [];
    
    % If no output variable is assigned plot the energy approach graph
    if nargout ==  0
         x_plot = 1:length(G);
        if OPTIONS().logplot
            Gp = log2(G);
            y_lab = 'log_2 G^i';
        else
            Gp = G;
            y_lab = 'G^i';
        end
        
        figure('Name', 'Energy Approach', 'Renderer', 'painters', 'Position', [0 0 900 300]);
        plot(x_plot, Gp, '-o', 'LineWidth',OPTIONS().linew,...
            'Color', 'blue',...
            'MarkerSize', OPTIONS().mars,...
            'MarkerFaceColor', 'blue');
        hold on;
        plot(istars, Gp(istars), 'x', 'LineWidth',OPTIONS().linew,...
            'MarkerSize',OPTIONS().mars*2,...
            'Color', 'red');
        xticks(1:length(G));
        xlabel('i');
        ylabel(y_lab);
        set(gca,'FontSize',OPTIONS().fonts)
        hold off;
    end
    if nargout ~= 2
        G = [];
    end
end