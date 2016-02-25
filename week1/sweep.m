%sweep.m

fs = 44100;
% f = 0;
% fInc = 100;

for f = 0:100:80000
    x = sin(2*pi*[0:100]*f/fs);
    trans = fft(x,1024); %compute fft of that sine signal
    drawnow;
    
    plot(abs(trans)); %plot the magnitude of fft 
    title([num2str(f) 'hz, bin=' num2str(round(1024*f/fs)) ', ' num2str((f/fs)) 'pi rad/s']);
end

