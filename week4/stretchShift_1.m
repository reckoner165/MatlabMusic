% Problem1 - To implement OLA, time-domain changes and pitch-shift

% Window parameters

winSize = 2^10;
hopSize = winSize/2;
winType = @hamming;
winVector = window(winType,winSize);
% Import the audio file
[x,fs] = audioread('doorsRing.wav');


%Buffer (Analysis) - Breaking down into buffers

buff = buffer(x,winSize, (winSize-hopSize),'nodelay');
numOfFrames = size(buff,2);
% Timestretch the original track by the pitch ratio
semitones = input('Enter how many semitones you want to shift the track by: ');
pitchRatio = 2^(semitones/12);
timeRatio = pitchRatio;

% %Create a big matrix with numOfFrames rows and winSize columns so you could
% %.* it with the buffer matrix you have

w = window(winType,winSize);
windows = ones(1,numOfFrames);

windows = w*windows;
buff = buff.* windows;

% Prepare output vector for synthesis
 y= round(length(x) * timeRatio) + winSize;
 y = zeros(y,1);
 
% Synthesis

for frameN = 1:numOfFrames-1
    
    frame = buff(:,frameN);
%     1(b) - The start sample at every successive iteration is randomly shifted
%     forward or backwards by a few samples
    startSample = round(hopSize*timeRatio) * (frameN) + round(20*(rand(1)-0.5));
%     disp(startSample);
    endSample = startSample + winSize - 1;
    
    y(startSample:endSample) = y(startSample:endSample) + frame;
end

%%
% 1(c) - Pitchshifting - Uses the time stretched (or) time-compressed
% output from the code thus far


% Resampling (Upsample it by the inverse ratio by which it was
% timestretched - so the file is of the same length as original, but higher
% pitch

% Since P*Q cannot be more than 2^31, we divide P by pitchRatio instead of
% multiplying Q with it. The ratio P/Q is maintained.
fs1 = round(fs/pitchRatio);
fsNew = fs;

div = gcd(fs1, fsNew);
P = fs1/div;
Q = fsNew/div;

out = resample(y, P, Q);

sound(x,fs);
pause(length(x)/fs);
sound(out,fs);

