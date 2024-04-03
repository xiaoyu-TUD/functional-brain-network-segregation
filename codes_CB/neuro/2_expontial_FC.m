clear;clc;

%%%%%Reference
%%%%%Pozzi, F., Di Matteo, T. & Aste, T. Exponential smoothing weighted correlations. The European 941 Physical Journal B 85, doi:10.1140/epjb/e2012-20697-x (2012). 

load('C:\Users\wang1\Downloads\sort_power_20_blocks.mat');
 
for ii=1:length(sort_results)
    
    bbb = size(sort_results{ii},1);
    theta = bbb./3;
    dt = bbb;  %%%%%%%%%%%window size

    Y=sort_results{ii};
    % Calculate constant w0
    w0 = (1 - exp(-1 / theta)) / (1 - exp(-dt / theta));
    % Calculate exponential weights w, for Pearson
    w(:, 1) = w0 * exp(((1:dt) - dt) / theta);
    % Ensure sum of weights is 1
    w = w / sum(w);
    % dt: number of observations in window; N: number of variables
    [dt, N] = size(Y);
    % Remove weighted mean
    temp = Y - repmat(w' * Y, dt, 1);
    % Weighted Covariance Matrix
    temp = temp'* (temp .* repmat(w, 1, N));
    % Must be exactly symmetric
    temp = 0.5 * (temp + temp');
    % Variances
    R = diag(temp);
    % Matrix of Weighted Correlation Coefficients
    R = temp ./ sqrt(R * R');
    fishe_Z = (1/2).*log((1+R)./(1-R)); %%%%%%fisheZ
    fishe_Z(fishe_Z==Inf) = 0;
    FCM.Matrix{ii} = fishe_Z;
    clear Y temp w0 w 
end 

save(['FCM.mat'],...
    'FCM')

