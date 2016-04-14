% Karplus and Strong algorithm for physical modelling of plucked string

fs = 44100;


roh = 0.999;
x = [rand(1,10) zeros(1,3*fs)];
N = 300*ones(1,length(x));
n = length(x);
% alpha = 0.5;
y1 = zeros(1,n+N(1));
y2 = zeros(1,n+N(1));
gliss = -100;
N2 = [zeros(1,0.5*fs+10) [1:0.01*gliss/abs(gliss):gliss]];
N2 = [N2 gliss*ones(1,length(N)-length(N2))];
N = N+N2;

for k = 1:n
    if k<N(k)+2
        y1(k) = x(k);
        if k>1
        y2(k) = alpha*x(k)  + x(k-1) - alpha*y1(k-1);
        end
    else
        y1(k) = x(k) + 0.5*roh*(y1(k-floor(N(k))) + y1(k-floor(N(k))-1));
        alpha = (1-(N(k)-floor(N(k))))/1.5;
        y2(k) = alpha*x(k)  + y1(k-1) - alpha*y2(k-1);
    end
%     y2(k) = y1
end

sound(y2,fs);