clc; clear;
load('../2-ClasificacionInicial/resultadosTest.mat');
path(path, '../FuncionesAux');

[fil, col] = size(resultado);

salidasReales = repmat(ConjuntoSalidasReales, fil, 1);

matrizFallos = salidasReales ~= resultado;

sumaDeFallos = sum(matrizFallos')';

kaux = [ks';ks'];

% k | fallos   primero knn y luego knnM
tablaFallos = [kaux, sumaDeFallos];

%%% Seleccion K
k = kaux(find(sumaDeFallos == min(sumaDeFallos),1));
if find(sumaDeFallos == min(sumaDeFallos),1) <= length(ks)
    tipo = 0; % 0->knn 1->knnM
else 
    tipo = 1;
end
%%%

salidasDeClasificacionElegida = resultado(tipo*length(ks)+find(ks == k,1,'first'),:);
fallos = matrizFallos(tipo*length(ks)+find(ks == k,1,'first'),:);

indexsFallos = find(fallos);
clasesConflictoNum = [ ConjuntoSalidasReales(indexsFallos)', salidasDeClasificacionElegida(indexsFallos)'];
clasesConflictoChar = letras(clasesConflictoNum);

clasesConflictoNum = unique(clasesConflictoNum,'rows');


%%%%%pruebas
[f,c] = size(clasesConflictoNum);
grupos = zeros(f,f*2);
groupindex = 1;

for i=1:f
   conflicto = clasesConflictoNum(i,:);
   grupos(groupindex,[1,2]) = conflicto;
   for j=i:f
       if sum(ismember(clasesConflictoNum(j,:), conflicto)) ~= 0
           m = 2;
           while(grupos(groupindex, m) ~= 0)
               m = m+1;
           end
           grupos(groupindex, [m,m+1]) = clasesConflictoNum(j,:);
       end
   end
   groupindex = groupindex + 1;
end

grupos = unique(grupos, 'rows');

for i=1:f
    u = unique(grupos(i,:));
    u(2:end)
end
%%%end pruebas





save('resultadosAnalisis', 'clasesConflictoChar', 'clasesConflictoNum', 'k', 'tipo');