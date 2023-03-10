% @(r1, r2) K1*(cb0 - r1)*(ca0 - 2*r1 - r2)^2 - (cc0 + r1 + r2)
% @(r1, r2) K2*(ca0 - 2*r1 - r2)*(cd0 - r2) - (cc0 + r1 + r2)
%%
K1 = 4e-4;
K2 = 3.7e-2;
ca0 = 40;
cb0 = 10;
cc0 = 2;
cd0 = 15;
w = ["r1"; "r2"];
raph = newtonRaphson({createHandle1(K1, ca0, cb0, cc0);createHandle2(K2, ca0, cc0, cd0)}, w);
roots = getRoot(raph, [0; 0], 1e-4);
ca = ca0 - 2*roots(1) - roots(2);
cb = cb0 - roots(1);
cc = cc0 + roots(1) + roots(2);
cd = cd0 - roots(2);
disp(ca)
disp(cb)
disp(cc)
disp(cd)

%%
clearvars;
K1 = 4e-4;
K2 = 3.7e-2;
ca0 = 40;
cb0 = 10;
cc0 = 0:1:20;
cd0 = 15;
w = ["r1"; "r2"];
for i = 1:length(cc0)
    raph = newtonRaphson({createHandle1(K1, ca0, cb0, cc0(i));createHandle2(K2, ca0, cc0(i), cd0)}, w);
    roots = getRoot(raph, [0; 0], 1e-4);
    ca(i) = ca0 - 2*roots(1) - roots(2);
    cb(i) = cb0 - roots(1);
    cc(i) = cc0(i) + roots(1) + roots(2);
    cd(i) = cd0 - roots(2);
end
plot(cc0, ca)
hold on;
plot(cc0, cb)
plot(cc0, cc)
plot(cc0, cd)
legend("C" + ["a", "b", "c", "d"]);

%%
clearvars;
K1 = [0.0001 0.01 1 100 1000];
K2 = 3.7e-2;
ca0 = 40;
cb0 = 10;
cc0 = 2;
cd0 = 15;
w = ["r1"; "r2"];
for i = 1:length(K1)
    raph = newtonRaphson({createHandle1(K1(i), ca0, cb0, cc0);createHandle2(K2, ca0, cb0, cc0)}, w);
    roots = getRoot(raph, [0; 0], 1e-4);
    ca(i) = ca0 - 2*roots(1) - roots(2);
    cb(i) = cb0 - roots(1);
    cc(i) = cc0 + roots(1) + roots(2);
    cd(i) = cd0 - roots(2);
end
figure;
semilogx(K1, ca)
hold on;
semilogx(K1, cb)
semilogx(K1, cc)
semilogx(K1, cd)
legend("C" + ["a", "b", "c", "d"]);

function f1 = createHandle1(K1, ca0, cb0, cc0)
    f1 = @(r1, r2) K1*(cb0 - r1)*(ca0 - 2*r1 - r2)^2 - (cc0 + r1 + r2);
end

function f2 = createHandle2(K2, ca0, cc0, cd0)
    f2 = @(r1, r2) K2*(ca0 - 2*r1 - r2)*(cd0 - r2) - (cc0 + r1 + r2);
end
