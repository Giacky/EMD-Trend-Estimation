% Find the mean left and right thresholds for the ratio approach for the 
% for all time series of every set of realisations
%
% INPUTS:
% rzcns_cell: cell array containing a vector of all R_i from a given set of
%             realisations
% p: p value to be used for finding the thresholds
%
% OUTPUTS:
% threshL: Left threshold
% threshR: Right threshold

function [threshL, threshR] = find_thresholds(rzcns_cell, p)
    threshmatL = zeros(size(rzcns_cell));
    threshmatR = zeros(size(rzcns_cell));
    for i=1:size(rzcns_cell, 1)
        for j=1:size(rzcns_cell, 2)
            [threshmatL(i,j), threshmatR(i,j)] = empCI(rzcns_cell{i,j}, OPTIONS().binsize, p);
        end
    end
    threshL = mean(threshmatL, 'all');
    threshR = mean(threshmatR, 'all');
end