
func = {@(x1, x2) (-4*x1 + 2*(x1^2) + 6*x2 +4*(x2^2) - 2*x1*x2)};
func2 = @(x) (-4*x(1) + 2*(x(1)^2) + 6*x(2) +4*(x(2)^2) - 2*x(1)*x(2));
w = ["x1"; "x2"];
grad = gradientMethod(func, w);
disp(descent(grad, [0; 0], 0.01));
disp(ascent(grad, [1; 1], 0.01));              
fsurf(func);


%%
%Can mostly ignore above code
clear vars;


w = "x";
C = [2 4 6 8 10];

for i = 1:length(C)
    func2 = @(x) (100*((1/((1-x)^2)^0.6 + C(i)*(1/x)^0.6)));
    hold on;
    fplot(func2, [0.1 0.9]);
end
xlabel("Conversion");
ylabel("Cost");
legend("C = " + string(C));

for i = 1:length(C)
    func = {@(x) (100*((1/((1-x)^2))^0.6 + C(i)*(1/x)^0.6))};
    func2 = @(x) (100*((1/((1-x)^2)^0.6 + C(i)*(1/x)^0.6)));
    grad = gradientMethod(func, w);
    root(i) = descent(grad, 0.3, 1e-5);
    roots(i) = fminsearch(func2, 0.3);
end
disp(root)
disp(roots)

func2 = @(x) (100*((1/((1-x)^2)^0.6 + C(3)*(1/x)^0.6)));
disp(fmincon(func2, 0.3, [], [], [], [], 0, 1));