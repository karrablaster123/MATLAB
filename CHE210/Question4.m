clear all; %#ok<CLALL> 
%{
What we know:
We have a cooler that takes an input stream with molar flow
300kmol/hr(30609.4 kg/hr) at 123.165 degrees Celsius at 10 bar in the gas
phase and cools it down to 25 degrees Celsius at 10 bar in the liquid
phase.

From the simulation results, we also know this requires a heating of
-2.26 MJ/s (- because "heating" therefore actually cooling).

Assumptions: We choose Brine(l) at -1 degrees Celsius as our coolant.
Brine(20% NaCl) has a heat capacity of 3.11 kJ/kg.K [1].

No heat loss to environment.

We will model a double-pipe counterflow heat exchanger.

Furthermore, from the pipe sizing in question 2, we assume an inner
diameter of 3 inches = 0.0762 m, since this would be the size of the feeder
pipe. 

We are condensing the organic vapor in a heat exchanger; we 
will use a heat transfer coefficient of 750 W/m2.K [2]
[1] https://myengineeringtools.com/Data_Diagrams/Specific_Heat_Capacity_Liquids.html
[2] https://www.engineeringtoolbox.com/heat-transfer-coefficients-exchangers-d_450.html
%}

%Declare knowns and assumed values
HeatLoss = 2.26e6; %J/s
mass_flow_organic = 30609.4/3600; %kg/s (3600 s/hr)
temp_in_organic = 123.165; % Celsius
temp_out_organic = 25; % Celsius
heat_transfer_coeff = 750; % W/m2.K
diameter = 0.0762; %m

%First let's calculate how much brine we might need.
final_temp_max = 25; %Celsius
temp_in_brine = -1; %Celsius
heat_cap_brine = 3.11e3; %J/kg.K
mass_flow_brine = HeatLoss/(heat_cap_brine*(final_temp_max - temp_in_brine)); %kg/s
disp("Required Mass Flow Rate = " + mass_flow_brine) 

%{
Due to the nature of heat loss/heat gain, as the driving
force(temperature difference) decreases, the rate of heat loss also 
decreases. For this reason, we will use 1.5x the mass flow rate.

For the NTU method, we need the heat capacity rates for both the hot and
cold fluids. Since our gas is becoming liquid, we will incorporate the
energy of vaporisation into a "heat capacity"-like quantity for use in this
evaluation.

Hot = Organic
Cold = Brine
%}

mass_flow_brine = 1.5*mass_flow_brine;
heat_cap_organic = -HeatLoss/(mass_flow_organic*(temp_out_organic - temp_in_organic));
C_organic = mass_flow_organic*heat_cap_organic;
C_brine = mass_flow_brine*heat_cap_brine;
C_min = getSmaller(C_organic, C_brine);
actual_transfer_rate = HeatLoss;
max_transfer_rate = C_min*(temp_in_organic - temp_in_brine);

fprintf("Capacity Rate (Brine): " + C_brine + ...
    "\nCapacity Rate (Organic): " +  C_organic + ...
    "\nSmaller Capacity Rate: " + C_min + ...
    "\nHeat Capacity (Organic): " + heat_cap_organic + "\n");

fprintf("Max Q_dot: " + max_transfer_rate);

c = C_min/getBigger(C_organic, C_brine);
epsilon = actual_transfer_rate/max_transfer_rate;

fprintf("\nc, Epsilon: " + c + ", " + epsilon + "\n");

NTU = (1/(c-1))*log((epsilon - 1)/(epsilon*c - 1)) %#ok<NOPTS> 

% NTU = U*As/Cmin. From this we can calculate the surface area required and
% then the length of the heat exchanger.

surface_area = NTU*C_min/heat_transfer_coeff %#ok<NOPTS> 
length = surface_area/(pi*diameter) %#ok<NASGU,NOPTS> 

%{
This gives us a length of 220 m. This is rather excessive and highly
impractical. An easy way to fix this is to increase diameter. Since this is
relatively easy to increase (large diameter pipes aren't hard to procure)
we shall test the effect below. 
%}
large_diameter = 0.5; %meter
length = surface_area/(pi*large_diameter) %#ok<NOPTS> 

%This reduces the length to a far more acceptable 33.54 meters. This is
%still slightly too long but can be improved by using a multipass
%exchanger. 

function small = getSmaller(x, y)
    if (x == y)
        warning("Both values input to get smaller are equal." + ...
            "The last value will be returned");
    end

    if (x < y)
        small = x;
        return;
        
    end

    small = y;

end

function big = getBigger(x, y)
    if (x == y)
        warning("Both values input to get bigger are equal." + ...
            "The last value will be returned");
    end

    if (x > y)
        big = x;
        return;
        
    end

    big = y;

end
