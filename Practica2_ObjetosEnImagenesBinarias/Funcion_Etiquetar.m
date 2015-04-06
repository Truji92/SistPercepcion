function [MatrizEtiquetas, N] = Funcion_Etiquetar(Matriz_Binaria)


[lineas columnas] = size(Matriz_Binaria);
MatrizBinariaExpandida = [zeros(1,columnas+2); zeros(lineas,1), Matriz_Binaria, zeros(lineas,1); zeros(1,columnas+2)]; 
MatrizEtiquetas = double(MatrizBinariaExpandida);
ultimaEtiqueta = 0;


for L = 2:lineas+1
       for C = 2:columnas+1
            if MatrizBinariaExpandida(L,C) == 1
                ultimaEtiqueta = ultimaEtiqueta + 1;
                MatrizEtiquetas(L,C) = ultimaEtiqueta;
            end
       end
end  
   

conCambios = true;
while conCambios
    conCambios = false;
    for L = 2:lineas+1
       for C = 2:columnas+1
            if MatrizEtiquetas(L,C) ~= 0
                puntos = vecinosYpuntoAlBajar(MatrizEtiquetas,L,C);
                m = min(etiquetas(puntos));
                if MatrizEtiquetas(L,C) ~= m
                    MatrizEtiquetas(L,C) = m;
                    conCambios = true;
                end
            end
       end
    end 
    
    for L = lineas+1:-1:2
       for C = columnas+1:-1:2
            if MatrizEtiquetas(L,C) ~= 0
                m = min(etiquetas(vecinosYpuntoAlSubir(MatrizEtiquetas,L,C)));
                if MatrizEtiquetas(L,C) ~= m
                    MatrizEtiquetas(L,C) = m;
                    conCambios = true;
                end
            end
       end
    end 
end
MatrizEtiquetas(1,:) = [];
MatrizEtiquetas(:,1) = [];
MatrizEtiquetas(end, :) = [];
MatrizEtiquetas(:, end) = [];
valores = unique(MatrizEtiquetas);
valores(valores == 0) = [];
[N n] = size(valores);
for i=1:N
    indices = find(MatrizEtiquetas == valores(i));
    MatrizEtiquetas(indices) = i;
end

end

function vecinos = vecinosYpuntoAlBajar(M, L, C)
       
    vecinos = [ M(L,C) M(L,C-1)  M(L-1,C-1)  M(L-1, C) M(L-1,C+1) ];
    
end

function vecinos = vecinosYpuntoAlSubir(M, L, C)
    
        vecinos = [ M(L,C), M(L,C+1), M(L+1,C+1), M(L+1,C), M(L+1, C-1) ];
    
end

function et = etiquetas(puntos)
    puntos(puntos == 0) = [];
    et = puntos;
end
