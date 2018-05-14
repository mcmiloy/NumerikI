U=qr(rand(30));
V=qr(rand(30));
S=diag(2.^(-1:-1:-30));
A=U*S*V;
b = rand(30,1);
x_0 = lAus(A,b);
tst = norm(b-A*x_0);
disp(tst)

function x = lAus(A,b)
[~,n] = size(A);
[~,R] = qr([A b],0);
x = R(1:n,1:n)\R(1:n,n+1);
end