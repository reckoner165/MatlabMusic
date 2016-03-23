% allPassDelay
function [ y ] = allPassDelay_2( x,delayms,depthms,LFreq,fs )
%Chorus Creates a chorus effect on the audio sample using variable
%fractional delay

%   Arguments:
% x - Input Sample (should be mono)
% Delayms - Delay period in ms
% Depthms - Chorus depth, or amount of variation in delay in ms
% Lfreq - LFO frequency in Hz
% fs - Sampling Rate

% NOTES:
% Take the floor value of the number of samples
% make an integer delay for that much
% use the remaining fractional value (delay-floor(delay)) and use it to
% compute the alpha (refer the graph in the question for this)
% Use this alpha to create an all pass, and pass the intDelay output into
% it 


%%
% Converting all arguments to sample units
depth = depthms*fs/1000;
delay = delayms*fs/1000;
LF = LFreq/fs;

%Zero padding the input audio file to account for delay
xpad = [x; zeros(ceil(delay+depth),1)];
yOut = zeros(length(xpad),1);
y = zeros(length(xpad),1);

%Since filter function cannot do this, construct the difference equation and
%add the delayed samples to the input samples to get the output

%Fractional Noise
for n = 1:length(xpad)
    chorus = delay + floor(depth*sin(2*pi*LF*n));
    chorFloat = chorus - floor(chorus);
    coeff = (1-chorFloat)/1.5;
    if n > chorus
        
        yOut(n) = xpad(n)+0.8*yOut(n-floor(chorus));
        y(n) = coeff*y(n)+yOut(n-1)-coeff*y(n-1);
    else
        yOut(n) = xpad(n);
    end
end

end





