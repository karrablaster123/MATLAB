classdef numericalOdeSolve
    %Differential equation should be defined as y' = f(x, y)
    %If the function doesn't have x, just add write the function as
    %follows: y'(x,y) = f(y) + x*0;
    %Needs function, x0, y0.

    properties
        diffFunction
        x0
        y0
        shouldPlot
        step
        range
        x_points
        y_points
        plots
        %debug
    end

    methods
        function solver = numericalOdeSolve(func, X0, Y0,  rangeOfX, stepSize, Plot)
            %Required inputs: Function handle, x0, y0
            %Optional args are Plot, stepSize, rangeOfX
            %Plot param is true or false
            %defaults are range = [x0-1 x0+1], stepSize = 0.1, Plot = false

            arguments
                func
                X0 (1,1) {mustBeReal}
                Y0 (1,1) {mustBeReal}
                rangeOfX (1,2) {mustBeReal} = [X0-1 X0+1]
                stepSize (1,1) {mustBeReal, mustBeGreaterThan(stepSize, 1e-5)} = 0.1
                Plot (1,1) {mustBeNumericOrLogical} = false


            end
            if ~isa(func, "function_handle")
                error("Seems like you didn't pass a function to the contstructor!");

            end
            solver.diffFunction = func;
            solver.x0 = X0;
            solver.y0 = Y0;
            solver.shouldPlot = Plot;
            solver.step = stepSize;
            sort(rangeOfX);
            if ~(ge(X0, rangeOfX(1)) && le(X0, rangeOfX(2)))
                error("X0 is out of range.");
            end
            solver.range = rangeOfX;

            if solver.shouldPlot
                solver.plots = gcf;
            end

        end

        function this = eulersMethod(this)

            this.x_points = this.range(1):this.step:this.range(2);
            this.y_points = zeros(size(this.x_points));
            idx0 = find(abs(this.x_points - this.x0) < 1e-5);

            %debug
            %disp(this.x_points)

            this.y_points(idx0) = this.y0;

            if idx0 > 1
                for i = (idx0-1):-1:1
                    this.y_points(i) = this.y_points(i+1) - this.step*this.diffFunction(this.x_points(i+1), this.y_points(i+1));
                end
            end

            for i = idx0+1:length(this.x_points)
                this.y_points(i) = this.y_points(i-1) + this.step*this.diffFunction(this.x_points(i-1), this.y_points(i-1));
            end

            if this.shouldPlot
                figure(this.plots);
                plot(this.x_points, this.y_points);
                legend("Euler");
            end

        end

        function this = RK4(this)

            this.x_points = this.range(1):this.step:this.range(2);
            this.y_points = zeros(size(this.x_points));
            idx0 = find(abs(this.x_points - this.x0) < 1e-5);
            %disp(idx0) %debug
            this.y_points(idx0) = this.y0;

            if idx0 > 1
                for i = (idx0-1):-1:1
                    k1 = this.step*this.diffFunction(this.x_points(i+1), this.y_points(i+1));
                    k2 = this.step*this.diffFunction(this.x_points(i+1) - 0.5*this.step, this.y_points(i+1) - 0.5*k1);
                    k3 = this.step*this.diffFunction(this.x_points(i+1) - 0.5*this.step, this.y_points(i+1) - 0.5*k2);
                    k4 = this.step*this.diffFunction(this.x_points(i+1) - this.step, this.y_points(i+1) - k3);
                    this.y_points(i) = this.y_points(i+1) - (1/6)*(k1 + 2*k2 + 2*k3 + k4);


                end
            end

            for i = (idx0+1):length(this.x_points)
                k1 = this.step*this.diffFunction(this.x_points(i-1), this.y_points(i-1));
                k2 = this.step*this.diffFunction(this.x_points(i-1) + 0.5*this.step, this.y_points(i-1) + 0.5*k1);
                k3 = this.step*this.diffFunction(this.x_points(i-1) + 0.5*this.step, this.y_points(i-1) + 0.5*k2);
                k4 = this.step*this.diffFunction(this.x_points(i-1) + this.step, this.y_points(i-1) + k3);
                this.y_points(i) = this.y_points(i-1) + (1/6)*(k1 + 2*k2 + 2*k3 + k4);
            end

            if this.shouldPlot
                figure(this.plots);
                plot(this.x_points, this.y_points);
                legend("RK4");
            end
        end

    end
end
