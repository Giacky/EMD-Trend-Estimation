% Linear regressions approach implementation.
%
% INPUTS:
% imfs: matrix of the IMFs of the time series. Each row is an IMF. Each
%       column is a point
% res: residual of the EMD method
% Y_real: logical array for labelling which IMFs are part of the trend
%         and which are not. Used in plotting (optional)
%
% OUTPUTS:
% istar: the index stating from which IMF onwards the trend is made
% W: matrix of the weights of the two linear regressions found
% prbs: matrix of the likelihood that a given component is part of the
%       noise or trend
% d:    distance of each point from each regression line

function [istar, W, prbs, d] = lineartrends_approach(imfs, res, Y_real)
    comps = [imfs; res];
    ts = 1:size(comps, 2);
    
    % Energies are calculated for each component
    [~, G] = energy_approach(comps);
    
    % Dominant frequency is calculated for each component
    D = zeros(size(comps, 1), 1);
    for k=1:size(comps, 1)
        D(k) = dominant_frequency(ts, comps(k,:));
    end
    
    % The two linear regressions are made
    W = [0, D(end); D(1)/G(1), 0];
    
    % Distance between the regression line and the points is calculated
    Gb = [ones(size(G,1), 1), G];
    d = (D - (Gb * W)).^2;
    
    % Probabilities for each component is calculated
    prbs = d ./ sum(d,2);
    
    % Each component is assigned to either the noise or the trend
    [~, clusters] = min(prbs,[], 2);
    
    % In the case where the assignemnt of the components is not continuous,
    % find the last noise IMF and the trend is composed from next component
    % onwards
    istar = find(clusters == 1, 1, 'last')+1; % The last group of 2s
    if istar == length(clusters) % Return empty array if only the residual is part of the trend
        istar = [];
    end
    
    % Assign to the Noise line any potential IMF where i<istar that is 
    % closer to the Trend line
    clusters(1:istar-1) = 1; 
    
    
    % Output and plot the graphs depending on the number of input and
    % output arguments
    if nargout ==  0 || nargin == 3
        Y_pred = logical(clusters-1);
        if nargin == 3
            plot_regmix([G, D], W, Y_pred, Y_real);
        else
            plot_regmix([G, D], W, Y_pred);
        end
    end
    if nargout <  2
        W = [];
    end
    if nargout < 3
        prbs = [];
    end
    if nargout < 4
        d = [];
    end
end