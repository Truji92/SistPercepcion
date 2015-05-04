%% 
% 1. Determinar el brillo y el contraste de la imagen “P4.jpg”.
I = imread('P4.jpg');
hist = imhist(I);
levels = [0:255]';

total = sum(hist);

B = sum(hist.*levels) / total;

C = sqrt(sum(hist.*(levels-B).^2) / total);

%%
%  2. Genere nuevas imágenes de mayor y menor brillo que la original y
%     mida, para cada imagen generada, el nuevo valor de brillo.

bajarBrillo = @(x) x - 80;
subirBrillo = @(x) x + 80;

ImenosBrillo = bajarBrillo(I);
Bmenos = getBrillo(ImenosBrillo);

ImasBrillo = subirBrillo(I);
Bmas = getBrillo(ImasBrillo);

figure;
subplot(1,3,1); imshow(ImenosBrillo); title(strcat('B = ', num2str(Bmenos)));
subplot(1,3,2); imshow(I); title(strcat('B = ', num2str(B)));
subplot(1,3,3); imshow(ImasBrillo); title(strcat('B = ', num2str(Bmas)));


%%
% 3. Genere nuevas imágenes de mayor y menor contraste que la original y mida, para cada
%    imagen generada, el nuevo valor de contraste.

bajarContraste = @(x) (x - 0) * (150 - 0) / (255 - 0);
subirContraste = @(x) (x - 25) * (255 - 0) / (200 - 25);

ImasContraste = uint8(subirContraste(double(I)));
Cmas = getContraste(ImasContraste);

ImenosContraste = uint8(bajarContraste(double(I)));
Cmenos = getContraste(ImenosContraste);

figure;
subplot(2,3,1); imshow(ImenosContraste); title(strcat('C = ', num2str(Cmenos)));
subplot(2,3,4); imhist(ImenosContraste);
subplot(2,3,2); imshow(I); title(strcat('C = ', num2str(C)));
subplot(2,3,5); imhist(I);
subplot(2,3,3); imshow(ImasContraste); title(strcat('C = ', num2str(Cmas)));
subplot(2,3,6); imhist(ImasContraste);


%%
% 4. Aumente el contraste de la zona central de la imagen expandiendo de forma lineal el
%    histograma.

ROI = roipoly(I);
cuadro = uint8(double(I) .* ROI);
cuadroContrasteAlto = uint8(subirContraste(double(cuadro)));
IcuadroContrasteAlto = uint8(double(I) .* (ROI == 0) + double(cuadroContrasteAlto) .* ROI);

figure;
subplot(1,2,1); imshow(I);
subplot(1,2,2); imshow(IcuadroContrasteAlto);

%%
% 5. Aplica la instrucción de Matlab imfilter , para filtrar la imagen 
%    “P4.jpg”, utilizando las siguientes máscaras:
%           HP=ones(5,5)/25; 
%           HL=[-1 -1 -1 ; -1 8 -1 ; -1 -1 -1]
%    y visualízalas utilizando imshow . Justifica las diferencias que 
%    observas si en lugar de utilizar la máscara “ HP = ones(5,5)/25 ” 
%    se utiliza “ HP = ones(9,9)/81 ”.

%%
% 6. Implemente un algoritmo que de forma automática segmente los objetos
%    presentes en las imágenes A1, A2 y A3 facilitadas.
