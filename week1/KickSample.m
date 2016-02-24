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

%Generate envelope
A = linspace(0, 0.6, (length(sample)*0.1)); %rise 20% of signal
D = linspace(0.6, 0.5,(length(sample)*0.1)); %drop of 5% of signal
S = linspace(0.5, 0.5,(length(sample)*0.3)); %delay of 40% of signal
R = linspace(0.5, 0,(length(sample)*0.3)); %drop of 35% of signal

ADSR = [A D S R] ; %make a matrix

dif = length(sample) - length(ADSR); %find out the difference

envelope = cat(2, ADSR, zeros(1,dif)); %concatenate a horrizontal (2) ADSR + the difference of ADSR and the signal
sample = sample.*envelope;
kick = sample;
audiowrite('kick1.wav',kick,fs);


