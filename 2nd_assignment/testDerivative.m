%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Testing script
%
%                                                  Written by Kim, Wiback,
%                                                     2016.04.11. Ver 1.1.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





%% Fixed Difference Between Each X %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
deriv_sin = derive(@sin, -pi:0.1:pi);



%%%%%%%%%%%%%%%%
% Setting figure
%%%%%%%%%%%%%%%%
screen_size = get(0, 'screensize');
fg_size = [1000, 550];
fg_1 = figure('position', ...
    [(screen_size(3) - fg_size(1)) / 2, ... % 1/2*(Screen's x - figure's x)
    (screen_size(4) - fg_size(2)) / 2, ... % 1/2*(Screen's y - figure's y)
    fg_size(1), ... % The figure's x
    fg_size(2)]); % The figure's y



%%%%%%%%%
% Drawing
%%%%%%%%%
subplot(1, 3, 1)
hold on
% When shifted, they will be spot on match.
plot(-pi:0.1:pi-0.1, deriv_sin, 'g');
plot(-pi:0.1:pi, cos(-pi:0.1:pi), 'r');
legend('deriv-of-sin', 'cos')
title('\bf\it\fontsize{20}\color{red} Difference: 0.1 ')





%% Not Fixed Difference Between Each X %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%
% Changing difference
%%%%%%%%%%%%%%%%%%%%%
difference = 1;
for step = 1:17
    
    %%% Coordinates
    % Intervals between the each x will be reduced over loops.
    x = -pi:difference:pi;
    % We need different x coordinates to deal with length discrepancy.
    x_cos = x;
    x_cos(end) = [];
    % New coordinates system with very very middle point
    x_new = -pi + 1/2*difference:difference:pi - 1/2*difference;
    % We need different x coordinates to deal with length discrepancy.
    x_cos_new = x_new;
    x_cos_new(end) = [];
    
    %%% Errors
    % Consider that length(deriv_sin) + 1 == length(cos).
    sse = sum((derive(@sin, x) - cos(x_cos)').^2); % Sum Square Error
    sse_root = sqrt(sse); % Square root of sse
    % Same as above
    sse_new = sum((derive(@sin, x_new) - cos(x_cos_new)').^2);
    sse_root_new = sqrt(sse_new);
    
    %%% Drawing
    % Opening second axes
    subplot(1, 3, 2)
    hold on
    title('\bf\it\fontsize{20}\color{green} Difference Not fixed ')
    xlim([0, 1])
    ylim([0, 1])
    % Plotting sse_root against difference
    loglog(difference, sse_root, 'ro-', 'markersize', 20)
    loglog(difference, sse_root_new, 'go-', 'markersize', 15)
    drawnow
    % 10^-6 seems to be too low, so let's go with 10^-2.
    if sse_root < 10^-2
        fprintf(['Points (not middle)', ...
            ' where SSE gets to be lower than 10^-2: %f \n'], ...
            difference)
    end
    if sse_root_new < 10^-2
        fprintf(['Points (middle)', ...
            ' where SSE gets to be lower than 10^-2: %f \n'], ...
            difference)
    end
    % Renewing difference as assignment required
    difference = difference / 2;
end

%%% Wrap-up
fprintf(['We can see that the inaccuracy came from the discrepancy \n', ...
    'between the different length of vectors, and when this \n', ...
    'discrepancy has solved, it is no use whether or not \n', ...
    'we have the very middle coordinates (it''s just about shifting.).\n'])





%% Other Functions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Declaring some anonymous functions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
func_1 = @(x) log(x);
func_2 = @(x) 1 / sqrt(x);
func_3 = @(x) cos(x) / x;



%%%%%%%%%%%%%
% Derivations
%%%%%%%%%%%%%
differences = 0.1;
% Upper 0
deriv_func_1_upper_0 = derive(func_1, 0.1:differences:pi);
deriv_func_2_upper_0 = derive(func_2, 0.1:differences:pi);
deriv_func_3_upper_0 = derive(func_3, 0.1:differences:pi);
% Below 0
deriv_func_1_below_0 = derive(func_1, -pi:differences:0);
deriv_func_2_below_0 = derive(func_2, -pi:differences:0);
deriv_func_3_below_0 = derive(func_3, -pi:differences:0);



%%%%%%%%%
% Drawing
%%%%%%%%%
subplot(1, 3, 3)
hold on
% Ignoring 0
title('\bf\it\fontsize{20}\color{blue} Other derivations (ignoring 0)')
% Upper 0
plot(0.1 + 1/2*differences:differences:pi - 1/2*differences, ...
    deriv_func_1_upper_0, 'r');
plot(0.1 + 1/2*differences:differences:pi - 1/2*differences, ...
    deriv_func_2_upper_0, 'g');
plot(0.1 + 1/2*differences:differences:pi - 1/2*differences, ...
    deriv_func_3_upper_0, 'b');
% Below 0
plot(-pi + 1/2*differences:differences:0 - 1/2*differences, ...
    deriv_func_1_below_0, 'r');
plot(-pi + 1/2*differences:differences:0 - 1/2*differences, ...
    deriv_func_2_below_0, 'g');
plot(-pi + 1/2*differences:differences:0 - 1/2*differences, ...
    deriv_func_3_below_0, 'b');
legend('func-1-deriv', 'func-2-deriv', 'func-3-deriv')