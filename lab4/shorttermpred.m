function a = shorttermpred(x, P)
H = zeros(size(x, 1)-P, P);
for i = 1:P
    H(:, i) = x(P+1-i:end-i);
end
a = inv(H'*H)*H'*x(P+1:end);
end