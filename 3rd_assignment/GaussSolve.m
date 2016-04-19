%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Assignment_3, GaussSolve
%
%%% INPUT:
% 1. A in equation Ax=b, coefficients matrix
% 2. b in equation Ax=b, biases (intercepts)
%
%%% OUTPUT:
% 1. x in eqaution Ax=b, unknown parameters we have to estimate
% 2. det, determinant of resulting upper triangular matrix
%
%                                                  Written by Kim, Wiback,
%                                                      2016.04.18 Ver 1.1.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [x, det] = GaussSolve(A, b)





%% Error Handling %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%
% Suppressing output error
%%%%%%%%%%%%%%%%%%%%%%%%%%
x = NaN;
det = NaN;



%%%%%%%%%%%%%%%%%%
% Dimension errors
%%%%%%%%%%%%%%%%%%

%%% If A is not a square matrix, escape.
if size(A, 1) ~= size(A, 2)
    fprintf(['Coefficients matrix (A) is not a square matrix.\n', ...
        'Usage: [x, det] = GaussSolve(A == square matrix, b)\n'])
    return
end

%%% When row-wise dimensions of A and b mismatch, escape.
if size(A, 1) ~= size(b, 1)
    fprintf(['Row-wise dimensions of A and b must agree.\n', ...
        'Usage: [x, det] = GaussSolve(A(match, 1), b(match, 1))\n'])
    return
end



%%%%%%%%%%%%%%%%
% Division error
%%%%%%%%%%%%%%%%
% this kind of error will be dealt in below section.





%% Gauss Elimination %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
column = 1;
for row = 1:size(A, 1)
    % Finding maximum among possible pivot element candidates
    [max_pivot_element, max_pivot_row] = max(abs(A(row:end, column)));
    % max_pivot_row is the row index of A, not of A(row:end).
    max_pivot_row = max_pivot_row + row - 1;
    
    
    
    %%%%%%%%%%%%%%%%
    % Division error
    %%%%%%%%%%%%%%%%
    % Pivot element with value 0 should be replaced by partial pivoting.
    % But when this is not possible, the function has to be escaped.
    if max_pivot_element == 0
        fprintf(['Pivot element became zero during the process.\n', ...
            'Escaping...\n'])
        return
    end
    
    
    
    %%%%%%%%%%%%%%%%%%
    % Partial pivoting
    %%%%%%%%%%%%%%%%%%
    % Pivot equation should have the maximum pivot element
    % among all the candidates, if not, do the partial pivoting.
    if row ~= max_pivot_row
        % Stack informations temporary.
        temp_A = A(row, :);
        temp_b = b(row, :);
        % Switching the rows (retrieving the stacked informations)
        A(row, :) = A(max_pivot_row, :);
        A(max_pivot_row, :) = temp_A;
        b(row, :) = b(max_pivot_row, :);
        b(max_pivot_row, :) = temp_b;
    end
    
    
    
    %%%%%%%%%%%%%%%%%%%%%
    % Forward elimination
    %%%%%%%%%%%%%%%%%%%%%
    % Timing
    tic
    % Going down each row
    for forward = 1:size(A, 1) - row
        rational = A(row+forward, column) / A(row, column);
        A(row+forward, :) = A(row+forward, :) - (rational * A(row, :));
    end
    % Timing
    forward_elimination_time = toc;
    fprintf('Time elapsed with forward elimination of %dth row, %f\n', ...
        row, forward_elimination_time)
    
    %%% For next forward elimination
    column = column + 1;
end



%%%%%%%%%%%%%
% Extrating x
%%%%%%%%%%%%%
% Timing
tic
% Ax = b
%    |
%    |
%    |
%    V
% x = inv(A) * b
x = A \ b;
% Timing
back_substitution_time = toc;
fprintf('Time elapsed with back substitution, %f\n', ...
    back_substitution_time)



%%%%%%%%%%%%%%%
% Extrating det
%%%%%%%%%%%%%%%
% Dummy for the determinant
det = 1;
% Note that A is now an upper triangular matrix.
for diagonals = 1:size(A, 1)
    det = det * A(diagonals, diagonals);
end