function Zs = count_Zs(imfs)
    Zs = zeros(size(imfs,1), 1);
    for j=1:length(Zs)
        [~, ~, zero_crossings] = extr(imfs(j,:));
        Zs(j) = length(zero_crossings);
    end
end