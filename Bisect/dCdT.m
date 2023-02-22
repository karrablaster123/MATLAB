function val = dCdT(C, varStruct)
    %Need v0, V, C_in, k, n
    if ~testVar(varStruct)
        error("Data fed to dCdT is either not a structure or doesn't contain all the necessary fields(Check for spelling)");
    end
    val = (varStruct.v0/varStruct.V)*(varStruct.C_in - C) - varStruct.k*(C^varStruct.n);
end

function test = testVar(varStruct)
   test = isstruct(varStruct) && isfield(varStruct, 'v0') && isfield(varStruct, 'V') && isfield(varStruct, 'C_in') && isfield(varStruct, 'k') && isfield(varStruct, 'n'); 
end