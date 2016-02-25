p = audioread('doors.mp3');
h = 0.5*(p(:,1)+p(:,2));
% array = cumsum(ones(16,1));
x = [cos(200*(0:1)) zeros(1,496)];
x = transpose(x);
N = length(x)+length(h)-1;  %the minimum pad factor
h1 = [h; zeros(N-length(h),1)];
x1 = [x ; zeros(N-length(x),1)];
out = ifft(fft(x1).*fft(h1));
yconv = conv(x,h);
audiowrite('out.wav',out,44100);
subplot(3,1,1), plot(h); subplot(3,1,2), plot(out); subplot(3,1,3), plot(out-[h; zeros(length(out)-length(h),1)]);
% plot(out-yconv);