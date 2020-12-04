% Script fro calculating all the ratios R_i for every single realisation of
% from all sets of time series
% Step 2

ts = OPTIONS().ts;
%Row is each trend, column is each std, i=1 left thresh, i=2 is right thresh


disp('rzcns test');
load outputs/reals.mat;
rzcns = calc_rzcns(reals);
clear reals;  %freeing up system memory
save outputs/rzcns.mat rzcns


function rzcns = calc_rzcns(reals)
    rzcns = cell(size(reals));
    for i=1:size(reals, 1)
        disp(num2str(i));
        for j=1:size(reals, 2)
            r_cell = r_dis(reals{i,j});
            rzcns{i,j} = cell2vec(r_cell);
        end
    end
end


