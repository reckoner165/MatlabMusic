winSize = 2^10;
hopSize = winSize/2;
winType = @hamming;
winVector = window(winType,winSize);
% y = zeros(length(x));
% 
% [x,fs] = audioread('../audio/BeatlesHelpMono.wav');
% 
% for n = 1:hopSize:length(x)-winSize
% %     Analysis
%     win = x(n:n+winSize-1);
%     win = win.*winVector;
%     
% %     Synthesis
%     y(n:n+winSize-1) = y(n:n+winSize-1) + win;
% end

%Buffer

buff = buffer(x,winSize, (winSize-hopSize),'nodelay');
numOfFrames = size(buff,2);
timeRatio = 1.0;

% %Create a big matrix with numOfFrames rows and winSize columns so you could
% %.* it with the buffer matrix you have
w = window(winType,winSize);
windows = ones(1,numOfFrames);

windows = w*windows;

buff = buff.* windows;

 y= round(length(x) * timeRatio) + winSize;
 y = zeros(1,y);
 

% Synthesis

for frameN = 1:numOfFrames
    
    frame = buff(:,frameN);
    startSample = round(hopSize*timeRatio) * (frameN - 1) + 1;
    endSample = startSample + winSize - 1;
    
    y(startSample:endSample) = y(startSample:endSample) + frame;
end


