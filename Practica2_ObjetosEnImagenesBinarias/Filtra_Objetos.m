function Matriz_Binaria_Filtrada = Filtra_Objetos(Matriz_Binaria, NumPix)
    
    [MatrizEtiquetada N] = Funcion_Etiquetar(Matriz_Binaria);
    Areas = Calcula_Areas(MatrizEtiquetada);
    Matriz_Binaria_Filtrada = zeros(size(Matriz_Binaria));
    
    
    for i = 1:N
        if Areas(i) >= NumPix
            Matriz_Binaria_Filtrada(MatrizEtiquetada == i) = 1;
        end
    end
   
end

