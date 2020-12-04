% Script for plotting the 6 trends used for finding the thresholds

load thresholds/trendfuns.mat;

figure('Name', 'Trend 1', 'Renderer', 'painters', 'Position', [0 0 900 300]);
plot(trendfuns(1,:), 'red','LineWidth',2);
xlim([0 2000]);
set(gca,'FontSize',OPTIONS().fonts)
print -depsc figs/th1

figure('Name', 'Trend 2', 'Renderer', 'painters', 'Position', [0 0 900 300]);
plot(trendfuns(2,:), 'red','LineWidth',2);
xlim([0 2000]);
set(gca,'FontSize',OPTIONS().fonts)
print -depsc figs/th2

figure('Name', 'Trend 3', 'Renderer', 'painters', 'Position', [0 0 900 300]);
plot(trendfuns(3,:), 'red','LineWidth',2);
xlim([0 2000]);
set(gca,'FontSize',OPTIONS().fonts)
print -depsc figs/th3

figure('Name', 'Trend 4', 'Renderer', 'painters', 'Position', [0 0 900 300]);
plot(trendfuns(4,:), 'red','LineWidth',2);
xlim([0 2000]);
set(gca,'FontSize',OPTIONS().fonts)
print -depsc figs/th4

figure('Name', 'Trend 5', 'Renderer', 'painters', 'Position', [0 0 900 300]);
plot(trendfuns(5,:), 'red','LineWidth',2);
xlim([0 2000]);
set(gca,'FontSize',OPTIONS().fonts)
print -depsc figs/th5

figure('Name', 'Trend 6', 'Renderer', 'painters', 'Position', [0 0 900 300]);
plot(trendfuns(6,:), 'red','LineWidth',2);
xlim([0 2000]);
set(gca,'FontSize',OPTIONS().fonts)
print -depsc figs/th6