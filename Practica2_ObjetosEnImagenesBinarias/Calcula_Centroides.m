function centroides = Calcula_Centroides(Matriz_Etiquetada)
    
    N = length(unique(Matriz_Etiquetada)) -1;
    centroides = zeros(2,N);
    [x y z] = size(Matriz_Etiquetada);
    
    for i = 1:N
       [puntosx puntosy] = find(Matriz_Etiquetada == i);
       centroides(1,i) = mean(puntosx);
       centroides(2,i) = mean(puntosy);
    end
    centroides = centroides';
%     
%     for i = 1:x
%         for j = 1:y
%            if Matriz_Etiquetada(i,j) ~= 0 
%               obj = Matriz_Etiquetada(i,j);
%               centroides(1, obj) = centroides(1, obj) + i;
%               centroides(2, obj) = centroides(2, obj) + j;
%            end
%         end
%     end
%      
%     Areas = Calcula_Areas(Matriz_Etiquetada);
%     centroides = centroides./[Areas;Areas];
%     centroides = round(centroides');
%     

end

