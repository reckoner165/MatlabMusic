%HatSample.m

fs = 44100;
x = wgn(1,2*fs,1);

%Filter

%Code For hat1.wav. Commented out to make hat2.wav
% [b,a] = butter(9,0.997,'low');
% freqz(b,a);

hat = x;
% hat = filter(b,a,x);
[b,a] = butter(5,0.7,'high');
hat = filter(b,a,hat);

%Amplify and add zero padding
hat = hat*0.65;
sample = hat(1:fs/15);
clear hat;

%Generate envelope
A = linspace(0, 0.6, (length(sample)*0.04)); %Attack
D = linspace(0.6, 0.5,(length(sample)*0.2)); %Decay
S = linspace(0.5, 0.5,(length(sample)*0.3)); %Sustain
R = linspace(0.5, 0,(length(sample)*0.3)); %Release

ADSR = [A D S R] ; %make a matrix

dif = length(sample) - length(ADSR); %find out the difference

envelope = cat(2, ADSR, zeros(1,dif)); %Zero Padding
sample = sample.*envelope;
hat = sample;
audiowrite('hat2.wav',hat,fs);


