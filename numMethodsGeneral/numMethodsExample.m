func = @(x, y) y+x*0;
func2 = @(x) exp(x);
range = [-2 4];
hold on;
numOde = numericalOdeSolve(func, 0, 1, range, 0.1, true);
numOde = eulersMethod(numOde);
numOde.plots
numOde = RK4(numOde);
fplot(func2, range);
%legend(["Euler", "RK4", "Actual Function"]);

numOde.plots
hold off;
keyboard

func = @(x,y) 5*y + exp(-2*x)*(y^(-2));
%Important note: Certain functions(such as the one above) do not behave 
%well with extremely low step sizes. Remember to modify the step size 
%if a function doesn't seem to be modelled correctly
numOde2 = numericalOdeSolve(func, 0, 2, [-2 0.3], 0.01, true);
numOde2 = eulersMethod(numOde2);
xy = [numOde2.x_points; numOde2.y_points];
hold on;
numOde2 = RK4(numOde2);
xy1 = [numOde2.x_points; numOde2.y_points];
legend(["Euler", "RK4"]);



