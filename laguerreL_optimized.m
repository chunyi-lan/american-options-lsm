function func = laguerreL_optimized(k,X)

if k == 0
    func = 1;
elseif k == 1
    func = 1-X;
elseif k == 2
    func = 1-2*X+0.5*(X.^2);
elseif k == 3
    func = 1-3*X+1.5*(X.^2)-(1/6)*(X.^3);
elseif k == 4
    func = 1-4*X+3*(X.^2)-(2/3)*(X.^3)+(1/24)*(X.^4);
elseif k == 5
    func = 1-5*X+5*(X.^2)-(5/3)*(X.^3)+(5/24)*(X.^4)-(1/120)*(X.^5);
else
    error('Use smaller k');
end
end