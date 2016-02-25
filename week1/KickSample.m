fs = 44100;
x = wgn(1,2*fs,1);

%Filter
[b,a] = butter(5,0.007,'low');
freqz(b,a);
kick = filter(b,a,x);
[b,a] = butter(8,0.008,'low');

%Amplify and add zero padding
kick = kick*7;
sample = kick;
sample = kick(1:fs/9);
clear kick;

%Generate envelope using linearly spaced vectors
A = linspace(0, 0.6, (length(sample)*0.1)); %Attack
D = linspace(0.6, 0.5,(length(sample)*0.1)); %Decay
S = linspace(0.5, 0.5,(length(sample)*0.3)); %Delay/Sustain
R = linspace(0.5, 0,(length(sample)*0.3)); %Release

ADSR = [A D S R] ; %make a matrix

dif = length(sample) - length(ADSR); %find out the difference

envelope = cat(2, ADSR, zeros(1,dif)); %Zero pad the envelope
sample = sample.*envelope; %Apply the envelope
kick = sample;
audiowrite('kick1.wav',kick,fs);


