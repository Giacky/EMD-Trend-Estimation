% For each set of realization, find p1, p2 and the resulting range for
% the optimal p
%
% INPUTS:
% ed_e: Euclidean distance of the energy approach
% ed_er: Euclidean distnace of the energy-ratio approach
%
% OUTPUTS:
% prange: minimum and maximum values for the optimal p
% pstars: the values for p1 and p2 for every set of realisations

function [prange, pstars] = findpstar(ed_e, ed_er)
    pstars = zeros([size(ed_e),2]); % p1 at indices pstars(:,:,1) and p2 at indices pstars(:,:,2)
    for i=1:size(ed_er, 1)
        for j=1:size(ed_er, 2)
            pstars(i, j, :) = findps(ed_e(i,j), reshape(ed_er(i,j,:), 1, []));
        end
    end
    p1 = max(pstars(:,:,1), [], 'all');
    p2 = max(pstars(:,:,2), [], 'all');
    prange = [p1,p2];
end


% For a set of realisations, find the first value for p where ed_er < ed_e
% (p1) and consequently, find the value for p where ed_er is at a minimum 
%
% INPUTS:
% ed_e: Euclidean distance of the energy approach
% ed_er: Euclidean distnace of the energy-ratio approach
%
% OUTPUTS:
% prange: the range of the optimal p for a given set of realisations, ie.
% the value for p1 and p2

function prange = findps(ed_e, ed_er)
    i=1;
    while i<=length(ed_er)
        if ed_er(i) < ed_e
            break
        end
        i = i+1;
    end
    p1i = i;
    while i<length(ed_er)
        if ed_er(i) < ed_er(i+1)
            break;
        end
        i = i+1;
    end
    p2i = i;
    all_ps = OPTIONS().ps;
    if p1i <= length(all_ps)
        p1 = all_ps(p1i);
    else 
        p1 = 0;
    end
    if p1i <= length(all_ps)
        p2 = all_ps(p2i);
    else
        p2 = 0;
    end
    prange = [p1, p2];
end