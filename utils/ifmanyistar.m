% Helper function for outputting only the first istar found if many were 
% found. In the case where no istar has been found the original empty array
% is outputted
%
% INPUTS:
% istar: istar value found by any of the approaches
%
% OUTPUTS:
% istar: the first item of the istar array if it is not empty. If istar is 
% empty nothing is done

function istar = ifmanyistar(istar)
    if length(istar) > 1
        istar = istar(1);
    end
end