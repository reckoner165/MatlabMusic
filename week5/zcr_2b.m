% Zero Crossing Detection

% Program that counts the number of zero crosses in each window of an audio file and
% uses that to estimate the fundamental frequency in that window. Time and
% frequency resolution varies with window size. 

[x, fs] = audioread('testAudio.wav');

% Split the file into windows with no overlaps (hence hopsize = windowsize)
winSize = 2^10;
hopSize = winSize;

% Preparing the buffer matrix
buff = buffer(x,winSize, (winSize-hopSize),'nodelay');
numOfFrames = size(buff,2); 

% For each frame 
for j = 1:numOfFrames
    
    count = 1;
    for k = 2:winSize
        % Look for zero crossing in each frame and increase a counter
        % variable everytime you find one
        
%         This could be either when consecutive values have opposite sign
        if (buff(k,j)*buff(k-1,j))/abs((buff(k,j)*buff(k-1,j))) == -1
            count = count+1;
%             Or when a sample itself has zero value
        elseif buff(k,j) == 0
            count = count+1;
        end
    end
%     Number of cycles in that window
    cyclesPerWin = count/2;
%     Convert it to number of cycles per second (frequency!)
    freq = fs*cyclesPerWin/winSize;
%     Create an array of frequencies for each window
    freqArray(j) = freq;
end
plot(freqArray); ylabel('Frequency'); xlabel('Window');
% fin.
% You could output the mean of freqArray to get the average frequency
% throughout the sound file.

        
    