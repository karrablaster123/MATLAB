% t = linearly spaced values from 0 -> 500
t = linspace(0, 500);
% Var Assignment
tau = [3 6 10 20 100];
K = 1;
u0 = 2.25;
y0 = 1;
% 2D matrix/array with dimensions of len(tau)[5] x len(t)[100]
y = zeros(length(tau), length(t));

%cycling through tau  
for i = 1:length(tau)
    %cycling through t for each tau
    for j = 1:length(t)
        %solve for each t at current tau
        y(i, j) = SolveSystem(K, tau(i), u0, y0, t(j));
    end
end

%subplot 1
subplot(2, 1, 1);
plot(t, y)
%Create array of legend by "scalar multiplying" Tau = with string(Tau)
legendStrings = "Tau = " + string(tau);
legend(legendStrings);
xlabel("Time");
ylabel("Y");

%This solution only needs 5 values so we resize the matrix
y = zeros(size(tau));
for i = 1:length(tau)
    y(i) = (SolveSystem(K, tau(i), u0, y0, tau(i))/SolveSystem(K, tau(i), u0, y0, inf));
end

%output the matrix
disp(y)

%Now we plot y(t) with changing gain, so we first fix the variables
tau = 5;
K = [1 2 3 5 8];
u0 = 2.5;

%Same as changing tau but k this time
for i = 1:length(K)
    for j = 1:length(t)
        y(i, j) = SolveSystem(K(i), tau, u0, y0, t(j));
    end
end
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
%Since there isn't any changing tau or K, a 1D matrix/array is sufficient
y = zeros(size(t));

%Solve the system for the t
for i = 1:length(t)
    y(i) = SolveSystemJ(a, s, Tj, y0, t(i));
end
%Plot!
plot(t, y);
xlabel("Time (s)");
ylabel("Temperature (C)");
