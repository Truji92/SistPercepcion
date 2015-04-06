ImagenBinaria = imread('ImagenBinaria.tif')/255;
[MatrizEtiquetas N] = Funcion_Etiquetar(ImagenBinaria);

for i=1:N
   imagen = 255 * (MatrizEtiquetas == i);
   mombrearchivo = ['imagen' int2str(i) '.bmp'];
   %figure; imshow(uint8(imagen));
   imwrite(uint8(imagen), mombrearchivo);
   
end

Colores = [255 0 0; 0 255 0; 0 0 255; 255 255 0; 255 0 255; 0 255 255];

[x y z] = size(MatrizEtiquetas);
imagenEnColor = zeros(x, y, 3);

for i = 1:N
    for j=1:3
        imagenEnColor(:,:,j) = imagenEnColor(:,:,j) + Colores(i,j) * (MatrizEtiquetas == i);
    end
end
imwrite(uint8(imagenEnColor), 'imagenColores.bmp');
%imshow(uint8(imagenEnColor));


centroides = Calcula_Centroides(MatrizEtiquetas);

imshow(imagenEnColor); hold on;
plot(centroides(:,2), centroides(:,1), 'x');

Areas = Calcula_Areas(MatrizEtiquetas);
sort(Areas);
filtrada = Filtra_Objetos(ImagenBinaria, Areas(length(Areas)-2));
figure; imshow(filtrada);

