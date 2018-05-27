n = zeros(10);
errs = zeros(10);
line = zeros(10);

for k = 1:10
    n(k) = 2^k;
    x = linspace(-1, 1, n(k));
    line(k) = 1/(n(k)^2);
    errs(k) = plotspline(x, @f);
end

semilogx(n, line, n, errs)
legend("1/n^2", "Fehler")


function [err] = plotspline(x, f)
[~, x_size] = size(x);
xvals = [];
yvals_spline = [];
yvals_f = [];
interval_errors = [];

for i = 1:(x_size-1)
    Y = (linspace(x(i), x(i+1), 20)');
    xvals = [xvals; Y(1:19)];
    yvals_spline_temp = knoten_right(x(i), x(i+1), Y(1:19)).*f(Y(1:19)) + knoten_left(x(i), x(i+1), Y(1:19)).*f(Y(2:20));
    yvals_spline = [yvals_spline; yvals_spline_temp];
    yvals_f_temp = f(Y(1:19));
    yvals_f = [yvals_f; yvals_f_temp];
    
    interval_errors(i) = max(abs(yvals_spline - yvals_f));
end

err = max(interval_errors);

end


function y = knoten_left(xi_p1, xi, A)    
    y = (A-xi)./(xi_p1-xi);
end
    
function y = knoten_right(xi_p1, xi, A)      
    y = 1 - (A-xi)./(xi_p1-xi);
end

function y = f(x)
    temp = (1+25*x.^2);
    y = 1./temp;
end