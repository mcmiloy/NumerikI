fn = @(x, y) [(1/3)*y^2 + (1/8), (1/4)*x^2 - (1/6)];
tol = 10^-8;

x0 = [0, 0];
x1 = fn(x0(1), x0(2));

x_k = x0;
x_kp1 = x1;
theta_current = 1;

while tol <= (theta_current/(1-theta_current))* norm(x_kp1 - x_k)
    x_kp2 = fn(x_kp1(1), x_kp1(2));
    theta_current = norm(x_kp2 - x_kp1, 'inf') - norm(x_kp1 - x_k, 'inf');
    
    if (theta_current) >= 1
        disp('kein erfolg moeglich');
        break;
    end
    
    x_k = x_kp1;
    x_kp1 = x_kp2;
end   

disp(x_kp2)