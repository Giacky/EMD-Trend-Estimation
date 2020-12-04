% Finding the optimal p for the ratio and energy-ratio approach
% Step 4

ps = OPTIONS().ps;

load outputs/ed_r.mat;
load outputs/ed_e.mat;
load outputs/ed_er.mat;

% Find the range of the optimal p for the ratio approach
[~, p_i] = min(ed_r, [], 3);
m = ps(p_i);
disp('Ratio approach optimal p:');
disp(mean(m, 'all'));
% histogram(m(:), 3);


% Find the range of the optimal p for the energy-ratio approach
[prange, pstars] = findpstar(ed_e, ed_er);
disp('Energy ratio');
disp('p1 and p2:');
disp(pstars);
disp('Range of the optimal p');
disp(prange);
plot_eds(ed_r, ed_e, ed_er, 3, 2);
print -depsc figs/ed


% Plotting function for the series of EDs found from the ratio, energy and
% energy-ratio approach
% 
% INPUT
% ed_r: ratio euclidean distances for a given p cell array
% ed_e: energy uclidean distances cell array
% ed_er: energy-ratio euclidean distances for a given p cell array
% trendi: index of the trend used
% stdi: index of the standard deviation used

function plot_eds(ed_r, ed_e, ed_er, trendi, stdi)
    ps = OPTIONS().ps;
    if ndims(ed_r) == 3
        ed_r_inst = reshape(ed_r(trendi,stdi,:), 1, []);
        ed_e_inst = reshape(ed_e(trendi,stdi,:), 1, []);
        ed_er_inst = reshape(ed_er(trendi,stdi,:), 1, []);
    else
        ed_r_inst = ed_r(:,trendi);
        ed_e_inst = ed_e(:,trendi);
        ed_er_inst = ed_er(:,trendi);
    end
    figure;
    plot(ps.*100, ed_r_inst, 'red', 'linewidth', 2);
    hold on;
    yline(ed_e_inst, 'green', 'linewidth', 2)
    hold on;
    plot(ps.*100, ed_er_inst, 'blue', 'linewidth', 2);
    hold off;
    legend('Ratio', 'Energy', 'Energy-Ratio', 'Location','northwest');
    xlabel('$p \left( \% \right)$', 'interpreter', 'latex');
    ylabel('Euclidean Distance')
    set(gca,'FontSize',15);
end
