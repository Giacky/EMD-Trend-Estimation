% Function used to count the ratio of zero crossings between consecutive
% imfs
%
% INPUTS:
% imfs: the matrix of imfs of a given time series
%
% OUTPUTS:
% R: array of the ratios of zero crossings

function R = count_Rs(imfs)
    Zs = count_Zs(imfs);
    
    R = zeros(1, length(Zs));
    for j = 2:length(Zs)
        R(j) = Zs(j-1) ./ Zs(j);
    end
    R = R(2:end);
end