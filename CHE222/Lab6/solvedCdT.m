function C_root = solvedCdT(v0, V, C_in, k, n, C_Lower, C_Upper, Error_a)
    
    yUpper = dCdT(v0, V, C_in, C_Upper, k, n);
    yLower = dCdT(v0, V, C_in, C_Lower, k, n);
    yProduct = yUpper*yLower;

    if yProduct > 0
        error("The input bounds are invalid. Try again");
    elseif yProduct == 0
        if yUpper == 0
            C_root = C_Upper;
            return;
        
        elseif yLower == 0
            C_root = C_Lower;
            return;
        end

    end
    E = 100;
    while (E > Error_a)
        yUpper = dCdT(v0, V, C_in, C_Upper, k, n);
        yLower = dCdT(v0, V, C_in, C_Lower, k, n);
        C_root = (C_Upper + C_Lower)/2;
        yRoot = dCdT(v0, V, C_in, C_root, k, n);
        yProduct = yRoot*yLower;
        
        if yProduct < 0
            C_Upper = C_root;
            
            E = ((C_Upper - C_Lower)/(C_Upper+C_Lower))*100;
            
        elseif yProduct > 0
            C_Lower = C_root;
            
            E = ((C_Upper - C_Lower)/(C_Upper+C_Lower))*100;
            
        else
            return;
        end
        
        
    end
end