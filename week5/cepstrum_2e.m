% Cepstrum 


% Import audio file (guitar sample that plays  A 110Hz)
[s,fs] = audioread('guitarA.wav'); 
x = 0.5*(s(:,1)+s(:,2));

% Set optimum frequency search range that is relevant to the audio sample
f1 = 50; f2 = 2700;
% Calculate the cepstrum
cepstrum = abs(ifft(real(log(fft(x)))));
% Consider only the cepstrum parts that are within the search range
cepsearch = cepstrum(round(fs/f2):round(fs/f1));
plot(cepsearch);
ylabel('energy'); xlabel('quefrency'); %DEBUG

len = length(cepsearch);
m = max(cepsearch);
% Look for earliest peak and its location
for i = 1:len
    if cepstrum(i) == m
        disp(fs/(i+(fs/f2)))
        break;
    end
end
