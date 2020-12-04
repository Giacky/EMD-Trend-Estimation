ts = 1:2000;

syms t;
noise_fun = piecewise(0<=t<1000, 0, 1000<=t<=2000, sin(0.5.*(t-1000)));
noise = double(subs(noise_fun, t, ts));

trendfun = @(t) sin(0.01 .* t);
trend = trendfun(ts);

% s = trend + noise;
% save simulated_ts/simfuns/fun5.mat s;
load simulated_ts/simfuns/fun5.mat;


figure('Name', 'Function 5', 'Renderer', 'painters', 'Position', [0 0 900 300]);
plot(s, 'LineWidth',1);
hold on;
plot(trend, 'LineWidth',2);
xlim([0 2000]);
legend({'Signal', 'Trend'}, 'Location','best');
set(gca,'FontSize',OPTIONS().fonts)
print -depsc figs/fun5

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


% IMFs
figure('Name', 'IMF1', 'Renderer', 'painters', 'Position', [0 0 1000 200]);
plot(imfs(1,:), 'LineWidth',1);
set(gca,'FontSize',20)
print -depsc figs/imf1

figure('Name', 'IMF2', 'Renderer', 'painters', 'Position', [0 0 1000 200]);
plot(imfs(2,:), 'LineWidth',1);
set(gca,'FontSize',20)
print -depsc figs/imf2

figure('Name', 'IMF3', 'Renderer', 'painters', 'Position', [0 0 1000 200]);
plot(imfs(3,:), 'LineWidth',1);
set(gca,'FontSize',20)
print -depsc figs/imf3

figure('Name', 'IMF4', 'Renderer', 'painters', 'Position', [0 0 1000 200]);
plot(imfs(4,:), 'LineWidth',1);
set(gca,'FontSize',20)
print -depsc figs/imf4