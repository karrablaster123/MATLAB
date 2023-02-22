
function X_root = BisectRootFind(Error_a, X_Upper, X_Lower, functionIn, varStruct)
    
    %This function requires a set of inputs: 1) An acceptable Error range
    %2) A higher bound 3) A lower bound 4) The function to be evaluated 5)
    %A structure of variables/parameters to be fed to the function for
    %evaluation.
    
    %Instead of feeding individual parameters, we instead require a data
    %structure. This allows us to transfer large combinations of parameters
    %using a single function parameter. 
    if ~isa(functionIn, 'function_handle')
        error("No function passed. Cannot evaluate bisection.");
    elseif ~isstruct(varStruct)
        error("The variable feed is invalid");
    end

    disp(functionIn) %Debug
    yUpper = functionIn(X_Upper, varStruct);
    yLower = functionIn(X_Lower, varStruct);
    yProduct = yUpper*yLower;
    
    if yProduct > 0
        error("The input bounds are invalid. Try again");
    elseif yProduct == 0
        if yUpper == 0
            X_root = X_Upper;
            return;
        
        elseif yLower == 0
            X_root = X_Lower;
            return;
        end

    end

    %We set the starting error to 100%. This is arbitrarily selected and
    %simply ensures the while loop runs at least once. 
    E = 100;
    while (E > Error_a)
        
        yLower = functionIn(X_Lower, varStruct);
        X_root = (X_Upper + X_Lower)/2;
        yRoot = functionIn(X_root, varStruct);
        yProduct = yRoot*yLower;
        
        if yProduct < 0
            X_Upper = X_root;
            E = ((X_Upper - X_Lower)/(X_Upper+X_Lower))*100;
            continue;
        elseif yProduct > 0
            X_Lower = X_root;
            E = ((X_Upper - X_Lower)/(X_Upper+X_Lower))*100;
            continue;
        else
            return;
        end
    end
        
    
end