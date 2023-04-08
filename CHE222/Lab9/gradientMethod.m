classdef gradientMethod
    properties
        functions
        w
        gradfunctions
        secondDer
    end

    methods
        function gradMeth = gradientMethod(func, w)
            arguments
                func (:, 1) cell
                w (:, 1) {mustBeText}
            end
            
            try 
                gradMeth.w = sym(w);
                gradMeth.functions = sym(func);
            catch
                error("Unable to symbolise input!");
            end
            
            try
                gradMeth.gradfunctions = gradient(gradMeth.functions, gradMeth.w);
            catch
                error("Unable to calculate gradient!");
            end
            
            %{
            fig = uifigure;
            fig.Name = "Grad Output";
            gridLayout = uigridlayout(fig, [1 1]);
            debugOut = uitextarea(gridLayout);
            debugOut.Value = string(gradMeth.gradfunctions);
            %}
        end

        function x = descent(this, guess, alpha, tol)
            arguments
                this
                guess 
                alpha (1,1)
                tol (1,1) = 1e-8
            end
            currErr = 100;
            x = guess;
            iter = 0;
            while(currErr > tol)
                oldf = getFx(x);
                x = x - alpha*double(getGrad(x));
                currErr = abs(100*((double(getFx(x)) - double(oldf))/double(getFx(x))));
                iter = iter + 1;
                if iter > 1000
                    warning("Unable to converge!");
                    break;
                end
            end
            x = double(x);

            function gradeval  = getGrad(x)
                gradeval = subs(this.gradfunctions, this.w, x);
            end

            function fx = getFx(x)
                fx = subs(this.functions, this.w, x);
            end

        end
        function x = ascent(this, guess, alpha, tol)
            arguments
                this
                guess 
                alpha (1,1)
                tol (1,1) = 1e-8
            end
            currErr = 100;
            x = guess;
            iter = 0;
            while currErr > tol 
                oldf = getFx(x);
                x = x + alpha*double(getGrad(x));
                currErr = abs(100*((double(getFx(x)) - double(oldf))/double(getFx(x))));
                iter = iter + 1;
                if iter > 1000
                    warning("Unable to converge!");
                    break;
                end
            end
            
            x = double(x);
            function gradeval  = getGrad(x)
                gradeval = subs(this.gradfunctions, this.w, x);
            end

            function fx = getFx(x)
                fx = subs(this.functions, this.w, x);
            end
        end
        
    end
end