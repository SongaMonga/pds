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
plot(x_pred2);
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
clear all
load("energy_train.mat");
load("energy_test.mat");
N = 96;
a = longtermpred(x_train, N); %compute the parameter a using LS
x_pred1 = a*x_test(1:end-N); %the prediction
r = x_test(N+1:end)-x_pred1; %the residual
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
x_pred2 = x_test(N+P+1:end) + r_pred; %the new prediction of the training data
anomaly1 = anomalydetection(x_test(N+1:end), x_pred1); %anomalies using the long term prediction
figure
hold on
plot(x_test(N+1:end))
scatter(anomaly1, x_test(anomaly1 + N))
anomaly2 = anomalydetection(x_test(N+P+1:end), x_pred2); %anomalies using the short term prediction
figure
hold on
plot(x_test(N+P+1:end))
scatter(anomaly2, x_test(anomaly2 + N + P))