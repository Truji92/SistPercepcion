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
inputsNormalizados = [];
for i = 1:numeroDescriptores
   descriptor = inputs(i,:);
   desviacion = std(descriptor);
   if (desviacion == 0)
       inputsNormalizados = [inputsNormalizados; descriptor];
   else
       media = mean(descriptor);
       inputsNormalizados = [inputsNormalizados; (descriptor-media)./desviacion];
   end
end


