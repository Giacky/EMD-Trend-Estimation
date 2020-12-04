% Makes labels with the approaches' names for all the estimated trends
% (used for plotting)
%
% INPUTS:
% istars: array istar estimations from the four approaches
%
% OUTPUTS:
% labels: labels for each unique trend with the approaches' names

function labels = label_esttrends(istars)
    istars_unique = unique(istars);
    different_trends = cell(1, length(istars_unique));
    
    approach_names = {'Ratio', 'Energy', 'Energy-Ratio', 'Linear Regressions'};
    
    for i=1:length(istars_unique)
        k=1;
        temp = cell(1, length(istars));
        for j=1:length(istars)
            if istars_unique(i) == istars(j)
                temp{k} = approach_names{j};
                k = k + 1;
            end
        end
        temp(k:end) = [];
        different_trends{i} = temp;
    end
    
    labels = cell(1,length(different_trends));
    
    for i=1:length(labels)
        labels{i} = strjoin(different_trends{i},', ');
    end
end