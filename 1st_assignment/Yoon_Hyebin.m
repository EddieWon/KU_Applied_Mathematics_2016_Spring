% This script will calculate a person's age in seconds every time it is
% executed, and then save a person's name, year and date of birth,
% and age in seconds into a text file.

%% before starting
% clear the workspace, close all the figures, clear the command window
clear all
close all
clc

%% create myInfo cell
% myInfo = {FirstName, LastName, BirthYear, BirthMonth, BirthDate}
% This cell contains personal information that will be written in a text file
myInfo = {'Hyebin','Yoon',1994,11,17};

%% create variables needed for age calculation
% calculate the current time
% currentTime = [Year, Month, Date, Hour, Minute, Second]
currentTime = clock();

% This vector contains a number of days for each month.
% ex) M_Day(3) == 31 (31 days in March)
% assume that there are no leap years.
M_Day = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

% calculate an approximate age by subtracting birth year from the current year
% and then convert the result into seconds.
year = (currentTime(1) - myInfo{3}) * 31536000;

% calculate the elapsed time (hour + minute + seconds)
second = currentTime(4)*3600 + currentTime(5)*60 + currentTime(6);

% assign values to variables which will be frequently used in calculation 
currentMonth = currentTime(2);
currentDate = currentTime(3);
birthMonth = myInfo{4};
birthDate = myInfo{5};


%% age calculation
% calculate the number of seconds that a person has been alive
% and then assign it to the 6th entry in myInfo.

% 1) if current month > birth month
if currentMonth > birthMonth
    % if current month - birth month > 1
    if currentMonth - birthMonth > 1
        day = (M_Day(birthMonth) - birthDate + sum(M_Day(birthMonth+1:currenMonth-1)) ... 
            + currentDate) * 86400;
    else
        day = (M_Day(birthMonth) - birthDate + currentDate) * 86400;
    end
    myInfo{6} = year + day;
% 2) if current month == birth month
elseif currentMonth == birthMonth
    % if current date >= birth date
    if currentDate >= birthDate
        day = (currentDate - birthDate) * 86400;
        myInfo{6} = year + day + second;
    else
        myInfo{6} = year + second - (birthDate - currentDate) * 86400;
    end
% 3) if current month < birth month    
else
    myInfo{6} = year + second - (M_Day(currentMonth) - currentDate ...
        + birthDate + sum(M_Day(currentMonth+1:birthMonth-1))) * 86400;
end

% display the age in seconds in the command window
sprintf('At the time of calling this script, I was %f seconds old.',myInfo{6})

%% save information into a txt file

% create a new text file
file = fopen('Yoon_Hyebin_myInfo.txt','w');

% save the information from myInfo into the file
% first name
fprintf(file,'%s\n',myInfo{1});
% last name
fprintf(file,'%s\n',myInfo{2});
% birthday
fprintf(file,'%d / %d / %d\n',myInfo{3},myInfo{4},myInfo{5});
% age in seconds
fprintf(file,'%f',myInfo{6});

% close the file
fclose(file);