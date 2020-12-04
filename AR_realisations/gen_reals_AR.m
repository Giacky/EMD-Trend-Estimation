% Generate a set of realisations with a given trend and AR process
%
% INPUTS:
% N: Number of realisatons to generate
% trend: trend of the signal
% phi: coefficients of the AR process
% std: standard deviation of the gaussian noise applied to the AR process
%
% OUTPUTS:
% out: set of realisations

function out = gen_reals_AR(N, trend, phi, std)
    n = length(trend);
    out = zeros(N, n);
    
    for i=1:N
        out(i,:) = AR(phi, std, n);
    end
    out = out + trend;
end