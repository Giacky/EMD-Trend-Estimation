ts = 1:2000;

noise = AR([0.8 -0.4], 1.5, 2000);


trend = spline([0 500 750 1250 1750 2000], [-1 2 -0.5 3 1.5 2], ts);


% s = trend + noise;
% save simulated_ts/simfuns/fun2.mat s;
load simulated_ts/simfuns/fun2.mat;

pl_i = OPTIONS().pl_i;
mars = [6, 12];
linew = [1, 2];
fonts = [10, 20];


figure('Name', 'Function 2', 'Renderer', 'painters', 'Position', [0 0 900 300])
plot(s, 'LineWidth',1);
hold on;
plot(trend, 'LineWidth',2);
xlim([0 2000]);
legend({'Signal', 'Trend'}, 'Location','best');
set(gca,'FontSize',OPTIONS().fonts)
print -depsc figs/fun2


imfs = emd(s);
res = imfs(end,:);
imfs(end,:)=[];
Zs = count_Zs(imfs);

istar = calc_istar([imfs; res], trend);

istar_rat = ratio_approach(Zs);
istar_rat = istar_rat(1);
istar_ene = energy_approach(imfs);
istar_ene = istar_ene(1);
istar_enerat = energyratio_approach(imfs, Zs);
istar_lin = lineartrends_approach(imfs, res);

trend_rat = sum(imfs(istar_rat:end,:), 1) + res;
trend_ene = sum(imfs(istar_ene:end,:), 1) + res;
trend_enerat = sum(imfs(istar_enerat:end,:), 1) + res;
trend_lin = sum(imfs(istar_lin:end,:), 1) + res;