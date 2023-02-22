function val = dCdT(v0, V, C_in, C, k, n)
    val = (v0/V)*(C_in - C) - k*(C^n);
end