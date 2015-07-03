function [ salida ] = ClasificadorMinEuclidea( inputs, outputs, vector )
%CLASIFICADORMINEUCLIDEA Summary of this function goes here
%   Detailed explanation goes here

clases = unique(outputs);

[descriptores, elementos] = size(inputs);

covMatrix = cov(inputs');
invCov = inv(covMatrix);

puntosRepresentativos = zeros(descriptores, length(clases));

for i=1:length(clases)
   class = clases(i);
   
   points = inputs(:, find(outputs == class));
   
   puntosRepresentativos(:, i) = mean(points')';
    
end

distancias = zeros(1, length(clases));
for i = 1:length(clases)
    distancias(i) = sqrt( (puntosRepresentativos(:,i) - vector)' * invCov * (puntosRepresentativos(:,i) - vector) );
end

[dist indexMin] = min(distancias);

salida = clases(indexMin);


end

