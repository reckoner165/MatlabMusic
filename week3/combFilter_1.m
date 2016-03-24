%  COMB FILTER REVERB
%  Script that imitates the reverb effect using a combination of comb
%  filters and all pass delay filters. 

% NOTES
% Prepare four comb resonators, pass the same input through them and add
% the four outputs up
% Pass this sum into two cascaded all pass filters and get the final output

%%
fs = 44100;
% Initializing delay values for the comb resonators and all-pass
del1 = int64(round(29.7*fs/1000));
del2 = int64(round(320.1*fs/1000));
del3 = int64(round(241.1*fs/1000));
del4 = int64(round(153.7*fs/1000));
refLen1 = int64(round(5*fs/1000)); 
refLen2 = int64(round(1.7*fs/1000)); 

% Initializing filter coefficients 
a1 = zeros(1,del1); a1(1) = 1; a1(end) = 0.9;
a2 = zeros(1,del2); a2(1) = 1; a2(end) = 0.96;
a3 = zeros(1,del3); a3(1) = 1; a3(end) = 0.8;
a4 = zeros(1,del4); a4(1) = 1; a4(end) = 0.6;

b1 = zeros(1,del1); b1(1) = 1; 
b2 = zeros(1,del2); b2(1) = 1; 
b3 = zeros(1,del3); b3(1) = 1; 
b4 = zeros(1,del4); b4(1) = 1; 

% x = audioread('hwTrack.wav');
x = music;
% Applying the input through 4 comb resonators in parallel

y1 = filter(b1,a1,x);
y2 = filter(b2,a2,x);
y3 = filter(b3,a3,x);
y4 = filter(b4,a4,x);

% Zero pad the four outputs and then add them up in equal proportions
k = max([length(y1) length(y2) length(y3) length(4)]);

y1 = [y1;zeros(k-length(y1),1)];
y2 = [y1;zeros(k-length(y2),1)];
y3 = [y1;zeros(k-length(y3),1)];
y4 = [y1;zeros(k-length(y4),1)];

yPar = 0.25*(y1 + y2 + y3 + y4);

% All pass filter coefficients

coeff = 0.9; % the all pass coefficient
% All pass filter1
allpassB1 = [coeff zeros(1, refLen1) 1];
allpassA1 = [1 zeros(1, refLen1) coeff];

%All pass filter2
allpassB2 = [coeff zeros(1, refLen1) 1];
allpassA2 = [1 zeros(1, refLen1) coeff];

yAllP1 = filter(allpassB1,allpassA1,yPar);
yAllP2 = filter(allpassB2,allpassA2,yAllP1);
yAllP2 = yAllP2/max(yAllP2);
k = length(yAllP2);

%Get a dry-wet combination for the output
xPad = [x;zeros(k-length(x),1)];
xPad = xPad/max(xPad);

dryWet = (0.6*xPad)+(0.4*yAllP2);

%fin.

%% QUESTION
% Why do you think the multiple comb filters and all-pass filter improve the basic
% reverb algorithm ? simply using the all-pass filters? Explain.

% The comb filters can be used to model the distance of each wall, hence
% adding more reverb characteristics specific to the dimensios and response
% of a room