function y = SolveSystemJ(a, s, Tj, y0, t)
    k1 = y0 - Tj;
    y = k1.*exp(s.*t./a) + Tj;
end