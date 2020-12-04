% Helper function for outputting "0" if no istar has been found
%
% INPUTS:
% istar: istar value found by any of the approaches
%
% OUTPUTS:
% istar: the istar array if it is not empty while 0 if it is empty 

function istar = ifnoistar(istar)
    if isempty(istar)
        istar = 0;
    end
end