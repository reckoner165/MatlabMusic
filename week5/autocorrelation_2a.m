% autocorrelation_2a

% [stereo,fs] = audioread('guitarA.wav');
% t = 0.5*(stereo(:,1)+stereo(:,2));
% [b,a] = cheby1(9,0.7,0.2,'low');
% x = transpose(filter(b,a,t));
% subplot(2,1,1), plot(abs(fft(t))); subplot(2,1,2), plot(abs(fft(x)));

x = sin(2*pi*500/fs*[1:10*fs]);
x = transpose(x);
auto = zeros(1,fs);
for del = 0:100:fs
%     x2 = zeros(length(x)+del,1);
%     x2(del+1:end) = x(1:end);
    x2 = circshift(x,del);
%     auto(del+1) = sum(x(1:end).*x2(1:end-del));
    auto(del+1) = sum(x.*x2);
%     auto(del+1) = 5*round(auto(del+1)/5);
    if del > 1
        if auto(del+1) == auto(1)
            disp(del);
            break;
        end
    end
end


    