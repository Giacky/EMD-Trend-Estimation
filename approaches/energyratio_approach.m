% Energy-ratio approach implementation based on the description given in [1].
%
% INPUTS:
% imfs: matrix of the IMFs of the time series. Each row is an IMF. Each
%       column is a point
% Z: array of the number of zero crossings for the IMF at index i
% threshs: left and right thresholds for the significance test (optional)
%
% OUTPUTS:
% istars: array of IMF indices where G_i > G_{i-1}

function istar = energyratio_approach(imfs, Z, threshs)
    if nargin == 2 % If thresholds are not given use the predetermined ones
        threshL = OPTIONS().threshL;
        threshR = OPTIONS().threshR;
    else 
        threshL = threshs(1);
        threshR = threshs(2);
    end
    
    % Perform both the energy and energy ratio approach
    is_energy = energy_approach(imfs);
    is_ratio = ratio_approach(Z, [threshL, threshR]);
    
    % Find the first common istar
    j = 1;
    k = 1;
    istar = []; % In the case where no common istar is found
    while j <= length(is_energy) && k <= length(is_ratio)
        if is_energy(j) > is_ratio(k)
            k = k + 1;
        elseif is_energy(j) < is_ratio(k)
            j = j + 1;
        else
            istar = is_energy(j);
            break
        end
    end
    
    % If no output variable is assigned plot both the ratio and energy
    % approach graphs
    if nargout ==  0
        energy_approach(imfs);
        ratio_approach(Z, [threshL, threshR]);
    end
end

