%Question 2 (DONT RUN BY SECTIONS IT WONT WORK. RUN WHOLE FILE!)
F = 100;
V = 10000;
theta = 0.2;
eta = 0.4;
k1 = 2;
k2 = 0.1;
n = 2;
Af = 500;
If = 100;
p = [F; V; theta; eta; k1; k2; n; Af; If];
roots = functionsolver([1; 1; 1; 1], p);
symarray = ["A"; "I"; "P"; "iA"];
disp(symarray + " = " + string(roots))

%%
% Part 2, n = 2, theta = [0, 0.1, 0.2, 0.3, 0.5]
clear roots;
theta = [0, 0.1, 0.2, 0.3, 0.5];
n = 2;
for i = 1:length(theta)
    p = [F; V; theta(i); eta; k1; k2; n; Af; If];
    roots(i, :) = functionsolver([1; 1; 1; 1], p); %#ok<*SAGROW> 
end
subplot(2, 1, 1);
semilogy(theta, roots);
legend(symarray);
xlabel("Theta");
ylabel("Steady State Concentration (mol/L)");

%%
% Part 3, theta = 0.2, n = [1, 2, 4, 5, 10]
clear roots;
theta = 0.2;
n = [1, 2, 4, 5, 10];
for i = 1:length(n)
    p = [F; V; theta; eta; k1; k2; n(i); Af; If];
    roots(i, :) = functionsolver([1; 1; 1; 1], p);
end
subplot(2, 1, 2);
semilogy(n, roots);
legend(symarray);
xlabel("Order of Reaction");
ylabel("Steady State Concentration (mol/L)");