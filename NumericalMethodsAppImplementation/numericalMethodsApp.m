function numericalMethodsApp
%Interact with the solvers

fig = uifigure;
fig.Name = "Numerical Methods";

gridLayout = uigridlayout(fig, [6 4]);

gridLayout.RowHeight = {30, 30, 30, 30, 30, '1x'};
gridLayout.ColumnWidth = {'1x', '1x', '1x', '1x'};

diffFunctionInputLabel = uilabel(gridLayout);
diffFunctionInput = uitextarea(gridLayout);

diffFunctionInputLabel.Text = "Diff Function f'(x,y) = ";
diffFunctionInput.Layout.Column = [2 4];


initialXLabel = uilabel(gridLayout);
initialX = uitextarea(gridLayout);

initialXLabel.Text = "Initial X";

initialYLabel = uilabel(gridLayout);
initialY = uitextarea(gridLayout);

initialYLabel.Text = "Initial Y";

rangeLabel = uilabel(gridLayout);
rangeLower = uitextarea(gridLayout);
rangeUpper = uitextarea(gridLayout);

rangeLabel.Text = "Range(Lower, Upper)";


stepSizeLabel = uilabel(gridLayout);
stepSize = uitextarea(gridLayout);
stepSizeLabel.Layout.Column = 1;
stepSize.Layout.Row = 4;
stepSize.Layout.Column = [2 4];
stepSizeLabel.Layout.Row = 4;
stepSizeLabel.Text = "Step Size";


functionSelectionDropDown = uidropdown(gridLayout);
functionSelectionDropDown.Layout.Column = [1 3];

functionSelectionDropDown.Items = ["Euler", "Runge-Kutta 4"];

run = uibutton(gridLayout);

run.Text = "Run";
run.ButtonPushedFcn = {@onRun};

plotAxes = uiaxes(gridLayout);
plotAxes.Layout.Column = [1 4];



    function onRun(~, ~)
        try
            diffFunction = str2func("@(x,y) " + diffFunctionInput.Value);
            %diffFunction(1, 1)
        catch
            error("Bad input to Diff Function");
        end

        try
            X0 = str2double(initialX.Value);
        catch
            error("Bad input to Initial X");
        end

        try
            Y0 = str2double(initialY.Value);
        catch
            error("Bad input to Initial Y");
        end

        range = [str2double(rangeLower.Value) str2double(rangeUpper.Value)];
        if(isnan(range(1)) || isnan(range(2)))
            range = [X0-1 X0+1];
        end

        step = str2double(stepSize.Value);

        if(isnan(step))
            step = 0.1;
        end
        numODE = numericalOdeSolve(diffFunction, X0, Y0, range, step, false);
        solver = functionSelectionDropDown.Value;
        
        switch solver
            case "Euler"
                numODE = eulersMethod(numODE);
                plot(plotAxes, numODE.x_points, numODE.y_points);

            case "Runge-Kutta 4"
                numODE = RK4(numODE);
                plot(plotAxes, numODE.x_points, numODE.y_points);
        end


    end

end
