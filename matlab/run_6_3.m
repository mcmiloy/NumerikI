plotspline(x, @f)

x = linspace(-1, 1, 5);

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


plot(xvals, yvals_spline, xvals, yvals_f)
legend("spline", "f")

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


