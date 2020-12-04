% Script to find the Euclidean distances of the trends estimated by the
% ratio, energy, energy-ratio approach for all the possible values for p
% Step 3


global ps;
global binsize;

ps = OPTIONS().ps;
binsize = OPTIONS().binsize;
ts = 1:2000;


disp('optimal p test');
load outputs/reals.mat;
load outputs/rzcns.mat;
load thresholds/trendfuns.mat;
[ed_r, ed_e, ed_er] = cell_p_test(reals, rzcns, trendfuns);
clear reals.mat;
clear rzcns.mat;
clear trendfun.mat;
save outputs/ed_r.mat ed_r;
save outputs/ed_e.mat ed_e;
save outputs/ed_er.mat ed_er;



% Measure the distance from the predicted trend to the original trend for
% each time series in each set of realisations
%
% INPUTS:
% reals: cell array of all the sets of realisations
% rzcns: cell array of all the R_i distributions
% trends: array of the trends used to make the sets of realisations
%
% OUTPUTS:
% ed_r_mat: Euclidean distance of the predicted trends using the ratio 
%           approach for all sets of realisations 
% ed_e_mat: Euclidean distance of the predicted trends using the energy 
%           approach for all sets of realisations 
% ed_er_mat: Euclidean distance of the predicted trends using the
%            energy-ratio approach for all sets of realisations

function [ed_r_mat, ed_e_mat, ed_er_mat] = cell_p_test(reals, rzcns, trends)
    global ps;
    ed_r_mat = zeros([size(reals) length(ps)]);
    ed_e_mat = zeros(size(reals));
    ed_er_mat = zeros([size(reals) length(ps)]);
    for i=1:size(reals, 1)
        disp(i);
        for j=1:size(reals, 2)
            [ratio_results, energy_results, energyratio_results] = p_test(reals{i,j}, rzcns{i,j}, trends(i,:));
            ed_r_mat(i,j,:) = ratio_results;
            ed_e_mat(i,j) = energy_results;
            ed_er_mat(i,j,:) = energyratio_results;
        end
    end
end


% Measure the distance from the predicted trend to the original trend for
% each time series for one set of realisations
%
% INPUTS:
% tss: all the realisations from the set of times series
% rzcns: array of the R_i distribution
% trends: trend used to make the set of realisations
%
% OUTPUTS:
% ed_r_mat: Euclidean distance of the predicted trends using the ratio 
%           approach for all sets of realisations 
% ed_e_mat: Euclidean distance of the predicted trends using the energy 
%           approach for all sets of realisations 
% ed_er_mat: Euclidean distance of the predicted trends using the
%            energy-ratio approach for all sets of realisations

function [ed_r_av, ed_e_av, ed_er_av] = p_test(tss, rzcns, trend)
    global ps;
    global binsize;
    ed_r_av = zeros(length(ps), 1);
    ed_er_av = zeros(length(ps), 1);
    imfss = cell(size(tss, 1), 1); % in each cell there is a 2d matrix of the imfs

    for i=1:size(imfss, 1)
        imfss{i} = emd(tss(i,:));
    end

    ed_e = zeros(1, size(tss,1));
    for i=1:length(ps)
        [left, right] = empCI(rzcns, binsize, ps(i));
        ed_r = zeros(1, size(tss,1));
        ed_er = zeros(1, size(tss,1));
        
        for j=1:size(imfss, 1)
            imfs = imfss{j};
            Zs = count_Zs(imfs(1:end-1,:));
            
            istars_r = ratio_approach(Zs, [left, right]);
            if isempty(istars_r)
                istar_r = size(imfs, 1);
            else
                istar_r = istars_r(1);
            end
            estimated_trend_r = sum(imfs(istar_r:end,:),1);
            ed_r(j) = norm(trend-estimated_trend_r);
            
            istars_er = energyratio_approach(imfs(1:end-1,:), Zs, [left, right]);
            if isempty(istars_er)
                istar_er = size(imfs, 1);
            else
                istar_er = istars_er(1);
            end
            estimated_trend_er = sum(imfs(istar_er:end,:),1);
            ed_er(j) = norm(trend-estimated_trend_er);
            
            istars_e = energy_approach(imfs(1:end-1,:));
            if i==1
                if isempty(istars_e)
                    istar_e = size(imfs, 1);
                else
                    istar_e = istars_e(1);
                end
                estimated_trend_e = sum(imfs(istar_e:end,:),1);
                ed_e(j) = norm(trend-estimated_trend_e);
            end
        end
        ed_r_av(i) = mean(ed_r);
        ed_er_av(i) = mean(ed_er);
    end
    ed_e_av = mean(ed_e);
end