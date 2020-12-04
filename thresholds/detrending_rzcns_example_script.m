% Script for showing an example of the empirical distribution

load outputs/reals.mat
real = reals{3,1};
clear reals;

load thresholds/trendfuns.mat;
trend = trendfuns(3,:);
clear trendfuns;

[rs, rs_de] = r_dis(real, trend);

rs_vec = cell2vec(rs);
rs_de_vec = cell2vec(rs_de);


plot_rzcn_hist(rs_vec, OPTIONS().binsize, 9);
print -depsc figs/rzcn

plot_rzcn_hist(rs_de_vec, OPTIONS().binsize, 9);
print -depsc figs/rzcn_de

