% Airline passengers data results with graphs

air = readmatrix('real_ts/datasets/airpassengers.csv');
s = air(:,3)';
t = decyear2datetime(air(:,2)');
comps = emd(s);
res = comps(end,:);
imfs = comps(1:end-1,:);
Zs = count_Zs(imfs);
ratio_approach(Zs);
print -depsc figs/air_rat
energy_approach(imfs);
print -depsc figs/air_ene
lineartrends_approach(imfs, res);
print -depsc figs/air_lin

istar_rat = ifmanyistar(ratio_approach(Zs));
istar_ene = ifmanyistar(energy_approach(imfs));
istar_enerat = energyratio_approach(imfs, Zs);
istar_lin = lineartrends_approach(imfs, res);

istars_ests = [ifnoistar(istar_rat), ifnoistar(istar_ene), ifnoistar(istar_enerat), ifnoistar(istar_lin)];
istars_ests_unique = unique(istars_ests);
labels = label_esttrends(istars_ests);

disp(istars_ests)

tickmin = t(1);
tickmax = dateshift(t(end),'start','year',1);


% Original signal
figure('Name', 'Air Passengers', 'Renderer', 'painters', 'Position', [0 0 900 300]);
plot(t, s, 'LineWidth',1);
set(gca,'FontSize',20);
xlim([min(t)  max(t)]);
xticks(tickmin : calyears(1) : tickmax);
xlabel('Time (years)');
ylabel('Passengers (thousands)');
print -depsc figs/air

% Estimated trends
figure('Name', 'Air Passengers estimate', 'Renderer', 'painters', 'Position', [0 0 900 300]);
plot(t, s, 'LineWidth',1);
legend_list = [{'Signal'} labels];
for i=1:length(istars_ests_unique)
    hold on;
    if istars_ests_unique(i) ~= 0
        plot(t, sum(imfs(istars_ests_unique(i):end,:), 1) + res, OPTIONS().colors{i}, 'LineWidth',1);
    else
        plot(t, res, OPTIONS().colors{i}, 'LineWidth',1);
    end
end
legend(legend_list, 'Location','best');
set(gca,'FontSize',20);
xlim([min(t)  max(t)]);
xticks(tickmin : calyears(1) : tickmax);
xlabel('Time (years)');
ylabel('Passengers (thousands)');
print -depsc figs/air_est

% Detrended signal
figure('Name', 'Air Passengers det', 'Renderer', 'painters', 'Position', [0 0 900 300]);
plot(t, s-res, 'LineWidth',1);
set(gca,'FontSize',20)
xlim([min(t)  max(t)]);
xticks(tickmin : calyears(1) : tickmax);
xlabel('Time (years)');
ylabel('Passengers (thousands)');
print -depsc figs/air_det
