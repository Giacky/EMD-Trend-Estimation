% LOD data results with graphs

lod = readmatrix('real_ts/datasets/lod.csv');
s = lod(:,1)';
lodt = lod(:,[2,3,4]);
lodt(:,3) = lodt(:,3) - 0.5;
t = datetime(lodt);
comps = emd(s);
res = comps(end,:);
imfs = comps(1:end-1,:);
Zs = count_Zs(imfs);
ratio_approach(Zs);
print -depsc figs/lod_rat
energy_approach(imfs);
print -depsc figs/lod_ene
lineartrends_approach(imfs, res);
print -depsc figs/lod_lin

istar_rat = ifmanyistar(ratio_approach(Zs));
istar_ene = ifmanyistar(energy_approach(imfs));
istar_enerat = energyratio_approach(imfs, Zs);
istar_lin = lineartrends_approach(imfs, res);

istars_ests = [ifnoistar(istar_rat), ifnoistar(istar_ene), ifnoistar(istar_enerat), ifnoistar(istar_lin)];
istars_ests_unique = unique(istars_ests);
labels = label_esttrends(istars_ests);

disp(istars_ests);

tickmin = dateshift(t(1),'start','year', 3);
tickmax = dateshift(t(end),'start','year');


% Original signal
figure('Name', 'LOD', 'Renderer', 'painters', 'Position', [0 0 900 300]);
plot(t, s, 'LineWidth',0.5);
set(gca,'FontSize',20)
xlim([min(t)  max(t)]);
xtickformat('yyyy');
xticks(tickmin : calyears(5) : tickmax);
xlabel('Time (years)');
ylabel('LOD deviation (ms)');
print -depsc figs/lod

% Estimated trends
figure('Name', 'LOD estimate', 'Renderer', 'painters', 'Position', [0 0 900 300]);
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
xtickformat('yyyy');
xticks(tickmin : calyears(5) : tickmax);
xlabel('Time (years)');
ylabel('LOD deviation (ms)');
print -depsc figs/lod_est

% Signal zoom
start_date = datetime(1995,1,1);
end_date = start_date + calyears(10);
figure('Name', 'LOD zoom', 'Renderer', 'painters', 'Position', [0 0 900 300]);
plot(t, s, 'LineWidth',0.5);
for i=1:length(istars_ests_unique)
    hold on;
    if istars_ests_unique(i) ~= 0
        plot(t, sum(imfs(istars_ests_unique(i):end,:), 1) + res, OPTIONS().colors{i}, 'LineWidth',1);
    else
        plot(t, res, OPTIONS().colors{i}, 'LineWidth',1);
    end
end
legend(legend_list, 'Location','best');
set(gca,'FontSize',20)
xlim([start_date  end_date]);
xtickformat('yyyy');
xticks(tickmin : calyears(1) : tickmax);
xlabel('Time (years)');
ylabel('LOD deviation (ms)');
print -depsc figs/lod_zoom

% Guessed trend
figure('Name', 'LOD guess', 'Renderer', 'painters', 'Position', [0 0 900 300]);
plot(t, s, 'LineWidth',0.5);
hold on;
plot(t, sum(imfs(9:end,:), 1) + res, 'red', 'LineWidth',1);
legend('Signal', "$T_9$", 'Location','best', 'Interpreter','latex');
set(gca,'FontSize',20)
xlim([min(t)  max(t)]);
xtickformat('yyyy');
xticks(tickmin : calyears(5) : tickmax);
xlabel('Time (years)');
ylabel('LOD deviation (ms)');
print -depsc figs/lod_guess

% Detrended signal
figure('Name', 'LOD det', 'Renderer', 'painters', 'Position', [0 0 900 300]);
plot(t, s-(sum(imfs(max(istars_ests_unique):end,:), 1) + res), 'LineWidth',0.5);
set(gca,'FontSize',20)
xlim([min(t)  max(t)]);
xtickformat('yyyy');
xticks(tickmin : calyears(5) : tickmax);
xlabel('Time (years)');
ylabel('LOD deviation (ms)');
print -depsc figs/lod_det

 