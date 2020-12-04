% BJ sales data results with graphs

sales = readmatrix('real_ts/datasets/BJsales.csv');
s = sales(:,3)';
t = sales(:,2)';
comps = emd(s);
res = comps(end,:);
imfs = comps(1:end-1,:);
Zs = count_Zs(imfs);
ratio_approach(Zs);
print -depsc figs/sales_rat
energy_approach(imfs);
print -depsc figs/sales_ene
lineartrends_approach(imfs, res);
print -depsc figs/sales_lin

istar_rat = ifmanyistar(ratio_approach(Zs));
istar_ene = ifmanyistar(energy_approach(imfs));
istar_enerat = energyratio_approach(imfs, Zs);
istar_lin = lineartrends_approach(imfs, res);
disp([ifnoistar(istar_rat), ifnoistar(istar_ene), ifnoistar(istar_enerat), ifnoistar(istar_lin)]);

istars_ests = [istar_rat istar_ene istar_enerat istar_lin];
istars_ests_unique = unique(istars_ests);
labels = label_esttrends(istars_ests);

% Original signal
figure('Name', 'BJ Sales', 'Renderer', 'painters', 'Position', [0 0 900 300]);
plot(t, s, 'LineWidth',1);
set(gca,'FontSize',20);
xlim([min(t)  max(t)]);
xlabel('Time');
ylabel('Sales (indicator)');
print -depsc figs/sales

% Estimated trends
figure('Name', 'BJ Sales estimate', 'Renderer', 'painters', 'Position', [0 0 900 300]);
plot(t, s, 'LineWidth',1);
legend_list = [{'Signal'} labels];
for i=1:length(istars_ests_unique)
    hold on;
    plot(t, sum(imfs(istars_ests_unique(i):end,:), 1) + res, OPTIONS().colors{i}, 'LineWidth',1);
end
legend(legend_list, 'Location','best');
set(gca,'FontSize',20);
xlim([min(t)  max(t)]);
xlabel('Time');
ylabel('Sales (indicator)');
print -depsc figs/sales_est

% Detrended signal
figure('Name', 'BJ Sales det', 'Renderer', 'painters', 'Position', [0 0 900 300]);
plot(t, s-(sum(imfs(max(istars_ests_unique):end,:), 1) + res), 'LineWidth',1);
set(gca,'FontSize',20)
xlim([min(t)  max(t)]);
xlabel('Time');
ylabel('Sales (indicator)');
print -depsc figs/sales_det