% Moving Average 

% [stereo,fs] = audioread('../audio/NilsMono.wav');
mono = stereo;

% x(1:10) = mono(1:10);
% for p = 11:length(mono)-10;
%     x(p) = mean(mono(p-10:p+10));
% end
% x = [x; mono(end-25:end)];
fs = 44100;
x = sin(2*pi*500/fs*[1:10*fs]);
x = transpose(x);
% [x,fs] = audioread('../audio/RadioheadPAMono.wav');
winSize = 2^10;
hopSize = winSize;

%Buffer (Analysis) - Breaking down into buffers
buff = buffer(x,winSize, (winSize-hopSize),'nodelay');
buff = transpose(buff);
numOfFrames = size(buff,1);
% zcr = 1;
for j = 1:numOfFrames
%     zcr = 1;
    count = 1;
    for k = 2:winSize
        if (buff(j,k)*buff(j,k-1))/abs((buff(j,k)*buff(j,k-1))) == -1
            count = count+1;
        end
        
    end
%     blah = 1111;
    freq(j) = (fs/(2*count));
%     zcr(j) = count;
end
% Plot the change in frequency throughout the song with the song waveform
% itself for reference (Note that there are spikes during the transients)
% subplot(2,1,1), plot(freq); subplot(2,1,2), plot(x); 

            
    