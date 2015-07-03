clc; clear;
load('../3-Analisis Resultados/resultadosAnalisis.mat');
load('../2-ClasificacionInicial/resultadosTest.mat');
load('../1-ObtencionDatosEntrenamiento/DatosEntrenamiento.mat');
path(path, '../FuncionesAux');

%% Definimos a mano los conjuntos que queremos analizar
DQK = find(ismember(letras,'DQK'));
OH = find(ismember(letras,'OH'));
ZF =  find(ismember(letras,'ZF'));
DQ = find(ismember(letras, 'DQ'));
QK = find(ismember(letras, 'QK'));

conjuntosConflicto = [DQK; OH, 0; ZF, 0; DQ, 0; QK, 0];

[ nConjuntos long] = size(conjuntosConflicto);

mejoresDescriptores = zeros(nConjuntos, 3);
for i = 1:nConjuntos
    conjunto = conjuntosConflicto(i,find(conjuntosConflicto(i,:) ~= 0)); 
    [descrip J] = mejores3(normInputs, outputs, conjuntosConflicto(i,:));
    mejoresDescriptores(i, :) = descrip;
    
    letrasConflicto = letras(conjunto)
    descriptoresElegidos = descriptores(mejoresDescriptores(i, :),:)
    
    fprintf('#####################################');
end


save('CaracteristicasConflictos', 'conjuntosConflicto', 'mejoresDescriptores');