%Calcula el Histograma de una imagen en niveles de gris


Im1 = imread('P1_1.jpg');
Im1 = Im1(:,:,2);

grises = [0:255];
cantidad = zeros(size(grises));

for i = grises
    cantidad(i+1) = sum(Im1(:) == i);
end

stem(grises, cantidad, 'rx');
hold on; 
imhist(Im1); title('imhist'); 

[A,B]=imhist(Im1);
sum(cantidad - A' ~= 0)


