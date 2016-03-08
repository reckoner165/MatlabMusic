function [ y ] = bitQuantize( x,quant )
%bitQuantize Quantizes a given audio file to values within given number of
%bits
% Arguments:
% x - the input audio file
% quant - number of bits by which the audio needs to be quantized
%%

%Create a vector of all possible values with the given no. of bits
bitVal = [0:(2^quant)-1];
bitVal = bitVal/bitVal(length(bitVal)); % Normalize them
y = zeros(1,length(x));

% For every sample in the audio
for k = 1:length(x);
    % For every quantization value you can have
    for bit = 1:length(bitVal)-1
        
        %If a given sample value falls between two quantization values,
        %pick the higher one instead of the sample itself.
        if abs(x(k)) >= bitVal(bit) && abs(x(k)) <= bitVal(bit+1)
            y(k) = bitVal(bit+1)*(x(k)/abs(x(k)));
        else
            continue;
        end
        
    end
end
% figure;hold on; plot(x); plot(y); hold off;
end

