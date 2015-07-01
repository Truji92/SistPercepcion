clear; clc;
path(path, './ImagenesEntrenamiento');

letras = ['A' 'B' 'C' 'D' 'E' 'F' 'G' 'H' 'I' 'J' 'K' 'L' 'M' 'N' 'O' 'P' 'Q' 'R' 'S' 'T' 'U' 'V' 'W' 'X' 'Y' 'Z'];
descriptores = ['Compact'; 'Excentr'; 'Sol(BB)'; 'Sol(CH)'; 'N_Euler'; 'M_Hu_01'; 'M_Hu_02'; 'M_Hu_03'; 'M_Hu_04'; 'M_Hu_05'; 'M_Hu_06'; 'M_Hu_07'];
Ndescriptores = 12;

ext = '.tif';

inputs = [];
outputs = [];

for i=1:length(letras)
   for number=1:2
   filePath = [letras(i), int2str(number), ext];
   img = imread(filePath);
   img = rgb2gray(img);
   
   humbral = graythresh(img)*255;
   Ib = img < humbral;
   [inputs_, N] = genInputs(Ib);
   
   outputs_ = repmat(i, N, 1)';
   
   inputs = [inputs, inputs_];
   outputs = [outputs, outputs_];
   end
end


%%% Normalización
media = [];
desv = [];
normInputs = [];

for i = 1:Ndescriptores
   descriptor = inputs(i, :);
   media_ = mean(descriptor);
   desv_ = std(descriptor);
   if (desv_ == 0)
       normInputs = [normInputs; descriptor];
       media = [media; 0];
       desv = [desv; 1];
   else
       normDescriptor = (descriptor - media_) ./ desv_;
       normInputs = [normInputs; normDescriptor];
       media = [media; media_];
       desv = [desv; desv_];
   end
   
end

