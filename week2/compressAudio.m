function [ y ] = compressAudio(threshold, gain, x, gainmatch)

%compressAudio A function demonstrating basic functions of dynamic range
%compression for audio
% Arguments: 
% Threshold -  Threshold value after which compressor must kick in
% Gain - controls the gain ratio if audio crosses threshold (0.5 to 1)
% x - input MONO audio as a vector
% OPTIONAL - gainmatch: accepts y to enable gainmatch. 
%%


y = zeros(1,length(x));
if gain > 1 || gain < 0.5
    disp('Error: Enter gain values between 0.5 and 1.');
    disp('Returning zeros as output');
    return;
end

%Main compressor algorithm - employs a linear slope less than 1 to reduce
%gain on samples with absolute values greater than the threshold
for k = 1:length(x)
    if abs(x(k)) <= (threshold)
        y(k) = x(k);
%     elseif abs(x(k)) >= (threshold-0.15) && abs(x(k)) <= (threshold+0.15)
%         y(k) = 1.2*gain*x(k);
    else
        y(k) = gain*x(k);
    end
end

%Checks for optional gainmatching argument
if nargin < 4
    return;
else
    if gainmatch == 'y'
        figure; hold on; 
        plot(x);
        plot(y);
        hold off;
    else
        disp('Invalid argument. Enter y as argument to enable gainmatch plot');
        return;
    end
end   

end

