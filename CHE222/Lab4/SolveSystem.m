function y = SolveSystem(K, tau, u0, y0, t)
    k1 = y0 - K*u0;
    y = k1*exp(-t/tau) + K*u0;
end
