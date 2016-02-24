h = 1/3*ones(3,1);
x = randn(16,1);
N = length(x)+length(h)-1;  %the minimum pad factor
h1 = [h; zeros(N-length(h),1)];
x1 = [x ; zeros(N-length(x),1)];
out = ifft(fft(x1).*fft(h1));
yconv = conv(x,h);