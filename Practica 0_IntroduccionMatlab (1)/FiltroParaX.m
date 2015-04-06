I=imread('X.jpg');

[N M] = size(I);

Ib = zeros(N,M);

for i=1:N
    for j=1:M
        if I(i, j) < 100
            Ib(i,j) = 1;
        end
    end
end

