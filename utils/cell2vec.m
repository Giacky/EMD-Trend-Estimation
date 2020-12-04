% Helper function which converts a cell array containing vectors of various
% lengths into a single vector.
%
% INPUTS:
% cells: cell array with vectors in each index
%
% OUTPUTS:
% vector: all the contents of each vector inside the cell array in a single
% vector

function vector = cell2vec(cells)
    vector = zeros(1, round(size(cells, 1) .* (length(cells{1})+1.5)));
    k=1;
    for i=1:length(cells)
        elements = cells{i};
        for j=1:length(elements)
            vector(k) = elements(j);
            k = k+1;
        end
    end
    vector(k:end) = [];
end