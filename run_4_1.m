y1 = best_approximation(10,2)
y2 = best_approximation(5,5) % m = n Das Ergebnis scheint nicht sehr sinvoll.
y2 = best_approximation(20, 4)

function y = best_approximation(m, n)
m = m-1;
A = zeros(m+1,n);

for i = 1:m+1
    for j = 1:n
        A(i,j) = ((i-1)*(2*pi/m))^(j-1);
    end
end


b = zeros(m+1,1);

for i = 1:m+1
    b(i) = sin(A(i,2));
end


[Q,R] = qrgivens(A);

c = (Q')*b;

y = R(1:n,1:n) \ c(1:n);
end



function [Q,R] = qrgivens(A)
  [m,n] = size(A);
  Q = eye(m);
  R = A;

  for j = 1:n
    for i = m:-1:(j+1)
      G = eye(m);
      [c,s] = givensrotation( R(i-1,j),R(i,j) );
      G([i-1, i],[i-1, i]) = [c -s; s c];
      R = G'*R;
      Q = Q*G;
    end
  end

end

function [c,s] = givensrotation(a,b)
  if b == 0
    c = 1;
    s = 0;
  else
    if abs(b) > abs(a)
      r = a / b;
      s = 1 / sqrt(1 + r^2);
      c = s*r;
    else
      r = b / a;
      c = 1 / sqrt(1 + r^2);
      s = c*r;
    end
  end

end