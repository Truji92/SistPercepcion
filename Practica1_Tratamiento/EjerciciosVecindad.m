% 1
A = rand(5);

% 2
B = A(2:4, 3:5);

% 3
C = [A(2,4), A(4,4), A(3,3), A(3,5)];
% Otra opcion 
%C = [A(2:2:4,4), A(3,3:2:5)']; 

% 4
D = B(1,:);

% 5
D = [D C(1,3:4)];

% 6
E = (A > 0.5) .* A;

% 7
mean( ((A(:) > 0.2).*A(:) < 0.7) .* A(:));
%mean(A((A>0.2 & A<0.7)));

% 8
A = rand(5); B = rand(5);
mean( ((B(:)>0.5).*A(:)) )
%mean (A(B>0.5));

% 9
I = imread('P1_1.jpg');
I2 = rgb2gray(I);
[a b c] = size(I);    
Ib = I2 > 200;

subplot(1,3,1); funcion_visualiza(I, Ib, [0,0,255]);
subplot(1,3,2); funcion_visualiza(I2, Ib, [0,255,0]);
subplot(1,3,3); imshow(Ib);
