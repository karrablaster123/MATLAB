% t = linearly spaced values from 0 -> 500
t = linspace(0, 500);
% Var Assignment
tau = [3; 6; 10; 20; 100];
K = 1;
u0 = 2.25;
y0 = 1;
% 2D matrix/array with dimensions of len(tau)[5] x len(t)[100]
y = SolveSystem(K, tau, u0, y0, t);
%subplot 1
subplot(2, 1, 1);
plot(t, y)
%Create array of legend by "scalar multiplying" Tau = with string(Tau)
legendStrings = "Tau = " + string(tau);
legend(legendStrings);
xlabel("Time");
ylabel("Y");


y = (SolveSystem(K, tau, u0, y0, tau)./SolveSystem(K, tau, u0, y0, inf));

%output the matrix
disp(y)

%Now we plot y(t) with changing gain, so we first fix the variables
tau = 5;
K = [1; 2; 3; 5; 8];
u0 = 2.5;

%Same as changing tau but k this time
y = SolveSystem(K, tau, u0, y0, t);
%Select subplot 2
subplot(2, 1, 2);
plot(t, y);
%Same as tau but with K
legendStrings = "K = " + string(K);
legend(legendStrings);
xlabel("Time");
ylabel("Y");

%% Jacketed Batch

%Var set
Tj = 80;
U = 0.25;
A = 0.5;
V = 15;
rho = 1;
Cp = 4.5;
%a and s defined for easier processing
a = rho*V*Cp;
s = - U * A;


t = linspace(0, 10000);
y0 = 5;

y = SolveSystemJ(a, s, Tj, y0, t);

%Plot!
plot(t, y);
xlabel("Time (s)");
ylabel("Temperature (C)");
