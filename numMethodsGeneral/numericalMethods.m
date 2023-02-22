classdef numericalMethods
    methods

        function X_root = BisectRootFind(~, Error_a, X_Upper, X_Lower, functionIn, varStruct)

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
        
        function [y_points, x_points] = eulersMethod(~, diffFunction, x0, y0, x_final, step, shouldPlot)
            %Differential equation should be defined as y' = f(x, y)
            %If the function doesn't have x, just add write the function as
            %follows: y'(x,y) = f(y) + x*0;
            %Needs function, x0, y0.
            arguments
                ~
                diffFunction
                x0 (1,1) {mustBeReal}
                y0 (1,1) {mustBeReal}
                x_final (1,1) {mustBeReal} = x0 + 10
                step (1,1) {mustBeReal} = 1
                shouldPlot (1,1) {mustBeReal} = 0
            end
            x_points = x0:step:x_final;
            
            y_points = zeros(size(x_points));
            y_points(1) = y0;

            for i = 2:length(x_points)
                y_points(i) = y_points(i-1) + step*diffFunction(x_points(i-1), y_points(i-1));
            end
            
            if shouldPlot
                plot(x_points, y_points);
            end

        end
        
        function [y_points, x_points] = RK4(~, diffFunction, x0, y0, x_final, step, shouldPlot)
            %Differential equation should be defined as y' = f(x, y)
            %If the function doesn't have x, just add write the function as
            %follows: y'(x,y) = f(y) + x*0;
            %Needs function, x0, y0.
            arguments
                ~
                diffFunction
                x0 (1,1) {mustBeReal}
                y0 (1,1) {mustBeReal}
                x_final (1,1) {mustBeReal} = x0 + 10
                step (1,1) {mustBeReal} = 1
                shouldPlot (1,1) {mustBeReal} = 0
            end
            
            x_points = x0:step:x_final;
            y_points = zeros(size(x_points));
            y_points(1) = y0;
            
            for i = 2:length(x_points)
                k1 = step*diffFunction(x_points(i-1), y_points(i-1));
                k2 = step*diffFunction(x_points(i-1) + 0.5*step, y_points(i-1) + 0.5*k1);
                k3 = step*diffFunction(x_points(i-1) + 0.5*step, y_points(i-1) + 0.5*k2);
                k4 = step*diffFunction(x_points(i-1) + step, y_points(i-1) + k3);
                y_points(i) = y_points(i-1) + (1/6)*(k1 + 2*k2 + 2*k3 + k4);
            end
            
            if shouldPlot
                plot(x_points, y_points);
            end
        end
    
    end
end
