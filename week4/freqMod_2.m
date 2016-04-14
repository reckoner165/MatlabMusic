function [ y ] = freqMod_2( fc,fm,modIndex,env,modEnv,dur )
% Function that runs Chowning's FM algorithm over a sinetone

% ARGUMENTS
% Carrier Frequency - The frequency of the wave that's *being* modulated
% Modulating Freq - Frequency by which carrier freq will swing up and down
% Modulation Index - Extent by which the career freq will swing up and down
% Mod Envelope - an exponential decay envelope
% Amplitude Envelope - [A D S R] each value is given in fraction of 
% dur - Duration of the waveform in seconds

% Example
%  y = freqMod_2(440,100,1,[0.1 0.1 0.6 0.2],2.5,2);
%%

% Initialize duration and output vector
fs = 44100;
n = dur*fs;
y = zeros(1,n);

% Check if env vector is in [A D S R] format and if they all add up to a
% value less than 1.
if length(env) == 4 && sum(env) <= 1
    for k = 1:n
%         Modulation index as a function of its envelope
        delF = modIndex*exp(-modEnv*k/fs);
%         Prepare the phase component that actually causes modulation
        phase = delF*sin(2*pi*fm*k/fs);
%         Modulate
        y(k) = cos((2*pi*((fc/fs)*k))+phase);
    end
    
%     Amplitude Envelope Generation
    %Generate envelope using linearly spaced vectors
    A = linspace(0, 0.6, (n*env(1))); %Attack
    D = linspace(0.6, 0.5,(n*env(2))); %Decay
    S = linspace(0.5, 0.5,(n*env(3))); %Delay/Sustain
    R = linspace(0.5, 0,(n*env(4))); %Release

    ADSR = [A D S R] ; %make an envelope vector
    dif = k - length(ADSR); %find out the difference
    envelope = cat(2, ADSR, zeros(1,dif)); %Zero pad the envelope

    y = y.*envelope; %Apply the envelope
    
else
    disp('env is invalid. Provide in [A D S R] such that they all add up to 1');
end

end

