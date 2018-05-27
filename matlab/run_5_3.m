AitkenNeville([1 2 3 4], [1 8 27 64], 2.5)


figure
InterpolationAD(@myfunc, [-5,5], 5)
legend('Approximation', 'Echte Function')
figure
InterpolationAD(@myfunc, [-5,5], 25)
legend('Approximation', 'Echte Function')
figure
InterpolationAD(@myfunc, [-5,5], 125)
legend('Approximation', 'Echte Function')

figure
InterpolationAD(@myfunc2, [-5,5], 5)
legend('Approximation', 'Echte Function')
figure
InterpolationAD(@myfunc2, [-5,5], 25)
legend('Approximation', 'Echte Function')
figure
InterpolationAD(@myfunc2, [-5,5], 125)
legend('Approximation', 'Echte Function')

function y = myfunc(x)
    y = exp(-x);
end

function y = myfunc2(x)
    y = atan(x);
end

    

function v = AitkenNeville(x, y, u)
    [~, n] = size(x);
    p = zeros(n, n);
    p(:,1) = y;
    for j = 2:n
        for i = 1:n-j+1
            p(i, j) = ((u-x(i))*p(i+1,j-1) - (u - x(i+j-1))*p(i,j-1))/(x(i+j-1) - x(i));
                      
        end
    end
    v=p(1,n);
end


function [] = InterpolationAD(f,I,n)
    x = zeros(1, n);
    for i = 1:n
        x(i) = (i*(I(2) - I(1)) + I(1))/n;
    end
    y = zeros(1, n);
    for i = 1:n
        y(i) = f(x(i));
    end
    
    
    m = 300;
    x_plot = zeros(m,1);
    for i = 1:m
        x_plot(i) = (i*(I(2) - I(1)) + I(1))/m;
    end
        
    y_plot = zeros(m, 1);
    for i = 1:m
        y_plot(i) = AitkenNeville(x,y, x_plot(i));
    end
    
    y_plot_compare = zeros(m, 1);
    for i = 1:m
        y_plot_compare(i) = f(x_plot(i));
    end
    
    plot(x_plot, y_plot, x_plot, y_plot_compare)
end

% Fuer eine Grosse Anzahl von Stuetzstellen ist die Interpolation nicht
% gut.