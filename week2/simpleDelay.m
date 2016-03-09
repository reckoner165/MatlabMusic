function [ y ] = simpleDelay( delayms,feedback,x,fs )
%simpleDelay Performs a simple delay operation on the input audio file
%   Arguments:
% Delay - Delay time in ms
% Feedback - Forward feedback, affecting how long the delay effect lasts
% x - The input audio file (should be mono) 
% fs - Sampling rate of the audio

%MATH
% y(n) = x(n) + feedback*y(n-delay);
% y(n) - feedback*y(n-delay) = x(n);
% Y - feedback*Y*(Z^-delay) = X
% Y(1 - feedback*(z^-delay)) = X
% H = 1/(1-feedback*(z^-delay));
%%
delay = delayms*fs/1000;
%Building filter coefficients
B = zeros(1,delay+1);
A = zeros(1,delay+1);
B(1) = 1;
A(1) = 1;
A(end) = -feedback;

%Applying the filter
y = filter(B,A,x);

end

