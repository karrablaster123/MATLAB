classdef newtonRaphson

    properties
        jacobian
        w0
        w
        functions
        Error_tol
    end

    methods
        
        function newtRaph = newtonRaphson(func, w)

            arguments
                func (:, 1) cell
                w (:, 1) {mustBeText}
            end

            try
                newtRaph.w = sym(w);
            catch
                error("Unable to symbolise inputVars");
            end

  
            
            newtRaph.functions = sym(func);
            %disp(newtRaph.functions);
            %disp(newtRaph.w);
            getJacobian;

            function getJacobian
                newtRaph.jacobian = sym(zeros([length(newtRaph.functions) length(newtRaph.w)]));
                for i = 1:length(newtRaph.functions)
                    for j = 1:length(newtRaph.w)
                        %disp(diff(newtRaph.functions(i), newtRaph.w(j)))
                        newtRaph.jacobian(i, j) = diff(newtRaph.functions(i), newtRaph.w(j));
                    end

                end
            end

        end

        function xRoot = getRoot(this, w0, tol)
        
            arguments
                this
                w0 (:, 1) {mustBeReal}
                tol (1, 1) {mustBeReal} = 1e-4
            end
            Err = 1;
            currW = w0;
            while(Err > tol)
                fx = double(getFx(currW));
                jac = double(getJacVal(currW));
                xRoot = currW - jac\fx;
                Err = sqrt(sum(fx.*fx));
                disp(Err);
                currW = xRoot;
            end




            function fx  = getFx(x)
                fx = subs(this.functions, this.w, x);
            end

            function jac = getJacVal(x)
                jac = subs(this.jacobian, this.w, x);
            end

        
        end

        

    end

end