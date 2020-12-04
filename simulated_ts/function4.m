a = 0.7;
b = 0.1;
c = 10;
n = 30;
p = 15;
r = 2.5;
f = 2*pi*p/c;

syms t;

ts = 1:0.25:2000;

noise1_fun = f4(a, b, c, n, p, r);
noise2_fun = @(t) 5 .* sin(b.*t);

noise1 = double(subs(noise1_fun, t, ts));
noise2 = noise2_fun(ts);
noise = noise1 + noise2;


trend_fun = @(t) 50 .* sin((t .* pi)./2000);
trend = trend_fun(ts);

% s = trend + noise;
% save simulated_ts/simfuns/fun4.mat s;
load simulated_ts/simfuns/fun4.mat;

figure('Name', 'Function 4', 'Renderer', 'painters', 'Position', [0 0 900 300]);
plot(s, 'LineWidth',1);
hold on;
plot(trend, 'LineWidth',2);
legend({'Signal', 'Trend'}, 'Location','best');
set(gca,'FontSize',OPTIONS().fonts)
print -depsc figs/fun4

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


function pw = f4(a, b, c, n, p, r)
    f = 2*pi*p/c;
    
    syms t;
    pw = 0;
        
    while n>=0
        pw = piecewise(((2.*pi.*r)./b)*n - (pi./(2.*b)) + (c./2) <= t < ((2.*pi.*r)./b)*(n+1) - (pi./(2.*b)) - (c./2), 0, ((2.*pi.*r)./b)*(n+1) - (pi./(2.*b)) - (c./2) <= t < ((2.*pi.*r)./b)*(n+1) - (pi./(2.*b)) + (c./2), (a .* (sin(f.* (t - ( (((2.*pi.*r)./b).*(n+1)) - (pi./(2.*b)) + (c./2))) ))), pw);
        n = n - 1;
    end
end
