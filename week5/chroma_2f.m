% Chroma
% Program that takes in an audio file and estimates what is the dominant
% pitch class its surrounds correspond to. 

[s,fs] = audioread('guitarA.wav'); %Guitar playing A 110Hz
x = 0.5*(s(:,1)+s(:,2)); %Stereo to mono

spec = abs(fft(x));
cFreq = (0:fs-1)/length(x)*fs; % FFT bin number to frequency

c5 = 440*2^(3/12); %Use frequency of c5 as reference

pitchNumber = round(log2(cFreq./c5).*12); % Frequency to pitch mapping

pClassVec = mod(pitchNumber,12); % Pitch to pitch class mapping

chroma = zeros(1,12); %Chroma matrix to fill in the chromatic histogram


for k = 2:length(cFreq)-1
    chroma(pClassVec(k)+1) = chroma(pClassVec(k)+1) + spec(k);
end

notes = [0 1 2 3 4 5 6 7 8 9 10 11];
m = max(chroma);

% Find dominant chromatic notes
for k = 1:length(chroma)
    if chroma(k) == m
        disp(' ');
        disp(notes(k));
        disp('semitones above C');
    end
end
% fin.