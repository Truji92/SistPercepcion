function [ salida ] = knnM(inputs, outputs, vector, k)
%
%

[fil col] = size(inputs);

covMatrix = cov(inputs');
invCov = inv(covMatrix);

%vectorRep = repmat(vector, 1, col);

dist = zeros(1,col);
for i = 1:col
    dist(1,i) = (vector - inputs(:,i))' * invCov * (vector - inputs(:,i));
end

[newOrder, indexs] = sort(dist);

knearest = outputs(indexs(1:k));

salida = mode(knearest);

end

