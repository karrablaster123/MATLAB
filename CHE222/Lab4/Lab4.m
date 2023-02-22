%Question 1
V = 500;
F = 1;
s0 = 4.4;
A = 0.75;
tau = V/F;
K = 1;
u0 = s0;
y0 = 0;
[s_inf, time] = GetSystemChar(K, tau, u0, y0, A);
disp([s_inf, time])
%% Question 2
%Tau is V/(F - qC), K is F/(F-qC)
q = [0.001 0.002 0.01 0.05 0.1];
C = 1.33;
for i = 1:length(q)
    qC = q(i)*C;
    tau = V/(F - qC);
    K = F/(F - qC);
    [s_inf, time] = GetSystemChar(K, tau, u0, y0, A);
    disp([s_inf, time])
end
%% 

q = [0.001 0.002 0.01 0.05 0.1];
C = 1.33;
subplot(2, 1, 1);
t_array = linspace(1, 1000);
s = zeros(length(q), length(t_array));
s_ratio = zeros(length(q), length(t_array));
for i = 1: length(q)
    qC = q(i)*C;
    tau = V/(F - qC);
    K = F/(F - qC);
    [s_ss, ~] = GetSystemChar(K, tau, u0, y0, A); 
    
    for j = 1:length(t_array)
        s(i, j) = SolveSystem(K, tau, u0, y0, t_array(j));
        
    end
end
s_ratio = s./s_ss;
plot(t_array, s);
legendStrings = 'q = ' + string(q);
legend(legendStrings);
xlabel('Time (min)');
ylabel('S (mol-glucose/L)');
subplot(2, 1, 2);
plot(t_array, s_ratio);
legend(legendStrings);
xlabel('Time (min)');
ylabel('S over S(SS)');

%Increase q to decrease time to reach steady state
% q should be approx 0.05