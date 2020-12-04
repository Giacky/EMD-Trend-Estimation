% Script that outputs all the findings from the 5 simulated examples

clear;
close all;
function1;
ratio_approach(Zs);
print -depsc figs/fun1_rat5;
ratio_approach(Zs, [OPTIONS().threshL, OPTIONS().threshR]);
print -depsc figs/fun1_rat16;
energy_approach(imfs);
print -depsc figs/fun1_ene;
lineartrends_approach(imfs, res);
print -depsc figs/fun1_lin;
close all;

istar = formatistar(calc_istar([imfs; res], trend));
istar_rat5 = formatistar(ratio_approach(Zs));
istar_rat16 = formatistar(ratio_approach(Zs, [OPTIONS().threshL, OPTIONS().threshR]));
istar_ene = formatistar(energy_approach(imfs));
istar_enerat = formatistar(energyratio_approach(imfs, Zs));
istar_lin = formatistar(lineartrends_approach(imfs, res));

istars_ests = [ifnoistar(istar_rat5), ifnoistar(istar_ene), ifnoistar(istar_enerat), ifnoistar(istar_lin)];
plot_esttrends(trend, imfs, res, istars_ests);
print -depsc figs/fun1_esttrends;

disp([istar, istar_rat5, istar_rat16, istar_ene, istar_enerat, istar_lin]);
clear;


function2;
ratio_approach(Zs);
print -depsc figs/fun2_rat5;
ratio_approach(Zs, [OPTIONS().threshL, OPTIONS().threshR]);
print -depsc figs/fun2_rat16;
energy_approach(imfs);
print -depsc figs/fun2_ene;
lineartrends_approach(imfs, res);
print -depsc figs/fun2_lin;
close all;

istar = formatistar(calc_istar([imfs; res], trend));
istar_rat5 = formatistar(ratio_approach(Zs));
istar_rat16 = formatistar(ratio_approach(Zs, [OPTIONS().threshL, OPTIONS().threshR]));
istar_ene = formatistar(energy_approach(imfs));
istar_enerat = formatistar(energyratio_approach(imfs, Zs));
istar_lin = formatistar(lineartrends_approach(imfs, res));

istars_ests = [ifnoistar(istar_rat5), ifnoistar(istar_ene), ifnoistar(istar_enerat), ifnoistar(istar_lin)];
plot_esttrends(trend, imfs, res, istars_ests);
print -depsc figs/fun2_esttrends;

disp([ifnoistar(istar), ifnoistar(istar_rat5), ifnoistar(istar_rat16), ifnoistar(istar_ene), ifnoistar(istar_enerat), ifnoistar(istar_lin)]);
clear;


function3;
ratio_approach(Zs);
print -depsc figs/fun3_rat5;
ratio_approach(Zs, [OPTIONS().threshL, OPTIONS().threshR]);
print -depsc figs/fun3_rat16;
energy_approach(imfs);
print -depsc figs/fun3_ene;
lineartrends_approach(imfs, res);
print -depsc figs/fun3_lin;
close all;

istar = formatistar(calc_istar([imfs; res], trend));
istar_rat5 = formatistar(ratio_approach(Zs));
istar_rat16 = formatistar(ratio_approach(Zs, [OPTIONS().threshL, OPTIONS().threshR]));
istar_ene = formatistar(energy_approach(imfs));
istar_enerat = formatistar(energyratio_approach(imfs, Zs));
istar_lin = formatistar(lineartrends_approach(imfs, res));

istars_ests = [ifnoistar(istar_rat5), ifnoistar(istar_ene), ifnoistar(istar_enerat), ifnoistar(istar_lin)];
plot_esttrends(trend, imfs, res, istars_ests);
print -depsc figs/fun3_esttrends;

disp([ifnoistar(istar), ifnoistar(istar_rat5), ifnoistar(istar_rat16), ifnoistar(istar_ene), ifnoistar(istar_enerat), ifnoistar(istar_lin)]);
clear;


function4;
ratio_approach(Zs);
print -depsc figs/fun4_rat5;
ratio_approach(Zs, [OPTIONS().threshL, OPTIONS().threshR]);
print -depsc figs/fun4_rat16;
energy_approach(imfs);
print -depsc figs/fun4_ene;
lineartrends_approach(imfs, res);
print -depsc figs/fun4_lin;
close all;

istar = formatistar(calc_istar([imfs; res], trend));
istar_rat5 = formatistar(ratio_approach(Zs));
istar_rat16 = formatistar(ratio_approach(Zs, [OPTIONS().threshL, OPTIONS().threshR]));
istar_ene = formatistar(energy_approach(imfs));
istar_enerat = formatistar(energyratio_approach(imfs, Zs));
istar_lin = formatistar(lineartrends_approach(imfs, res));

istars_ests = [ifnoistar(istar_rat5), ifnoistar(istar_ene), ifnoistar(istar_enerat), ifnoistar(istar_lin)];
plot_esttrends(trend, imfs, res, istars_ests);
print -depsc figs/fun4_esttrends;

disp([ifnoistar(istar), ifnoistar(istar_rat5), ifnoistar(istar_rat16), ifnoistar(istar_ene), ifnoistar(istar_enerat), ifnoistar(istar_lin)]);
clear;


function5;
ratio_approach(Zs);
print -depsc figs/fun5_rat5;
ratio_approach(Zs, [OPTIONS().threshL, OPTIONS().threshR]);
print -depsc figs/fun5_rat16;
energy_approach(imfs);
print -depsc figs/fun5_ene;
lineartrends_approach(imfs, res);
print -depsc figs/fun5_lin;
close all;

istar = formatistar(calc_istar([imfs; res], trend));
istar_rat5 = formatistar(ratio_approach(Zs));
istar_rat16 = formatistar(ratio_approach(Zs, [OPTIONS().threshL, OPTIONS().threshR]));
istar_ene = formatistar(energy_approach(imfs));
istar_enerat = formatistar(energyratio_approach(imfs, Zs));
istar_lin = formatistar(lineartrends_approach(imfs, res));

istars_ests = [ifnoistar(istar_rat5), ifnoistar(istar_ene), ifnoistar(istar_enerat), ifnoistar(istar_lin)];
plot_esttrends(trend, imfs, res, istars_ests);
print -depsc figs/fun5_esttrends;

disp([ifnoistar(istar), ifnoistar(istar_rat5), ifnoistar(istar_rat16), ifnoistar(istar_ene), ifnoistar(istar_enerat), ifnoistar(istar_lin)]);
clear;
