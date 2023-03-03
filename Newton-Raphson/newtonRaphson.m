classdef newtonRaphson

    properties
        jacobian
        w0
        w
        functions
        Error_tol
    end

    methods
        function newtRaph = newtonRaphson(func, w, tol)

            arguments
                func
                w (:, 1) {mustBeText}
                tol {mustBeReal} = 1e-4
            end

            try
                newtRaph.w = syms(w);
            catch
                error("Unable to symbolise inputVars");
            end

            if ~isa(func, "function_handle")
                try
                    func = @(w) func;
                catch
                    error("Seems like you didn't pass a function to the constructor!");
                end
            end

            newtRaph.functions = func;
            newtRaph.Error_tol = tol;

            try
                getJacobian;
            catch
                error("Unable to create Jacobian");
            end

            function getJacobian
                newtRaph.jacobian = zeros();
                for i = 1:length(newtRaph.functions)
                    for j = 1:length(newtRaph.w)
                        newtRaph.jacobian(i, j) = diff(newtRaph.functions(i), newtRaph.w(i));
                    end

                end
            end

        end

        

    end

end