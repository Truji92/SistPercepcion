clc; clear;
path(path, './ImagenesTest');
path(path, '../FuncionesAux');
ext = '.tif';
load('SalidasTeoricasImTests.mat');
load('../1-ObtencionDatosEntrenamiento/DatosEntrenamiento.mat');

ConjuntoSalidasReales = [Salidas_Tests01, Salidas_Tests02, Salidas_Tests03, Salidas_Tests04, Salidas_Tests05, Salidas_Tests06, Salidas_Tests07, Salidas_Tests08, Salidas_Tests09, Salidas_Tests10];  
    
numeroDeTests = 10;

TestInputs = [];

resultado = [];
for i =1:numeroDeTests

    if (i < 10)
        nombreImagen = strcat('Test0', num2str(i), ext);
    else 
        nombreImagen = strcat('Test', num2str(i), ext);
    end
    
    %valoresReales = ConjuntoSalidasReales(i, :);
    
    I = rgb2gray(imread(nombreImagen));
    
    
    I = I';
    
    umbral = graythresh(I)*255;
    
    Ib = I <= umbral;
    
    todasLasInputs = genInputs(Ib);
    
    [x y z] = size(todasLasInputs);
    medias = repmat(media, 1,y);
    %NORMALIZAR LOS VALORES DE TEST
     todasLasInputs = todasLasInputs - medias;
     
     for descriptor=1:x
         todasLasInputs(descriptor, :) = todasLasInputs(descriptor, :) ./ desv(descriptor,1);
     end
     
    
    %Solo se utilizan los hu
    
    TestInputs = [TestInputs, todasLasInputs];

    HuDeTests = todasLasInputs(6:end, :); %Seleccionamos los hu
    
    InputSoloHu = normInputs(6:end, :);
    
    [Ietiq, N] = bwlabel(Ib);
    
    
    resultknn = [];
    resultknnM = [];
    ks = [1,3,5,10,15,20];

    for k = 1:length(ks)
        line = [];
        mline = [];
        for letra = 1:N
            line = [line knn(InputSoloHu, outputs, HuDeTests(:, letra), ks(k))];
            mline = [mline knnM(InputSoloHu, outputs, HuDeTests(:, letra), ks(k))];
        end
        resultknn = [resultknn; line];
        resultknnM = [resultknnM; mline];
    end
    
    resultadoaux = [resultknn; resultknnM];
    resultado = [resultado, resultadoaux];
    
    
end

    save('resultadosTest', 'resultado', 'ConjuntoSalidasReales', 'ks', 'letras', 'TestInputs');