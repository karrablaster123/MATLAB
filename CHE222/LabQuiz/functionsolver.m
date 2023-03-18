function roots = functionsolver(guess, p)
    arguments
        guess
        p (1, 9) = []
    end
    
    if isempty(p)
        F = 100;
        V = 10000;
        theta = 0.2;
        eta = 0.4;
        k1 = 2;
        k2 = 0.1;
        n = 2;
        Af = 500;
        If = 100;
    else
        F = p(1);
        V = p(2);
        theta = p(3);
        eta = p(4);
        k1 = p(5);
        k2 = p(6);
        n = p(7);
        Af = p(8);
        If = p(9);
    end
    fcn = getHandle(F, V, theta, eta, k1, k2, n, Af, If);
    symarray = ["A"; "I"; "P"; "iA"];
    raph = newtonRaphson(fcn, symarray);
    roots = getRoot(raph, guess);

end



function fun = getHandle(F, V, theta, eta, k1, k2, n, Af, If)
    f1 = @(A, I) (1/V)*(F*(1-theta)*Af + F*theta*(1+eta)*A - F*A - k1*(A^(1/3))*V - V*k2*(I^n)*A);
    f2 = @(A, I) (1/V)*(F*(1-theta)*If + F*theta*(1+eta)*I - F*I- V*k2*(I^n)*A);
    f3 = @(A, P) (1/V)*(F*theta*(1+eta)*P - F*P + k1*(A^(1/3))*V);
    f4 = @(A, I, iA) (1/V)*(F*theta*(1+eta)*iA - F*iA + V*k2*(I^n)*A);
    fun = {f1; f2; f3; f4};
    
end