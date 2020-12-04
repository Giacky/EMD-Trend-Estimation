% Calculates the RZCNs of the time series. It outputs both the entire 
% distribution and the one based on the detrended mix.
%
% INPUTS:
% tss: matrix of time series realisations
% trend: single trend on with which the realisations were made (optional)
%
% OUTPUTS:
% rzcns: cell array containing vectors of the ratios calculated for each
%        realisation
% rzcns_de: cell array containing vectors of the ratios calculated for each
%           detrended realisation. This is only outputted if the optional
%           "trend" parameter is specified

function [rzcns, rzcns_de] = r_dis(tss, trend)
    nsims = size(tss, 1);
    rzcns = cell(nsims, 1);
    rzcns_de = cell(nsims, 1);

    for i=1:nsims
        imfs = emd(tss(i,:));
        
        if nargin == 2 
            istar = calc_istar(imfs, trend);
            if isempty(istar) 
                istar = size(imfs, 1);
            end
            imfs_de = imfs;
            imfs_de(istar:end,:) = [];
            rzcns_de{i} = count_Rs(imfs_de);
        end
        
        imfs(end, :) = [];
        rzcns{i} = count_Rs(imfs);
    end
end