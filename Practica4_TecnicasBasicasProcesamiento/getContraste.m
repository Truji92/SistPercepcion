function [C] = getContraste( I)
%GETCONTRASTE Summary of this function goes here
%   Detailed explanation goes here

hist = imhist(I);
levels = [0:255]';


B = sum(hist.*levels) / sum(hist);

C = sqrt(sum(hist.*(levels-B).^2) / sum(hist));


end

