function [ y ] = bitQuantize( x,quant )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

bitVal = [0:(2^quant)-1];
bitVal = bitVal/bitVal(length(bitVal));
y = zeros(1,length(x));

% For every sample in the audio
for k = 1:length(x);
    % For every quantization value you can have for n bits
    for bit = 1:length(bitVal)-1
        
        %If a given sample value falls between two quantization values,
        %pick the higher one instead of the sample.
        if abs(x(k)) >= bitVal(bit) && abs(x(k)) <= bitVal(bit+1)
            y(k) = bitVal(bit+1)*(x(k)/abs(x(k)));
        else
            continue;
        end
        
    end
end
figure;hold on; plot(x); plot(y); hold off;
end

