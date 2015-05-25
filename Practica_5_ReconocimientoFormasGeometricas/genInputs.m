function [ inputs, N] = genInputs(Ib)
%GENINPUTS Genera vector de inputs de los objetos de una imagen binaria
%   

[Ietiq N] = bwlabel(Ib);

stats = regionprops(Ietiq, 'Area', 'Perimeter', 'Eccentricity', 'Extent', 'Solidity',  'EulerNumber'); 

areas = cat(1, stats.Area);
perimetros = cat(1, stats.Perimeter);
compacticidad = areas ./ perimetros.^2;
excentricidad = cat(1, stats.Eccentricity);
%%BBox = cat(1, stats.BoundingBox);
BBox = cat(1, stats.Extent);
%%CHull = cat(1, stats.ConvexHull);
CHull = cat(1, stats.Solidity);
NEuler = cat(1, stats.EulerNumber);

momentosHu = [];
for i = 1:N
   Hu = Funcion_Calcula_Hu(Ietiq == i);
   momentosHu = [momentosHu, Hu];
end

inputs = [compacticidad'; excentricidad'; BBox'; CHull'; NEuler'; momentosHu];

%
% Compacticidad => 'Area'/ 'Perimeter' ^2
% Excentricidad => 'Eccentricity'
% Solidez (bounding box) => 'BoundingBox'
% Solidez (convex hull) => 'ConvexHull' 
% Número de Euler => 'EulerNumber'

end

