% Simple AR process.
%
% INPUTS:
% phi: array off the AR coefficients
% std: standard deviation of gaussian noise process
% n: length of the AR process made
%
% OUTPUTS:
% s: AR process

function s = AR(phi, std, n)
    s = zeros(1, n);
    for i=1:n
        s(i) = randn * std;
        j = 1;
        while j<=length(phi) && i-j>=1
            s(i) = s(i) + phi(j).*s(i-j);
            j = j+1;
        end
    end
end