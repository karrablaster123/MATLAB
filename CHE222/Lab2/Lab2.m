TempArray = 300:10:600;
PressureArray = zeros(1, length(TempArray));

for idx = 1:length(TempArray)
    PressureArray(idx) = EmpiricalP(TempArray(idx));
end

plot(TempArray, PressureArray);
title("Pressure vs Temperature from Empirical Pressure Eqn");