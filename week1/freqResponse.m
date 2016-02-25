index = 1;
%frequency range
for w = 0:pi/64:pi;
    z = exp(1i*w);
    H(index) = 1/(1-0.96*z^-10); %z-transform of the input equation
    index = index + 1;
end
w = 0:pi/64:pi;
figure;
plot((w/pi),mag2db(abs(H)))

    
    





    






