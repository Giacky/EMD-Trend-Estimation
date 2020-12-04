function plot_emd_components(ts, comps, res)
    if nargin == 3
        comps = [comps; res];
    end
    numPlots = length(comps);
    pixelHeightPerPlot = 200;
    f = uifigure('Name', 'EMD Components');
    f.Scrollable = true;
    p = uipanel(f, 'Position',[0 0 900 numPlots*pixelHeightPerPlot]);
    p.BorderType = 'none';
    t = tiledlayout(p, numPlots, 1);
    t.Padding = 'none';
    
    for i = 1:numPlots
        ax = nexttile(t);
        plot(ax, ts, comps(i,:));
        title(ax, ['IMF ' num2str(i)]);
    end
end