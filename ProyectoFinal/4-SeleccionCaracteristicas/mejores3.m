function [caracteristicasSeleccionadas, separabilidad] = mejores3(inputs, outputs, clases)
%MEJORES3 Summary of this function goes here
%   Detailed explanation goes here

[numeroDescriptores, col] = size(inputs);

%Cogemos indices de las clases que nos interesan
indexs = find(ismember(outputs, clases));
filteredInputs = inputs(:, indexs);
filteredOutputs = outputs(:, indexs);

separabilidad = [];
for i = 1:numeroDescriptores
    J = indiceJ(filteredInputs(i,:), filteredOutputs);
    separabilidad = [separabilidad; J];
end

[nuevoOrden, indexsOrd] = sort(separabilidad, 'descend');

carPreSeleccionadas = 6;

indexs6 = indexsOrd(1:carPreSeleccionadas);

numeroCaracteristicasFinal = 3;
combinaciones = combnk(indexs6, numeroCaracteristicasFinal);

[fil col] = size(combinaciones);

separabilidadComb = zeros(fil, 1);
for i = 1:fil 
    subInputs = filteredInputs(combinaciones(i,:), :);
    Jconjunta = indiceJ(subInputs, filteredOutputs);
    separabilidadComb(i) = Jconjunta;
end

[sepMax, indexMax] = max(separabilidadComb);

caracteristicasSeleccionadas = combinaciones(indexMax, :); 

separabilidad = sepMax;




end

