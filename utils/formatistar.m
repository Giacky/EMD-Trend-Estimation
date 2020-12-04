% Helper function that performs both ifnoistar and ifmanyistar
%
% INPUTS:
% istar: istar value found by any of the approaches
%
% OUTPUTS:
% istar: the first istar of the array if it is not empty, and 0 if it is empty 

function istar = formatistar(istar)
    istar = ifmanyistar(ifnoistar(istar));
end