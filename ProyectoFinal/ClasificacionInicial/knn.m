function [ salida ] = knn(inputs, outputs, vector, k)
%
%

[fil col] = size(inputs);

%vectorRep = repmat(vector, 1, col);

dist = zeros(1,col);
for i = 1:col
    dist(1,i) = distanciaE(inputs(:,i)', vector');
end

[newOrder, indexs] = sort(dist);

knearest = outputs(indexs(1:k));

[salida veces] = mode(knearest);
if veces == 1
    salida = knearest(1);
end

