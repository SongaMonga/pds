% %% R1.b)
% load("energy_train.mat");
% N = 96;
% a = longtermpred(x_train, N);
% figure
% title('Graph of Sine and Cosine Between -2\pi and 2\pi')
% plot(x_train(N+1:end));
% x_pred = a*x_train(N+1:end);
% figure
% plot(x_pred);
% r = x_train(N+1:end)-x_pred;
% figure
% plot(r)
% 
% %% R1.c)
% load("energy_train.mat");
% N = 96;
% a = longtermpred(x_train, N);
% x_pred = a*x_train(N+1:end);
% r = x_train(N+1:end)-x_pred;
% E = sum(r)^2;

%% R1.e)
load("energy_train.mat");
P = 5;
a = shorttermpred(x_train, P);
figure
plot(x_train(P+1:end));
x_pred = zeros(size(x_train, 1) - P, 1);
for i = 1:size(x_pred, 1)
    sum = 0;
    for k = 1:P
        sum = sum + a(k)*x_train(P+i-k);
    end
    x_pred(i) = sum;
end
figure
plot(x_pred);
r = x_train(P+1:end)-x_pred;
figure
plot(r);

%% R1.f)
load("energy_train.mat");
P = 5;
a = shorttermpred(x_train, P);
x_pred = zeros(size(x_train, 1) - P, 1);
for i = 1:size(x_pred, 1)
    s = 0;
    for k = 1:P
        s = s + a(k)*x_train(P+i-k);
    end
    x_pred(i) = s;
end
r = x_train(P+1:end)-x_pred;
E = sum(r)^2;

%% R2.b)
load("energy_test.mat");
