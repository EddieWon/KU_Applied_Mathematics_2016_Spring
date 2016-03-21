% meanSTD returns the mean and standard deviation of input data.
%
% input: data
% (the function will work on arrays with multiple columns of data)
%
% output: total_mn (mean), total_std (standard deviation(std))
function [total_mn,total_std] = meanSTD(data)
% calculate the mean
total_mn = mean(data);
% calculate the std
total_std = std(data);