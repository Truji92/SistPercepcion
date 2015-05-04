function [ B ] = getBrillo(I)
%GETBRILLO Summary of this function goes here
%   Detailed explanation goes here

hist = imhist(I);
levels = [0:255]';



B = sum(hist.*levels) / sum(hist);

end

