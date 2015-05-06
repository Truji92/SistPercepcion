function [ Hu ] = funcion_calcula_Hu(Ib)
%FUNCION_CALCULA_HU Summary of this function goes here
%   Detailed explanation goes here

[x, y] = size(Ib);
Ib = double(Ib);

m00 = 0;
m10 = 0;
m01 = 0;

for i = 1:x
    for j = 1:y
        m00 = m00 + Ib(i,j);
        m10 = m10 + i*Ib(i,j);
        m01 = m01 + j*Ib(i,j);
    end
end

X = m10 / m00;
Y = m01 / m00;

w00 = m00;
%%w10 = w11 = w12 = w20 = w02 = w30 = w21 = w03 = 0;

matW = zeros(4);

w = @(p,q,x,y,I) (x-X)^p * (y-Y)^q *I(x,y);

for i = 1:x
    for j = 1:y
        for n = 0:3
            for m = 0:3
                matW(n+1,m+1) = matW(n+1,m+1) + w(n,m,i,j,Ib); 
            end
        end      
    end
end


Wval = @(x,y) matW(x+1,y+1);

matMu = zeros(4);
for p = 0:3
    for q = 0:3
        Wval(p,q)
        matMu(p+1,q+1) = Wval(p,q)/w00^(1 + (p+q)/2);
    end
end 


Mu = @(p,q) matMu(p+1,q+1);

Hu = zeros(7,1);
Hu(1) = Mu(2,0) + Mu(0,2);
Hu(2) = (Mu(2,0) - Mu(0,2))^2 + 4*Mu(1,1)^2;
Hu(3) = (Mu(3,0) - 3*Mu(1,2))^2 + (3*Mu(2,1) - Mu(0,3))^2;
Hu(4) = (Mu(3,0)-Mu(1,2))^2 + (Mu(2,1)-Mu(0,3))^2;

ceros = Hu == 0;
Hu(ceros) = 1*exp(-100);
Hu = abs(log(abs(Hu)));

end



        
%         w10 = w(1,0,i,j,Ib);
%         w11 = w(1,1,i,j,Ib);
%         w12 = w(1,2,i,j,Ib);
%         w20 = w(2,0,i,j,Ib);
%         w02 = w(0,2,i,j,Ib);
%         w30 = w(3,0,i,j,Ib);
%         w21 = w(2,1,i,j,Ib);
%         w03 = w(0,3,i,jS,Ib);
  
