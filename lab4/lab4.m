%% R1.b)
clear all
load("energy_train.mat");
N = 96;
a = longtermpred(x_train, N); %compute the parameter a using LS
figure
plot(x_train(N+1:end)); %we exclude the N first values, because the prediction won't contain them
x_pred = a*x_train(1:end-N); %the prediction
figure
plot(x_pred);
r = x_train(N+1:end)-x_pred; %the residual
figure
plot(r)

%% R1.c)
clear all
load("energy_train.mat");
N = 96;
a = longtermpred(x_train, N); %compute the parameter a using LS
x_pred = a*x_train(1:end-N); %the prediction
r = x_train(N+1:end)-x_pred; %the residual
E = sum(r.^2); %compute the energy of the residual r

%% R1.e)
clear all
load("energy_train.mat");
N = 96;
a = longtermpred(x_train, N); %compute the parameter a using LS
x_pred1 = a*x_train(1:end-N); %the prediction
r = x_train(N+1:end)-x_pred1; %the residual
load("energy_train.mat");
P = 5;
a = shorttermpred(r, P); %compute the parameters a_k using LS
figure
plot(r(P+1:end)); %we exclude the P first values, because the prediction won't contain them
r_pred = zeros(size(r, 1) - P, 1);
for n = P+1:size(r_pred, 1) %this for computes the short term prediction
    s = 0;
    for k = 1:P
        s = s + a(P+1-k)*r(n-P+k-1);
    end
    r_pred(n-P) = s;
end
figure
plot(r_pred);
x_pred2 = x_train(N+P+1:end) + r_pred; %the new prediction of the training data
figure
hold on
plot(x_train(N+P+1:end));
plot(x_pred1(P+1:end))
plot(x_pred2); 
legend('original signal','1st prediction', '2nd prediction')
e = r(P+1:end)-r_pred; %the residual
figure
plot(e);

%% R1.f)
clear all
load("energy_train.mat");
N = 96;
a = longtermpred(x_train, N); %compute the parameter a using LS
x_pred1 = a*x_train(1:end-N); %the prediction
r = x_train(N+1:end)-x_pred1; %the residual
load("energy_train.mat");
P = 5;
a = shorttermpred(r, P); %compute the parameters a_k using LS
r_pred = zeros(size(r, 1) - P, 1);
for n = P+1:size(r_pred, 1) %this for computes the short term prediction
    s = 0;
    for k = 1:P
        s = s + a(P+1-k)*r(n-P+k-1);
    end
    r_pred(n-P) = s;
end
e = r(P+1:end)-r_pred; %the residual
E = sum(e.^2);

%% R2.b)
load("energy_test.mat");
plot(x_test);
P = 10;
a = shorttermpred(x_test, P);
x_pred = zeros(size(x_test, 1) - P, 1);
for i = 1+P:size(x_pred, 1)
    s = 0;
    for k = 1:P
        s = s + a(k)*x_test(i-P+k-1);
    end
    x_pred(i-P) = s;
end
figure;
plot(x_pred);
e = x_test(P+1:end)-x_pred;
figure;
plot(e);

%% longterm
load("energy_test.mat");
plot(x_test);
N = 96;
a = longtermpred(x_test, N);
x_pred = a*x_test(1:end-N); %this was (N+1:end), so not like above
figure;
plot(x_pred);
r = x_test(N+1:end)-x_pred;
figure;
plot(r);