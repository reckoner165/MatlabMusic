% Karplus and Strong algorithm for physical modelling of plucked string

% Initialize wave equation parameters
fs = 44100;

roh = 0.999;
x = [rand(1,10) zeros(1,3*fs)]; %Impulse to get the string started
initDelay = 300; %Initialise delay value for the string to vibrate with
N = initDelay*ones(1,length(x));
n = length(x);

y1 = zeros(1,n+N(1));
y2 = zeros(1,n+N(1));

% Amount of pitchshift to create a glissando
gliss = 100;
N2 = [zeros(1,0.5*fs+10) ...
    [1:0.01*gliss/abs(gliss):gliss]]; %Simulate glissando by moving the delay with the sample at some point in the signal
N2 = [N2 gliss*ones(1,length(N)-length(N2))];
N = N+N2;

for k = 1:n
%     Separate integer and fractional part of the delay so that two
%     different filters can run them.
    alpha = (1-(N(k)-floor(N(k))))/1.5;
    if k<N(k)+2
        y1(k) = x(k);
        if k>1
%             All Pass Filter to simulate fractional delay
        y2(k) = alpha*x(k)  + x(k-1) - alpha*y1(k-1);
        end
    else
        y1(k) = x(k) + 0.5*roh*(y1(k-floor(N(k))) + y1(k-floor(N(k))-1));
        
        y2(k) = alpha*x(k)  + y1(k-1) - alpha*y2(k-1);
    end

end
% Play output
sound(y2,fs);