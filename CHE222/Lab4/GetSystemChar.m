function [y_inf, time] = GetSystemChar(K, tau, u0, y0, A)
    y_inf = SolveSystem(K, tau, u0, y0, inf);
    y_t = A*(y_inf - y0) + y0;
    time = tau*log((y0 - K*u0)/(y_t - K*u0));
end