%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Assignment_3, wrapper
%
%                                                  Written by Kim, Wiback,
%                                                      2016.04.18 Ver 1.1.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





%% Part 1 - c (a, b are included in GaussSolve.m.) %%%%%%%%%%%%%%%%%%%%%%%
kill



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% GaussSolve with different sample sizes
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% n == 1
n_1 = tic;
[~, ~] = GaussSolve(rand(1), rand(1, 1));
elapsed_1 = toc(n_1);

%%% n == 5
n_1000 = tic;
[~, ~] = GaussSolve(rand(5), rand(5, 1));
elapsed_2 = toc(n_1000);

%%% n == 10
n_10 = tic;
[~, ~] = GaussSolve(rand(10), rand(10, 1));
elapsed_3 = toc(n_10);

%%% n == 100
n_100 = tic;
[~, ~] = GaussSolve(rand(100), rand(100, 1));
elapsed_4 = toc(n_100);

%%% n == 1000
n_1000 = tic;
[~, ~] = GaussSolve(rand(1000), rand(1000, 1));
elapsed_5 = toc(n_1000);

%%% Printing
fprintf(['Time elapsed with n = 1: %f\n', ...
    'Time elapsed with n = 5: %f\n', ...
    'Time elapsed with n = 10: %f\n', ...
    'Time elapsed with n = 100: %f\n', ...
    'Time elapsed with n = 1000: %f\n'], ...
    elapsed_1, elapsed_2, elapsed_3, elapsed_4, elapsed_5)

%%% Figure bases
screen_size = get(0, 'screensize');
fg_size = [1000, 550];
fg_1 = figure('position', ...
    [(screen_size(3) - fg_size(1)) / 2, ... % 1/2*(Screen's x - figure's x)
    (screen_size(4) - fg_size(2)) / 2, ... % 1/2*(Screen's y - figure's y)
    fg_size(1), ... % The figure's x
    fg_size(2)]); % The figure's y

%%% Plotting
hold on
plot(1, elapsed_1, 'ro', 'markersize', 20);
plot(2, elapsed_2, 'yo', 'markersize', 20);
plot(3, elapsed_3, 'go', 'markersize', 20);
plot(4, elapsed_4, 'bo', 'markersize', 20);
plot(5, elapsed_5, 'mo', 'markersize', 20);
legend('n = 1', 'n = 5', 'n = 10', 'n = 100', 'n = 1000')
title('\bf\it\fontsize{20}\color{red} Time Elapsed')
xlabel('cases')
ylabel('time')





%% Part 2 - a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
kill



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Truss, column order in F1, F2, F3, H2, V2, V3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n = 6;
A = zeros(n, n);
b = zeros(n, 1);

%%% Node 1: -F1*cos(30) + F3*cos(60) == 0
A(1, 1) = -cos(degtorad(30));
A(1, 3) = cos(degtorad(60));

%%% Node 2: -F1*sin(30) - F3*sin(60) == -1000
A(2, 1) = -sin(degtorad(30));
A(2, 3) = -sin(degtorad(60));
b(2, 1) = -1000;

%%% Node 3: H2 + F2 + F1*cos(30) == 0
A(3, 1) = cos(degtorad(30));
A(3, 2) = 1;
A(3, 4) = 1;

%%% Node 4: V2 + F1*sin(30) == 0
A(4, 1) = sin(degtorad(30));
A(4, 5) = 1;

%%% Node 5: -F2 - F3*cos(60) == 0
A(5, 2) = -1;
A(5, 3) = -cos(degtorad(60));

%%% Node 6: V3 + F3*sin(60) == 0
A(6, 3) = sin(degtorad(60));
A(6, 6) = 1;



%%%%%%%%%%%%%%%%%%%
% Gauss elimination
%%%%%%%%%%%%%%%%%%%
[x, ~] = GaussSolve(A, b);
fprintf(['F1: %f\n', ...
    'F2: %f\n', ...
    'F3: %f\n', ...
    'H2: %f\n', ...
    'V2: %f\n', ...
    'V3: %f\n'], x(1), x(2), x(3), x(4), x(5), x(6))





%% Part 2 - b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
kill



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Traffic, column order in x_1, x_2, x_3, x_4, x_5
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n = 5;
A = zeros(n, n);
b = zeros(n, 1);

%%% Intersection A: x_1 + 80 == x_2 + x_4
A(1, 1) = 1;
A(1, 2) = -1;
A(1, 4) = -1;
b(1, 1) = -80;

%%% Intersection B: x_2 == 50 + x_3
A(2, 2) = 1;
A(2, 3) = -1;
b(2, 1) = 50;

%%% Intersection C: x_3 + x_4 + x_5 == 130
A(3, 3) = 1;
A(3, 4) = 1;
A(3, 5) = 1;
b(3, 1) = 130;

%%% Intersection D: 100 == x_1 + x_5
A(4, 1) = 1;
A(4, 5) = 1;
b(4, 1) = 100;

%%% Total: x_1 + x_2 + x_3 + x_4 + x_5 == 230
A(5, 1) = 1;
A(5, 2) = 1;
A(5, 3) = 1;
A(5, 4) = 1;
A(5, 5) = 1;
b(5, 1) = 230;



%%%%%%%%%%%%%%%%%%%
% Gauss elimination
%%%%%%%%%%%%%%%%%%%
[~, ~] = GaussSolve(A, b);



%%%%%%%%%%%%%%%%
% Free variables
%%%%%%%%%%%%%%%%

%%% 1. x_2 is a free variable.
% x_1 - x_2 - x_4 == -80
% x_2 - x_3       == 50
% x_3 + x_4 + x_5 == 130
% x_1 + x_5       == 100

x_2 = input('Your x2 value? (51~100)\n');
x_3 = x_2 - 50;

%%% 2. Now, x4 is a free variable.
% x_1 - x_4 == -80 + x_2
% x_4 + x_5 == 130 - x_3
% x_1 + x_5 == 100
x_4 = input('Your x4 value? (31~80)\n');
x_1 = -80 + x_2 + x_4;
x_5 = 130 - x_3 - x_4;

%%% Printing
fprintf(['x1: %d\n', ...
    'x2: %d\n', ...
    'x3: %d\n', ...
    'x4: %d\n', ...
    'x5: %d\n'], ...
    x_1, x_2, x_3, x_4, x_5)