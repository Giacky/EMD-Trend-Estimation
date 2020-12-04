% Find the left and right thresholds
% Step 5

load outputs/rzcns.mat

% Thresholds for the ratio approach
p_r = OPTIONS().p_r;
[threshL5, threshR5] = find_thresholds(rzcns, p_r);

% Thresholds for the energy-ratio approach
p_er = OPTIONS().p_er;
[threshL16, threshR16] = find_thresholds(rzcns, p_er);