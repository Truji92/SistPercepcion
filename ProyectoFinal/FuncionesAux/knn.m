function [ salida ] = knn(inputs, outputs, vector, k)
%
%

[fil col] = size(inputs);

%vectorRep = repmat(vector, 1, col);

dist = zeros(1,col);
for i = 1:col
    dist(1,i) = distanciaE(inputs(:,i)', vector');
end

[newOrder, indexs] = sort(dist, 'ascend');

knearest = indexs(1:k);

prob = tabulate(outputs(1, knearest));

% 
% vecinos = zeros(k);
% for i = 1:k
%     v = find(dist==min(dist));
%     dist(v) = max(dist);
%     vecinos(i) = v;
% end
% 
% outs = outputs(1,vecinos(1:k));
% prob = tabulate(outs);

etiqueta =prob(find(prob(:,3)==max(prob(:,3))),1);
salida = etiqueta(1);
end

