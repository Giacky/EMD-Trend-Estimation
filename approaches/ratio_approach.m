% Ratio approach implementation based on the description given in [1].
%
% INPUTS:
% Z: array of the number of zero crossings for the IMF at index i
% threshs: left and right thresholds for the significance test (optional)
%
% OUTPUTS:
% istars: array of IMF indices which are outside the confidence interval

function istars = ratio_approach(Z, threshs)
    if nargin == 1 % If thresholds are not given use the predetermined ones
        threshL = OPTIONS().threshL_rat;
        threshR = OPTIONS().threshR_rat;
    else 
        threshL = threshs(1);
        threshR = threshs(2);
    end
    
    % Calculate R_i for i >= 2
    R = zeros(1, length(Z));
    for j = 2:length(Z)
        R(j) = Z(j-1) ./ Z(j);
    end
    R_ = R(2:end);
    
    % Save in istars all the indices i whose R_i are outside the confidence
    % interval
    istars = zeros(2, length(R));
    i = 1;
    for j = 2:length(R)
        if R(j) < threshL || R(j) > threshR
            istars(i) = j;
            i = i + 1;
        end
    end
    
    istars(i:end) = [];   
    
    % If no output variable is assigned plot the ratio approach graph
    if nargout ==  0
        x_plot = 2:length(Z);
        if OPTIONS().logplot
            Rp_ = log2(R_);
            Rp = log2(R(istars));
            threshLp = log2(threshL);
            threshRp = log2(threshR);
            y_lab = 'log_2 R^i';
        else
            Rp_ = R_;
            Rp = R(istars);
            threshLp = threshL;
            threshRp = threshR;
            y_lab = 'R^i';
        end
        
        figure('Name', 'Ratio Approach', 'Renderer', 'painters', 'Position', [0 0 900 300]);
        plot(x_plot, Rp_, '-o', 'LineWidth', OPTIONS().linew,...
            'Color', 'blue',...
            'MarkerSize', OPTIONS().mars,...
            'MarkerFaceColor', 'blue');
        hold on;
        plot(istars, Rp, 'x', 'LineWidth', OPTIONS().linew,...
            'MarkerSize', OPTIONS().mars*2,...
            'Color', 'red');
        yline(threshLp, '--', 'LineWidth', OPTIONS().linew,...
            'Color', 'magenta');
        yline(threshRp, '--', 'LineWidth', OPTIONS().linew,...
            'Color', 'magenta');
        xlim([1 length(R)]);
        xticks(1:length(R));
%         ylim([0 inf]);
        xlabel('i');
        ylabel(y_lab);
        set(gca,'FontSize',OPTIONS().fonts);
        hold off;
    end
end