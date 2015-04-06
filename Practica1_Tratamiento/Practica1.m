% 4 informacion de la imagen
info = imfinfo('P1_1.jpg')

% 5
Imagen1 = imread('P1_1.jpg');

% 6
imtool(Imagen1); figure; imshow(Imagen1);

% 7
whos Imagen1

max(Imagen1(:))

% 8 Calculo de imagen complementaria
compl = @(x) 255 - x;

%inmediato
%Imagen2 = uint8(compl(double(Imagen1)));

%Por Componentes
Imagen2 = uint8(compl(double(Imagen1(:,:,1))));
Imagen2(:,:,2) = uint8(compl(double(Imagen1(:,:,2))));
Imagen2(:,:,3) = uint8(compl(double(Imagen1(:,:,3))));

figure; imtool(Imagen2);
imwrite(Imagen2, 'Imagen2.jpg')

% 9
Imagen3 = Imagen1(:,:,1);
imtool(Imagen3);
imwrite(Imagen3, 'Imagen3.bmp');
info3 = imfinfo('Imagen3.bmp');

% 10
Imagen4 = imadjust(Imagen3, [], [], 0.1);
Imagen5 = imadjust(Imagen3, [], [], 5);
figure;

subplot (2,3,1); imhist(Imagen3); title('Imagen3');
subplot (2,3,2); imhist(Imagen4); title('Imagen4');
subplot (2,3,3); imhist(Imagen5); title('Imagen5');
subplot (2,3,4); imshow(Imagen3); 
subplot (2,3,5); imshow(Imagen4); 
subplot (2,3,6); imshow(Imagen5); 

% 11
Imagen6 = imabsdiff(Imagen4, Imagen5);
figure; imshow(Imagen6);
% Manual
Imagen7 = uint8(abs(double(Imagen4)-double(Imagen5)));
figure; imshow(Imagen7);