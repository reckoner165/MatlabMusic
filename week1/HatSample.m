%HatSample.m

fs = 44100;
x = wgn(1,2*fs,1);

%Filter
[b,a] = butter(7,0.98,'low');
freqz(b,a);
hat = filter(b,a,x);
[b,a] = butter(9,0.975,'high');



%Amplify and add zero padding
hat = hat*0.45;
sample = hat(1:fs/15);
clear hat;

%Generate envelope
A = linspace(0, 0.6, (length(sample)*0.04)); %rise 20% of signal
D = linspace(0.6, 0.5,(length(sample)*0.2)); %drop of 5% of signal
S = linspace(0.5, 0.5,(length(sample)*0.3)); %delay of 40% of signal
R = linspace(0.5, 0,(length(sample)*0.3)); %drop of 35% of signal

ADSR = [A D S R] ; %make a matrix

dif = length(sample) - length(ADSR); %find out the difference

envelope = cat(2, ADSR, zeros(1,dif)); %concatenate a horrizontal (2) ADSR + the difference of ADSR and the signal
sample = sample.*envelope;
hat = sample;
audiowrite('hat1.wav',hat,fs);


