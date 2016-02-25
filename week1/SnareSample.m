%SnareSample.m

fs = 44100;
x = wgn(1,2*fs,1);

%Filter (custom combo of low and high pass to suit the snare sound)
[b,a] = butter(9,0.2,'low');
freqz(b,a);
snare = filter(b,a,x);
[b,a] = butter(8,0.07,'high');

%Amplify and add zero padding
snare = snare*0.7;
sample = snare(1:fs/9);
clear snare;

%Generate envelope using linearly spaced vectors
A = linspace(0, 0.6, (length(sample)*0.04)); %Attack
D = linspace(0.6, 0.5,(length(sample)*0.2)); %Decay
S = linspace(0.5, 0.5,(length(sample)*0.3)); %Delay/Sustain
R = linspace(0.5, 0,(length(sample)*0.3)); %Release

ADSR = [A D S R] ; %make a matrix

dif = length(sample) - length(ADSR); %find out the difference

envelope = cat(2, ADSR, zeros(1,dif)); %Zero pad the envelope
sample = sample.*envelope; %Apply the envelope
snare = sample;
audiowrite('snare1.wav',snare,fs);


