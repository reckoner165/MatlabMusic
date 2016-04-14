% inverseComb Filtering

% Method to estimate fundamental frequency by applying inverse comb filter
% of various delay lengths and looking for te output with least energy,
% which occurs when the filter inverse-notches perfectly attenuate the
% harmonics.

[x,fs] = audioread('testAudio.wav');

% For various delay values (L), apply the comb filter
for L = 1:fs/100
    for k = 1:length(x)
        if k>L
            y(k) = x(k) - 0.9*x(k-L);
        else
            y(k) = x(k);
        end
        
    end
%     Calculate the energy of the output signal for each comb filter delay
    energy(L) = mean(abs(y.*y));
    clear y;
end
plot(energy);
% Look for the point with minimum energy and calculate fundamental
% frequency from there.
for L = 2:length(energy)
    if energy(L) == min(energy(2:end))
        disp(fs/L)
        break;
    end
end
% fin.