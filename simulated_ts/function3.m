ts = 1:2000;

noise1_fun = @(t) 0.2 .* sin(t./9);
noise2_fun = @(t) (1./3) .* sin(t./2);
noise3_fun = @(t) 0.5 .* sin(t./21);

noise_fun = @(t) noise1_fun(t) + noise2_fun(t) + noise3_fun(t);

noise = noise_fun(ts);


trend = spline([0 200 500 1000 1500 1800 2000], [3.5 3 2 1 2 3 3.5], ts);

% s = trend + noise;
% save simulated_ts/simfuns/fun3.mat s;
load simulated_ts/simfuns/fun3.mat;

pl_i = OPTIONS().pl_i;
mars = [6, 12];
linew = [1, 2];
fonts = [10, 20];

figure('Name', 'Function 3', 'Renderer', 'painters', 'Position', [0 0 900 300]);
plot(s, 'LineWidth',1);
hold on;
plot(trend, 'LineWidth',2);
xlim([0 2000]);
legend({'Signal', 'Trend'}, 'Location','best');
set(gca,'FontSize',OPTIONS().fonts)
print -depsc figs/fun3

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
