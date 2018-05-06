function a = longtermpred(x, N)
H = x(1:end-N);
a = inv(H'*H)*H'*x(N+1:end);
end