function Areas = Calcula_Areas(Matriz_Etiquetada)
    
    N = length(unique(Matriz_Etiquetada)) -1;
    Areas = zeros(1,N);
    
    for i = 1:N
        Areas(i) = length(Matriz_Etiquetada(Matriz_Etiquetada == i));
    end

end

