C_Lower = 0;
C_Upper = 5;
feedStruct.v0 = 2.3;
feedStruct.V = 150;
feedStruct.C_in = 3.4;
feedStruct.k = 0.5;
n = [0.1, 0.3, 0.5, 1, 3, 5];
Error_a = 0.1;
C_roots = length(n);
steadyC = length(n);

for i = 1:length(n)
    feedStruct.n = n(i);
    C_roots(i) = BisectRootFind(Error_a, C_Upper, C_Lower, @dCdT, feedStruct);
end

for i = 1:length(C_roots)
    feedStruct.n = n(i);
    steadyC(i) = dCdT(C_roots(i), feedStruct);
end
disp(steadyC)
subplot(2, 1, 1);
plot(n, C_roots);
xlabel("Order of reaction(n)");
ylabel("Steady State Concentration");


k = [0.1, 0.3, 0.5, 1, 3, 5];
feedStruct.n = 0.5;
for i = 1:length(k)
    feedStruct.k = k(i);
    C_roots(i) = BisectRootFind(Error_a, C_Upper, C_Lower, @dCdT, feedStruct);
end
for i = 1:length(C_roots)
    feedStruct.k = k(i);
    steadyC(i) = dCdT(C_roots(i), feedStruct);
end
subplot(2, 1, 2);
disp(steadyC)
plot(k, C_roots);
xlabel("k");
ylabel("Steady State Concentration");
%%

k = 10;
n = 0.1;
a = k*(C_roots(2)^n);
b = (v0/V)*(C_in - C_roots(2));
disp("Coversion term " + a)
disp("Dilution term " + b)
%The limiting step is the dilution
%% 
feedStruct.v0 = 2.3;
feedStruct.V = 150;
feedStruct.C_in = 3.4;
feedStruct.k = 0.5;
feedStruct.n = 0.5;
C = linspace(-5, 5, 1000);
dcdt = zeros(length(C));
for i=1:length(C)
    dcdt(i) = dCdT(C(i), feedStruct);
end
plot(C, dcdt);