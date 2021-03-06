clc; clear;
load('../3-Analisis Resultados/resultadosAnalisis.mat');
load('../2-ClasificacionInicial/resultadosTest.mat');
load('../1-ObtencionDatosEntrenamiento/DatosEntrenamiento.mat');
load('../4-SeleccionCaracteristicas/CaracteristicasConflictos.mat');

path(path, '../FuncionesAux');


[numConflictos, col] = size(conjuntosConflicto);

mejorAlgoritmo = zeros(numConflictos, 2);

for i = 1:numConflictos
   
   conflicto = conjuntosConflicto(i,find(conjuntosConflicto(i,:) ~= 0)); 
   descrip = mejoresDescriptores(i,:);
   
   indexsOutputs = find(ismember(outputs, conflicto));
   
   testInputsConflicto = TestInputs(descrip, find(ismember(ConjuntoSalidasReales, conflicto)));
   testOutputsConflicto = ConjuntoSalidasReales(find(ismember(ConjuntoSalidasReales, conflicto)));
   
   inputsConflicto = normInputs(descrip, indexsOutputs);
   outputsConflicto = outputs(indexsOutputs);
   
   [fil casos] = size(testInputsConflicto);
   
   
   ResultadosAnalisis = [];
   for j = 1:casos
       vector = testInputsConflicto(:, j);
       Knn = [];
       KnnM = [];
       for k = 1:length(ks)
            Knn = [Knn; knn(inputsConflicto, outputsConflicto, vector, ks(k))]; 
            KnnM = [KnnM; knnM(inputsConflicto, outputsConflicto, vector, ks(k))];
       end
       eucl = ClasificadorMinEuclidea(inputsConflicto, outputsConflicto, vector);
       mah = ClasificadorMinMahala(inputsConflicto, outputsConflicto, vector);
       nuevaInfo = [eucl;mah;Knn;KnnM];
       ResultadosAnalisis = [ResultadosAnalisis, nuevaInfo];
   end
   

   TrantandoConflicto = letras(conflicto)
   
   
   letras([testOutputsConflicto; ResultadosAnalisis])
   
   salidasReales = repmat(testOutputsConflicto, 2+length(ks)*2 ,1);
   matrizFallos = salidasReales ~= ResultadosAnalisis;
   
   sumaDeFallos = sum(matrizFallos')';
   
   kaux = [ks';ks'];
   
   primeraCol = [0;0;kaux];
   
   %primera linea DistEuclidea
   %Segunda linea Distmahalanois
   %knn
   %knnM
   tablaFallos = [primeraCol, sumaDeFallos]
   
   mejor = find(tablaFallos(:,2) == min(tablaFallos(:,2)),1);
   
   % eu 1; ma 2; knn 3; knnM 4
   if mejor <=2
       mejorAlgoritmo(i,:) = [mejor, 0]; 
   else
       if mejor <= 2+length(ks)
           mejorAlgoritmo(i,:) = [3,tablaFallos(mejor,1)];
       else
           mejorAlgoritmo(i,:) = [4,tablaFallos(mejor,1)];
       end
   end
   
   
    
end

%% Asignaciones Manuales Para Clasificador

% Orden
% DQK
% OH
% ZF
% DQ
% QK

FilaAdecuada = [find(letras == 'K'), 5;
                find(letras == 'O'), 2;
                find(letras == 'H'), 2;
                %find(letras == 'Z'), 3;
                find(letras == 'F'), 3;
                find(letras == 'Q'), 1;]
                
filaDQ = 4;




save('AlgoritmosConflictos', 'mejorAlgoritmo', 'FilaAdecuada', 'filaDQ');
