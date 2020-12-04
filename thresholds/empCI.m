% Find the left and right thresholds for the ratio approach for a given
% set of realisations
%
% INPUTS:
% rzcns: array containing all the R_i in the full set of realisazions
% binsize: bin size for the empirical distribution
% p: p value to be used for finding the thresholds
%
% OUTPUTS:
% threshL: Left threshold
% threshR: Right threshold


function [threshL, threshR] = empCI(rzcns, binsize, p)
    maxRZCN = ceil(max(rzcns));
    edgesmid = 0 : binsize : maxRZCN;
    edges = -binsize/2 : binsize : maxRZCN+(binsize/2);
    N = histcounts(rzcns, edges);
    full_area = trapz(edgesmid, N);
    cum_area = cumtrapz(edgesmid, N);
    
    area_tailL = p.*full_area;
    iLT = find(cum_area > area_tailL, 1);
    iLB = iLT-1;
    edgeLT = edgesmid(iLT);
    edgeLB = edgesmid(iLB);
    NLT = N(iLT);
    NLB = N(iLB);
    area_resL =  cum_area(iLT) - area_tailL;  % last part of the area on the left side of the mean that doesn't take an entire bin
    threshL = find_a(edgeLB, edgeLT, NLB, NLT, area_resL);

    
    area_tailR = (1-p).*full_area;
    iRT = find(cum_area > area_tailR, 1);
    iRB = iRT-1;
    edgeRT = edgesmid(iRT);
    edgeRB = edgesmid(iRB);
    NRT = N(iRT);
    NRB = N(iRB);
    
    area_resR = area_tailR - cum_area(iRB);  % last part of the area on the left side of the mean that doesn't take an entire bin
    threshR = find_b(edgeRB, edgeRT, NRB, NRT, area_resR);
end

function a_out = find_a(edgeLB, edgeLT, NLB, NLT, resarea)
    syms a;
    f = @(x1,x2,y1,y2,I) double(solve(I == (((-2*(x1*x2-a*x1)+x2^2-a^2)*(y2-y1)) / (2*(x2-x1))) + y1*x2 - y1*a, a));
    f_sol = f(edgeLB, edgeLT, NLB, NLT, resarea);
    a_out = f_sol(f_sol >= edgeLB-OPTIONS().eps & f_sol <= edgeLT+OPTIONS().eps); %two solutions, always get the one where it is between x1 and x2
    a_out = a_out(1); 
end


function b_out = find_b(edgeRB, edgeRT, NRB, NRT, resarea)
    syms b;
    f = @(x1,x2,y1,y2,I) double(solve(I == (((x1^2-2*b*x1+b^2)*(y2-y1)) / (2*(x2-x1)) + y1*b - y1*x1), b));
    f_sol = f(edgeRB, edgeRT, NRB, NRT, resarea);
    
    b_out = f_sol(f_sol >= edgeRB-OPTIONS().eps & f_sol <= edgeRT+OPTIONS().eps); %two solutions, always get the one where it is between x1 and x2
    b_out = b_out(1); 
end