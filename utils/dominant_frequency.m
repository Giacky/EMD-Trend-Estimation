% Calculate the dominant frequency of the time series.
%
% INPUTS:
% t: time values of the time series
% s: signal of the time series
%
% OUTPUTS:
% dom_freq: dominant frequency

function dom_freq = dominant_frequency(t, s)
    L = length(t);
    Ts = mean(diff(t));
    Fs = 1/Ts;
    Fn = Fs/2;
    s0 = s - mean(s);
    FTnorm = fft(s0)/L;
    Fv = linspace(0, 1, fix(L/2)+1)*Fn;
    Iv = 1:length(Fv);
        
    [dom, dom_i] = max(abs(FTnorm(Iv))*2);
    
    if nargout == 0
        plot(Fv, abs(FTnorm(Iv))*2)
        hold on
        plot(Fv(dom_i), dom, 'o', 'MarkerEdgeColor','red',...
        'MarkerSize',8);
        hold off
    end
    dom_freq = Fv(dom_i);
end