U=qr(rand(30));
V=qr(rand(30));
S=diag(2.^(-1:-1:-30));
A=U*S*V;
[Q_1,R_1]=qrHouse(A);
[Q_2,R_2]=gs(A);

norm(Q_1*R_1-A)
norm(Q_2*R_2-A)

norm(Q_1.'*Q_1-eye(size(A)))
norm(Q_2.'*Q_2-eye(size(A)))

function [Q,R] = qrHouse(A)
[m,n] = size(A);

if n>m
disp('Zerlegung kann nicht durchgeführt werden(da n>m)')
return
end
Q = eye(size(A));
V = zeros(size(A));

for k = 1:n
%v konstruieren
v = A(k:m,k);
tmp = sign(v(1))*norm(v);
v(1) = v(1) + tmp;
v = v/norm(v);
%Spiegelung
A(k:end,k:end) = A(k:end,k:end) - 2*v*(v.'*A(k:end,k:end));
V(k:end,k) = v;
end
%Q berechnen.
for k = n:-1:1
v = V(k:end,k);
Q(k:end,:) = Q(k:end,:) - 2*v*(v.'*Q(k:end,:));
end
R = triu(A);
end



function [Q,R] = gs(A)
% Berechnet die QR-Zerlegung von A mittels des klassischen Gram-Schmidt-Verfahrens.

Q = zeros(size(A));
R = zeros(min(size(A)));

for j = 1:size(A,2)
    v = A(:,j);
    
    %for i = 1:j-1
    %    R(i,j) = Q(:,i)'*A(:,j);
    %    v = v - R(i,j)*Q(:,i);
    %end
    R(1:j-1,j) = Q(:,1:j-1)'*A(:,j);
    v = v - Q(:,1:j-1)*R(1:j-1,j);

    R(j,j) = norm(v);
    Q(:,j) = v/R(j,j);    
end
end