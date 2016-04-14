% Harmonic Product

% Estimates the fundamental frequency by taking advantage of octaves
% harmonies present in the musical signal. This is done by successively
% downsampling the signal by order of 2 and multiplying its DFT to the
% original signal, hence amplifying the fundamental frequency while
% attenuating its harmonics.

[x,fs] = audioread('testAudio.wav');

% Compute DFT of signal and signal downsampled by 2,4,8
y1 = abs(fft(x));
y2 = abs(fft(resample(x,fs/2,fs)));
y4 = abs(fft(resample(x,fs/4,fs)));
y8 = abs(fft(resample(x,fs/4,fs*2)));

% Adjust dimensions, lengths and multiply elements of the four harmonic signals.
k = max([length(y1) length(y2) length(y4) length(y8)]);
sum = [y1;zeros(k-length(y1),1)].*[y2;zeros(k-length(y2),1)].*[y4;zeros(k-length(y4),1)].*[y8;zeros(k-length(y8),1)];

% Plot the resulting product spectrum
plot(sum);

max = max(sum);
% Find location of the largest sample in the resulting DFT
for j = 1:length(sum)
    if sum(j) == max
        digiFreq = j/length(sum);
    end
end

% Convert to continuous frequency and display output
disp(digiFreq*fs);
clear all;