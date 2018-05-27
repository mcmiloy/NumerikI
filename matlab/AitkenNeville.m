AitkenNeville([1 2 3], [1 4 9], 3)


function v = AitkenNeville(x, y, u)
    n = size(x)
    i_current = 0;
    p = zeros(n, n);
    p(:,1) = y;
    p
    v=0;
end



% ((u-x(i))*p(i+1,j-1) - (u - x(i+j))*p(i,j-1))/
%     x(i+j) - x(i)