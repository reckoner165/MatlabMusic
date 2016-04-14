% cd to week1 and run sequencer.m

%Basic parameters required for sequencing
fs = 44100;
bpm = 92;
notesPerMeasure = 4;
blank = zeros(1,floor(60/(bpm*notesPerMeasure)*fs));
dur = length(blank)/fs;

adsr = [0.4 0.1 0.2 0.3];
% melody1 = [freqMod(233.08/2,300,1,adsr,5,dur) freqMod(440/2,300,0.1,adsr,10,dur) freqMod(587.33/2,300,0.1,adsr,10,dur) freqMod(698.46/2,300,0.1,adsr,10,dur)];
% melody2 = [freqMod(277.18/2,300,1,adsr,5,dur) freqMod(523.25/2,300,0.1,adsr,10,dur) freqMod(698.46/2,300,0.1,adsr,10,dur) freqMod(830.61/2,300,0.1,adsr,10,dur)];
% melody3 = [freqMod(207.6/2,400,1,adsr,5,dur) freqMod(392/2,300,0.1,adsr,10,dur) freqMod(554.37/2,300,0.1,adsr,10,dur) freqMod(698.46/2,300,0.1,adsr,10,dur)];

melody4 = [freqMod(138.59*2,500,1,adsr,5,dur) freqMod(110*2,300,0.1,adsr,10,dur) freqMod(138.59*2,300,0.1,adsr,10,dur) freqMod(164.81*2,300,0.1,adsr,10,dur)];
melody5 = [freqMod(164.81*2,500,1,adsr,5,dur) freqMod(130.81*2,300,0.1,adsr,10,dur) freqMod(164.81*2,300,0.1,adsr,10,dur) freqMod(196.00*2,300,0.1,adsr,10,dur)];

melody6 = [freqMod(880*2,30,1,adsr,0.5,24*dur) freqMod(783.99*2,30,1,adsr,0.7,8*dur) freqMod(659.25*2,300,1,adsr,1,32*dur)];
melody7 = [freqMod(880*2,30,1,adsr,0.5,24*dur) freqMod(783.99*2,30,1,adsr,0.7,8*dur) freqMod(987.77*2,300,1,adsr,1,32*dur)];


melody = [melody1 melody1 melody1 melody1 melody1 melody1 melody2 melody2];
melody = [melody melody1 melody1 melody1 melody1 melody1 melody1 melody3 melody3];

music = 2.5*[hw_track; hw_track]+0.5*transpose([melody; melody]);

% cd to week2 
comp(2,:) = compressAudio(0.1,0.5,music(:,2));
comp(1,:) = compressAudio(0.2,0.6,music(:,1));
soundsc(comp*0.6,fs)

chor(:,1) = intChorus(transpose(comp(1,:)),10,5,10,44100);
chor(:,2) = intChorus(transpose(comp(2,:)),10,5,10,44100);

newOut = 0.9*chor + [comp;zeros(length(chor)-length(comp),2)];

comp2(2,:) = compressAudio(0.1,0.5,newOut(:,2));
comp2(1,:) = compressAudio(0.2,0.6,newOut(:,1));

audiowrite('newOut.wav',(1/max(max(comp2)))*(transpose(comp2))*0.5,fs)