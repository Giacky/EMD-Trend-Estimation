ts = 1:2000;

noise = AR([0.8 -0.4], 0.5, 2000);


syms t
trendfun = piecewise(0<=t<300, t/1000+0.2, 300<=t<700, -t/3000+0.6, 700<=t<900, -t/400+127/60, 900<=t<1500, -t/2000+19/60, 1500<=t<1800, t/600-44/15, 1800<=t<=2000, t/800-131/60);

trend = double(subs(trendfun, t, ts));

% s = trend + noise;
% save simulated_ts/simfuns/fun1.mat s;
load simulated_ts/simfuns/fun1.mat;


figure('Name', 'Function 1', 'Renderer', 'painters', 'Position', [0 0 900 300]);
plot(s, 'LineWidth',1);
hold on;
plot(trend, 'LineWidth',2);
xlim([0 2000]);
legend({'Signal', 'Trend'}, 'Location','best');
set(gca,'FontSize',OPTIONS().fonts)
print -depsc figs/fun1


imfs = emd(s);
res = imfs(end,:);
imfs(end,:)=[];
Zs = count_Zs(imfs);

istar = calc_istar([imfs; res], trend);

istar_rat = ratio_approach(Zs);
istar_ene = energy_approach(imfs);
istar_ene = istar_ene(1);
istar_enerat = energyratio_approach(imfs, Zs);
istar_lin = lineartrends_approach(imfs, res);

trend_rat = sum(imfs(istar_rat:end,:), 1) + res;
trend_ene = sum(imfs(istar_ene:end,:), 1) + res;
trend_enerat = sum(imfs(istar_enerat:end,:), 1) + res;
trend_lin = sum(imfs(istar_lin:end,:), 1) + res;
