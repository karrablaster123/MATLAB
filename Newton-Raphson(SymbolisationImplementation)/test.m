%{
F1 = @(x1, x2)(exp(x1^2) + x2^2);
F2 = @(x2, x3)(2*x2 + x3^3);
F = {F1; F2};
f = sym(F)
X = ["x1", "x2", "x3"];
X = sym(X);
val = [0, 1, 1];
Feval = subs(f, X, val)
diff(f,X(1));
diff(f,X(2));
f1 = diff(f,X(3));
subs(f1, X, val)
%}
F = {@(x1, x2)(2*x1 - x2 -exp(-x1));@(x1, x2)(-x1 + 2*x2 - exp(-x2))};
X = ["x1", "x2"];
raph = newtonRaphson(F, X);
roots = double(getRoot(raph, [0; 0], 1e-4))
