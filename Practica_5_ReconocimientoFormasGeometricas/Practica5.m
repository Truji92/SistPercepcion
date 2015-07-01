clear; clc;
path(path, genpath('./MaterialFacilitado/'));


circ = 1;
cuad = 2;
trian = 3;

imgCirc = imread('/MaterialFacilitado/Imagenes/fotos_entrenamiento/Circ_ent.JPG');
imgCuad = imread('/MaterialFacilitado/Imagenes/fotos_entrenamiento/Cuad_ent.JPG');
imgTrian = imread('/MaterialFacilitado/Imagenes/fotos_entrenamiento/Trian_ent.JPG');


numeroDescriptores = 7 + 5;

%circulos
grayT = graythresh(imgCirc)*255;
circB = imgCirc < grayT;
[inputs, NCirc] = genInputs(circB);
outputs = repmat(circ, NCirc, 1)';
%cuadrados
grayT = graythresh(imgCuad)*255;
cuadB = imgCuad < grayT;
[inputsCuad NCuad] = genInputs(cuadB);
inputs = [inputs inputsCuad];
outputs = [outputs repmat(cuad, NCuad, 1)'];
%triangulos
grayT = graythresh(imgTrian)*255;
trianB = imgTrian < grayT;
[inputsTrian, NTrian] = genInputs(trianB);
inputs = [inputs inputsTrian];
outputs = [outputs repmat(trian, NTrian, 1)'];

% Normalizacion
mediaYstd = [];
inputsNormalizados = [];
for i = 1:numeroDescriptores
   descriptor = inputs(i,:);
   desviacion = std(descriptor);
   if (desviacion == 0)
       inputsNormalizados = [inputsNormalizados; descriptor];
       mediaYstd = [mediaYstd; descriptor(1), desviacion];
   else
       media = mean(descriptor);
       inputsNormalizados = [inputsNormalizados; (descriptor-media)./desviacion];
       mediaYstd = [mediaYstd; media, desviacion];
   end
end


%% VISUALIZACION

figure;
for i = 1:numeroDescriptores
   subplot(2, ceil(numeroDescriptores/2), i);
   plot(outputs, inputsNormalizados(i,:), '*');
   
end

%% SELECCION

separabilidad = [];
for i = 1:numeroDescriptores
    J = indiceJ(inputsNormalizados(i,:), outputs);
    separabilidad = [separabilidad; J];
end

[nuevoOrden, indexs] = sort(separabilidad, 'descend');

carPreSeleccionadas = 6;

indexs = indexs(1:6);

numeroCaracteristicasFinal = 3;
combinaciones = combnk(indexs, numeroCaracteristicasFinal);

[fil col] = size(combinaciones);

separabilidadComb = zeros(fil, 1);
for i = 1:fil 
    subInputs = inputsNormalizados(combinaciones(i,:), :);
    Jconjunta = indiceJ(subInputs, outputs);
    separabilidadComb(i) = Jconjunta;
end

[sepMax, indexMax] = max(separabilidadComb);

carateristicasSeleccionadas = combinaciones(indexMax, :); 

inputsDeTrabajo = inputsNormalizados(carateristicasSeleccionadas, :);

%% TEST
imgTest = imread('Test3.jpg');
gthres = graythresh(imgTest);
Ibin = imgTest < gthres;

[vector, N] = genInputs(circB);
[objs, N] = bwlabel(Ibin);
vector = vector(carateristicasSeleccionadas,:);
mediasYstdSeleccionadas = mediaYstd(carateristicasSeleccionadas,:);
for i=1:N
   funcion_visualiza(imgTest, objs == i, [255,0,0]);
   class = knn(inputsDeTrabajo, outputs, (vector(:,i) - mediasYstdSeleccionadas(:,1)) ./ mediasYstdSeleccionadas(:,2) , 4);
   classM = knnM(inputsDeTrabajo, outputs, (vector(:,i) - mediasYstdSeleccionadas(:,1)) ./ mediasYstdSeleccionadas(:,2) , 4);
   if (classM == circ)
       title('circulo');
   elseif (classM == trian)
       title('triangulo');
   else
       title('cuadrado');
   end
   
   if(class ~= classM)
       fprintf('fuck\n');
   end
   
   waitforbuttonpress
end


%% SUGERENCIAS PARA PROYECTO
% Paso1 
% ObtenerDatosEntrenamiento
% Array con medias y desviaciones (para normalizacines)

% Paso2 
% Clasificacion Inicial KNN_7Hu
% con K = 1,3,5,10,15,20 con los 7 momentos de Hu
% knn con euclidea y otro con mahalanois
% Generar resultados para todas imagenes de test

% Paso3
% Analizar Resultados del paso2 para ver K mas adecuado y clases
% conflictivas
% 

% Paso4
% Seleccion descriptores para clases conflictivas
% Calculando separabilidad (P5)
% 

% Paso5
% Clasificador Final sobre Test
% implementar clasificadores para clases conflictivas
% Diferentes K en los nuevos clasificadores: 1, 3, 5.....

% Paso6
% Analizar resultados de P5 y elegir K final






