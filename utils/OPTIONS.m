% Options file with the parameters that are used across the entire project.
%
% OUTPUTS:
% options: a struct with all the constants


function options = OPTIONS()
    mars_ar = [6, 12];
    linew_ar = [1, 2];
    fonts_ar = [10, 20];
    pl_i = 2;

    options = struct();
    
    options.eps = 10^-12;
    options.ts = 1:2000;
    options.stds = [0.05 0.1 0.2 0.3 0.4];
    options.ps = [0.01, 0.03, 0.05, 0.09, 0.11, 0.15, 0.16, 0.18, 0.22, 0.24, 0.26, 0.28, 0.30, 0.32, 0.35, 0.40];
    options.binsize = 0.1;
    options.p_r = 0.05;
    options.p_er = 0.16;
    options.threshL = 1.878333357925438;
    options.threshR =  2.248765963681253;
    options.threshL_rat = 1.773421272829556;
    options.threshR_rat =  3.337372699713324;
    options.pl_i = pl_i; % Choose between 1 and 2 to pick size
    options.logplot = true;
    options.mars = mars_ar(pl_i);
    options.linew = linew_ar(pl_i);
    options.fonts = fonts_ar(pl_i);
    options.colors = {'red', 'green', 'magenta', 'cyan'};
end