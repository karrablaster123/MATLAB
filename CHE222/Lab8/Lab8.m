V = 10000;
F = 100;
theta = 0.1;
eta = 0.4;
mu = 0.902;
k = 0.1;
Sf = 500;
If = 50;
w = ["x0"; "s0"; "i0"];
raph = newtonRaphson(getHandle(F, V, theta, eta, mu, k, Sf, If), w);

roots = getRoot(raph, [1; 1; 1]);
disp(roots);

%%
clearvars;
V = 10000;
F = 100;
theta = [0.1; 0.2; 0.4; 0.5; 0.6];
eta = 0.4;
mu = 0.902;
k = 0.1;
Sf = 500;
If = 50;
w = ["x0"; "s0"; "i0"];
for i = 1:length(theta)
    raph = newtonRaphson(getHandle(F, V, theta(i), eta, mu, k, Sf, If), w);

    roots(:, i) = getRoot(raph, [1; 1; 1]);
end
subplot(2, 1, 1);
plot(theta, roots);
xlabel("theta");
ylabel("Steady State Conc");
legend(w)

clearvars;
V = 10000;
F = 100;
theta = 0.1;
eta = [0.1; 0.2; 0.4; 0.5; 0.6];
mu = 0.902;
k = 0.1;
Sf = 500;
If = 50;
w = ["x0"; "s0"; "i0"];
for i = 1:length(eta)
    raph = newtonRaphson(getHandle(F, V, theta, eta(i), mu, k, Sf, If), w);

    roots(:, i) = getRoot(raph, [1; 1; 1]);
end
subplot(2, 1, 2);
plot(eta, roots);
xlabel("eta");
ylabel("Steady State Conc");
legend(w)

%%
%When theta is approximately 0.4, the xout is approximately 101 which is
%very close to the requirement of 100. So a theta>0.4 is a good goal.
%Changing eta has a lower effect on xout so changing theta is better. 
%%
function fun = getHandle(F, V, theta, eta, mu, k, Sf, If)
    a = ((1-theta)*theta*(1+eta) - 1 - theta)/(1-theta*(1 + eta));
    b = k*((1-theta)/(1-theta*(1+eta)))^(1/6);

    f1 = @(x0, s0) (1/V)*(x0*a + mu*(V/F)*((1-theta)*s0)^(1.43));
    f2 = @(s0, i0) (1/V)*(Sf*(1-theta) - (1-theta)*s0 - mu*(V/F)*((1-theta) ...
        *s0)^(1.43) + b*(i0^(1/6))*(V/F));
    f3 = @(i0) (1/V)*((1-theta)*If + i0*a - b*(i0^(1/6))*(V/F));

    fun = {f1; f2; f3};
    
end