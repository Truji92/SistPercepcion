clear all
clc

% conect and conf
datos = imaqhwinfo;
datos = imaqhwinfo('winvideo',1);

video = videoinput('winvideo',1, 'YUY2_640x360');
get(video)
preview(video)
video.ReturnedColorSpace = 'RGB';
I = getsnapshot(video);
imshow(I)

% 1 Utilizando la función de Matlab subplot, muestre en una misma ventana tipo figure la
% imagen capturada y distintas imágenes que resalten, sobre la imagen original, aquellos píxeles
% cuya intensidad sea mayor que un determinado umbral (asigne distintos valores de umbral
% para generar las distintas imágenes). La intensidad de un píxel se calculará como la media de
% los niveles de gris de las componentes roja, verde y azul.

figure;
I = double(I);
I_intensidad = (I(:,:,1) + I(:,:,2) + I(:,:,3))/3;

I_conUmbral75 = I_intensidad > 75;
I_conUmbral175 = I_intensidad > 175;
I_conUmbral200 = I_intensidad > 200;

I = uint8(I);
subplot(2,2,1); imshow(I);
subplot(2,2,2); funcion_visualiza(I, I_conUmbral75, [255, 255, 0]);
subplot(2,2,3); funcion_visualiza(I, I_conUmbral175, [255, 255, 0]);
subplot(2,2,4); funcion_visualiza(I, I_conUmbral200, [255,255,0]);
% 2.- Para cada una de las imágenes generadas en el apartado anterior, localice a través de su
% centroide los distintos “objetos” (agrupaciones de píxeles conexos) detectados. Visualice el
% centroide del objeto de mayor área en otro color para distinguirlo.

[Ietiq N]=bwlabel(I_conUmbral75);  
stats=regionprops(Ietiq,'Area','Centroid'); 
areas=cat(1,stats.Area);
centroides=cat(1,stats.Centroid); 
Pos_mayor = find(areas == max(areas));

hold on;
subplot(2,2,2); hold on; plot(centroides(:,1),centroides(:,2), 'x'); 
plot(centroides(Pos_mayor, 1), centroides(Pos_mayor, 2), 'rx');

%%%% 

[Ietiq N]=bwlabel(I_conUmbral175);  
stats=regionprops(Ietiq,'Area','Centroid'); 
areas=cat(1,stats.Area);
centroides=cat(1,stats.Centroid); 
Pos_mayor = find(areas == max(areas));

hold on;
subplot(2,2,3); hold on; plot(centroides(:,1),centroides(:,2), 'x'); 
plot(centroides(Pos_mayor, 1), centroides(Pos_mayor, 2), 'rx');

%%%% 

[Ietiq N]=bwlabel(I_conUmbral200);  
stats=regionprops(Ietiq,'Area','Centroid'); 
areas=cat(1,stats.Area);
centroides=cat(1,stats.Centroid); 
Pos_mayor = find(areas == max(areas));

hold on;
subplot(2,2,4); hold on; plot(centroides(:,1),centroides(:,2), 'x'); 
plot(centroides(Pos_mayor, 1), centroides(Pos_mayor, 2), 'rx');
