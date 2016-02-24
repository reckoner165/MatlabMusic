% sequencer.m
fs = 44100;
bpm = 140;
notesPerMeasure = 4;
kickRead = audioread('kick1.wav');
snareRead = audioread('snare1.wav');
hatRead = audioread('hat1.wav');
%Creating quantized empty spaces for the notes to get in
blank = zeros(1,60/(bpm*notesPerMeasure)*fs);

%Padding drum samples with zeros to work with the quantization
if length(kickRead) > length(blank)
    kick = kickRead(1:length(blank));
else
    kick = [kickRead; zeros(length(blank)-length(kickRead),1)];
end
kick = transpose(kick);

if length(snareRead) > length(blank)
    snare = snareRead(1:length(blank));
else
    snare = [snareRead; zeros(length(blank)-length(snareRead),1)];
end
snare = transpose(snare);

if length(hatRead) > length(blank)
    hat = hatRead(1:length(blank));
else
    hat = [hatRead; zeros(length(blank)-length(hatRead),1)];
end
hat = transpose(hat);
velpad = ones(1,length(blank));

%Actual sequencing
beat1 = [kick blank kick blank snare blank blank blank];
beat2 = [blank blank kick blank snare blank blank blank];
beat3 = [kick blank blank blank snare blank blank blank];
beat4 = [blank kick blank blank snare kick blank snare];
hatline = [hat hat hat hat hat hat hat hat];
hatVelocity = [0.2*velpad 0.3*velpad 0.3*velpad 0.1*velpad 0.2*velpad 0.3*velpad 0.3*velpad 0.2*velpad];
hatline = hatline.*hatVelocity;
beat = [beat1 beat2 beat3 beat4];
beat = beat+[hatline hatline hatline hatline];

%Export
audiowrite('beat.wav',beat,fs);
