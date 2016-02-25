% sequencer.m
%A crude step sequencer that can create and export stereo drum sequences
%for a given tempo and quantization. 

%Basic parameters required for sequencing
fs = 44100;
bpm = 140;
notesPerMeasure = 4;

%Import samples
kickRead = audioread('kick1.wav');
snareRead = audioread('snare1.wav');
hatRead = audioread('hat1.wav');
hat2Read = audioread('hat2.wav');

%Creating quantized empty spaces for the notes to get in
blank = zeros(1,60/(bpm*notesPerMeasure)*fs);

%Padding drum samples with zeros to work with the quantization 
%Done in a case-wise fashion. Can be optimized.
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

if length(hat2Read) > length(blank)
    hat2 = hat2Read(1:length(blank));
else
    hat2 = [hat2Read; zeros(length(blank)-length(hat2Read),1)];
end
hat2 = transpose(hat2);
velpad = ones(1,length(blank));

%Actual sequencing of notes. To keep up with the quantization, 'blank' notes
%must be added.
beat1 = [kick blank kick blank snare blank blank blank];
beat2 = [blank blank kick blank snare blank blank blank];
beat3 = [kick blank blank blank snare blank blank blank];
beat4 = [blank kick blank blank snare kick blank snare];
hatline = [hat hat hat hat blank hat hat hat];
hat2line = [hat2 blank blank hat2 blank blank hat2 blank];

%Add velocity function to multimply the hat with
hatVelocity = [0.2*velpad 0.3*velpad 0.3*velpad 0.1*velpad 0.2*velpad 0.3*velpad 0.3*velpad 0.2*velpad];
hatline = hatline.*hatVelocity*0.8;
beat = [beat1 beat2 beat3 beat4];

%Create two channels of beats for a stereo sound
beatL = beat+[hatline hatline hatline hatline];
beatR = beat+([hat2line hat2line hat2line hat2line]*1.2)+(0.1*fliplr(beat));
stereo = [beatL beatL beatL (beat+fliplr([beat2 beat3 beat4 beat1])); beatR beatR beatR beatR];
stereo2 = transpose(fliplr(stereo));
stereo = transpose(stereo);

%Export
audiowrite('beat.wav',stereo,fs);
audiowrite('reverseBeat.wav',stereo2,fs);
