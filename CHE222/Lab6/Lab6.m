%{ 
    This solution is not considered optimal. See Bisect folder with test,
    dcdt, and BisectRootFinder for the best solution. 
%}

%%
C_Lower = 0;
C_Upper = 5;
v0 = 2.3;
V = 150; 
C_in = 3.4;
k = 0.5;
n = [0.1, 0.3, 0.5, 1, 3, 5];
Error_a = 0.1;
C_roots = length(n);
steadyC = length(n);
for i = 1:length(n)
    C_roots(i) = solvedCdT(v0, V, C_in, k, n(i), C_Lower, C_Upper, Error_a);
end
for i = 1:length(C_roots)
    steadyC(i) = dCdT(v0, V, C_in, C_roots(i), k, n(i));
end
disp(steadyC)
subplot(2, 1, 1);
plot(n, C_roots);
xlabel("Order of reaction(n)");
ylabel("Steady State Concentration");

k = [0.1, 0.3, 0.5, 1, 3, 5];
n = 0.5;
for i = 1:length(k)
    C_roots(i) = solvedCdT(v0, V, C_in, k(i), n, C_Lower, C_Upper, Error_a);
end
for i = 1:length(C_roots)
    steadyC(i) = dCdT(v0, V, C_in, C_roots(i), k(i), n);
end
subplot(2, 1, 2);
disp(steadyC)
plot(k, C_roots);
xlabel("k");
ylabel("Steady State Concentration");
k = 10;
n = 0.1;
a = k*(C_roots(2)^n);
b = (v0/V)*(C_in - C_roots(2));
disp("Coversion term " + a)
disp("Dilution term " + b)
%%The limiting step is the dilution