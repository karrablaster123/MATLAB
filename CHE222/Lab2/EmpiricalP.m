function p = EmpiricalP(T)
    if isnan(T)
        disp("T is NAN")
        return
    end

    if T <= 300
       p = NaN;
    elseif T <= 430.07
       p = exp(1.7599 - (323.96/T));
    elseif T <= 515.7
       p = exp(16.25 - (6479.6/T)); 
    elseif T <= 565.48
       p = exp(9.0023 - (2794.9/T));
    else
       p = exp(6.2047 - (1042.4/T));
    end 
end