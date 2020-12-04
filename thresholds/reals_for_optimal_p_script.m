% Script for making the realisations used in finding the thresholds
% Step 1

R = 5000;
stds = [0.05 0.1 0.2 0.3 0.4];
AR = [0.8 -0.4];

disp('making reals');
load thresholds/trendfuns.mat;
reals = reals_cel(R, trendfuns, stds, AR);
disp('saving...')
save('outputs/reals.mat', 'reals', '-v7.3')
clear reals;
clear trendfuns;


function reals_cell = reals_cel(R, trends, stds, AR)
    reals_cell = cell(size(trends,1), length(stds));
    for i=1:size(reals_cell,1)
        for j=1:size(reals_cell,2)
            reals_cell{i,j} = gen_reals_AR(R, trends(i,:), AR, stds(j));
        end
    end
end
