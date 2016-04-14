% Etude
fs = 44100; 
out = zeros(1,fs);
% Notes
p = [0 2 3 5 6 7 9 10 12 14 15 17 18 19 22 24 -2 -3 -5];
q = 3*ones(1,length(p))+p;
p = [p;q];
r = 3*ones(1,length(q))+q;
p = [p;r];
A = 110;
fretVec  = p;
% TODO
% 1.Get more notes into the etude. Build more scales/modes as arrays to
% pick notes from.
% 2.Add details for the body
% 3.Definitely add varying delay and reverb

% for x = 1:length(fretVec)
%     delayVec(x) = round(fs/(A*2.^(fretVec(x)/12)));
% end

% Plays notes in succession
for chord = 1:3
    for loop = 1:40

        fret  = p(chord,max(floor(20*rand(1)),1));
        delay = round(fs/(A*2.^(fret/12)));


        % Karplus Plucking thing
        roh = 0.995;
        x = [rand(1,10) zeros(1,fs-10)];
        n = length(x);


        N = delay;
        y1 = zeros(1,n+N);
        y2 = zeros(1,n+N);

        for k = 1:n
            if k<N+2
                y1(k) = x(k);
                if k>1
    %             y2(k) = alpha*x(k)  + x(k-1) - alpha*y1(k-1);
                end
            else
                y1(k) = x(k) + 0.5*roh*((y1(k-floor(N))) + y1(k-floor(N)-1));
    %             alpha = (1-(N-floor(N)))/1.5;
    %             y2(k) = alpha*x(k)  + y1(k-1) - alpha*y2(k-1);
            end
        %     y2(k) = y1
        end

        sound(y1,fs);
        pause(0.5/chord);
        blank = fs*(1-0.5/chord);
        out =  [out(1:end-blank) out(end-blank+1:end)+y1(1:blank) y1(blank+1:end)];
%         out = 
    end
end

audiowrite('output.wav',out,fs);
% Reverb?


% Variable Delay that goes crazy

