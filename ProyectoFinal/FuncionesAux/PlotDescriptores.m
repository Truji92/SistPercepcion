function [ ] = PlotDescriptores(inputs, outputs, clases, descriptores, recta)
% recta 
% 0 -> sin recta
% 1 -> con recta 



cmap = hsv(length(clases));
medias = zeros(length(descriptores), length(clases));


for i = 1:length(clases)
   indexs = find(outputs == clases(i));
   puntos = inputs(descriptores, indexs);
   
   [comp, npuntos] = size(puntos);
   
   
   if comp == 2
       plot(puntos(1,:), puntos(2,:),'*', 'Color', cmap(i,:));
   else 
       plot3(puntos(1,:), puntos(2,:), puntos(3,:),'*' ,'Color', cmap(i,:));
   end
   
   hold on;
   
   
   medias(:,i) = mean(puntos')';
    
end

if recta == 1
    p1 = medias(:,1);
    p2 = medias(:,2);
    m = (p2(1) - p1(1))/(p2(2) - p1(2));
    
    plot(p1(1), p1(2), 'o');
    plot(p2(1), p2(2), 'o');
    
    pmedio = (medias(:,1) + medias(:,2)) ./ 2;
    mPerp = -1/m;
    
    f = @(x,p) mPerp*x + p;
    
    ec = @(p) f(pmedio(1), p) - pmedio(2);
    
    abscisaOr = fzero(ec, 0);
    
    y = @(x) mPerp*x + abscisaOr;
    
    ezplot(y);
    
end
    


end

