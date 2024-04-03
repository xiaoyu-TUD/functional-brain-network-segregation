clear;clc;

load('C:\Users\wang1\Downloads\power_cole.mat');

M = []; 
for ii=1:length(data_res)
    dat=data_res{ii};
    M(:,ii)=mean(dat');%%calculate mean of all voxels of the ROI
end

% Define your time range (start and end time)
start_time = 1;  % starting time point
end_time = length(M);  % ending time point

% Number of parts to divide the time range into
num_parts = 20;

time_points = fix(linspace(start_time, end_time, num_parts + 1));
sort_results = cell(1, num_parts); 

for i = 1:num_parts
    sort_results{i} = M(time_points(i):time_points(i+1), :);
end

save(['sort_power_20_blocks.mat'],...
    'sort_results')

