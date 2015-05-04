function [otsu] = funcion_otsu(I)
%FUNCION_OTSU Summary of this function goes here
%   Detailed explanation goes here

hist = imhist(I);
B = getBrillo(I);
total = sum(hist);

means = zeros(length(hist),2);
probs = means;

for i = 1:255
    low = hist(1:i);
    sumlow = sum(low);
    high = hist(i+1:end);
    sumhigh = sum(high);
    
    if (sumlow == 0)
        means(i,1) = 0;
    else 
        means(i,1) = sum(low.*[0:i-1]')/sumlow;
    end    
    
    if (sumhigh == 0)
        means(i,2) = 0;
    else
        means(i,2) = sum(high.*[i:255]')/sumhigh;
    end
    %means(i,:) = [sum(low.*[0:i-1]')/sumlow; sum(high.*[i:255]')/sumhigh]; 
    probs(i,:) = [sum(I(:)<i)/total; sum(I(:)>=i)/total];
end

vars = probs(:,1).*(means(:,1) - B).^2 + probs(:,2).*(means(:,2) - B).^2;

otsu = find(max(vars) == vars) - 1;

end

