% %Delay
% 
% y(n) = x(n) + feedback*y(n-delay);
% y(n) - feedback*y(n-delay) = x(n);
% Y - feedback*Y*(Z^-delay) = X
% Y(1 - feedback*(z^-delay)) = X
% H = 1/(1-feedback*(z^-delay));

%Creating delay filter coefficients
delayms = input('Enter delay in ms: ');
feedback = input('Enter normalized feedback: ');
fs = 44100;
delay = delayms*fs/1000;
B = zeros(1,delay+1);
A = zeros(1,delay+1);
B(1) = 1;
A(1) = 1;
A(end) = -feedback;

y = filter(B,A,x);



