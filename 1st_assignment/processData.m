% This script will load data and then
% plot the means, standard deviations, and scatter graphs.
%% before starting
% clear the workspace, close all the figures, clear the command window
clear all
close all
clc

%% load data
load experimentData

% calculate means and standard deviations of each subset in data
% subset: 1) heart rate, 2) weight, 3) exercise
[t_mn,t_std] = meanSTD(experimentData);

%% plot mean and standard deviation(std)
% x: x value of plot
% y: used in creating y value
x = [1 15];
y = ones(1,2);

% This cell will be used in axis labels
label = {'Heart rate(bpm)', 'Weight (kg)', 'Exercise (hrs)'};

figure(1)
% 3 subplots (heart rate, weight, exercise)
for n = 1:3
    % nth subplot
    subplot(3,1,n)
    % plot the mean
    plot(x,t_mn(n)*y,'-')
    % set x-axis limit
    xlim(x)
    % set y-axis label
    ylabel(label{n})
    % hide x-axis ticks (for I think these are unnecessary)
    set(gca,'xtick',[])
    hold on
    % plot std
    plot(x,(t_mn(n)+t_std(n))*y,'--')
    hold on
     plot(x,(t_mn(n)-t_std(n))*y,'--')
    hold off
    % add legend
    legend('mean','std')
end
% save figure(1)
% instead of saveas() and figure handle(gcf), savefig() is used.
savefig('analysis.fig')

%% make scatterplots
figure(2)
% plot heart rate against weight
subplot(3,1,1)
scatter(experimentData(:,2),experimentData(:,1))
xlabel(label{2})
ylabel(label{1})
% plot heart rate against exercise rate
subplot(3,1,2)
scatter(experimentData(:,3),experimentData(:,1))
xlabel(label{3})
ylabel(label{1})
% plot weight against exercise rate
subplot(3,1,3)
scatter(experimentData(:,3),experimentData(:,2))
xlabel(label{3})
ylabel(label{2})
% save figure(2)
savefig('analysis2.fig')