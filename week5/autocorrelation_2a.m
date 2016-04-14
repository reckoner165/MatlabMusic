% autocorrelation_2a

% Estimate frequency by autocorrelating it at various sample-delays and
% looking for recurrent peaks which correspond to the fundamental frequency
% of the signal.

% Initialize values
[x fs] = audioread('testAudio.wav');
auto = zeros(1,fs/10);
for del = 0:1:fs/10
%     Prepare shifted signal
    x2 = circshift(x,del);
    x2(1:del) = zeros(del,1);

    auto(del+1) = sum(x.*x2);

end
% Detect Peaks and their locations *besides* the first
[peak, loc] = findpeaks(auto(2:end));

% Find the peak with greatest energy and get its location
for j = 1:length(peak)
    if peak(j) == max(peak)
%         disp(j)
        samp = loc(j);
       
        break;
    end
end
% Display frequency corresponding to this sample delay
disp(fs/samp);



    