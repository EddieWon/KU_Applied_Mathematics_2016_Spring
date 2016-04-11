%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Derivation function
%
%%% Input(s)
%%% function_handle; A function that is to be differenciated
%%% x_values; Specific values to be differenciated (will be vectorized)
%
%%% Output(s)
%%% derivative; Results of the derivations
%
%                                                  Written by Kim, Wiback,
%                                                     2016.04.11. Ver 1.1.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





%% Derivational Function %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [derivative] = derive(function_handle, x_values, varargin)



%%%%%%%%%%%%%%%%%%%%%%%%
% Vectorizing the inputs
%%%%%%%%%%%%%%%%%%%%%%%%
% When the inputs are not aligned as a vector, proceed.
if isscalar(x_values)
    % Consider that 1st element of x_values is already filled.
    x_values(2:length(varargin) + 1, 1) = 0;
    for surplus_inputs = 1:length(varargin)
        % Adding 2nd, 3rd, ... nth element to x_values (vectorizing)
        x_values(surplus_inputs + 1) = varargin{surplus_inputs};
    end
end



%%%%%%%%%%%%%%%%
% The derivation
%%%%%%%%%%%%%%%%
% The derivation will cut off one dimensionality.
derivative = zeros(length(x_values) - 1, 1);

%%% Main loop
for x = 1:length(x_values) - 1
    derivative(x) = (function_handle(x_values(x + 1)) - ... % Numerator
        function_handle(x_values(x))) / ... % Numerator
        (x_values(x + 1) - x_values(x)); % Denumerator
end