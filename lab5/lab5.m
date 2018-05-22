%% R1.b)
clear all; close all
load("sar_image.mat");
figure; colormap hsv %apply a different color mapping to better distinguish ice from water
imagesc(I); truesize 

%% R1.c)
clear all; close all
load("sar_image.mat");
ice = imcrop(I, [760 2453 949 188]); %big lower right chunk of ice
water = imcrop(I, [1 1 629 1234]); %big upper left chunk of water
%compute the different Maximum Likelihood Estimators for both ice and water
p_ice_exp = mle(ice(:), 'distribution', 'Exponential');
p_ice_ray = mle(ice(:), 'distribution', 'Rayleigh');
p_ice_nor = mle(ice(:), 'distribution', 'Normal');
p_water_exp = mle(water(:), 'distribution', 'Exponential');
p_water_ray = mle(water(:), 'distribution', 'Rayleigh');
p_water_nor = mle(water(:), 'distribution', 'Normal');

%% R1.d)
clear all; close all
load("sar_image.mat");
ice = imcrop(I, [760 2453 949 188]);
water = imcrop(I, [1 1 629 1234]);
p_ice_exp = mle(ice(:), 'distribution', 'Exponential');
p_ice_ray = mle(ice(:), 'distribution', 'Rayleigh');
p_ice_nor = mle(ice(:), 'distribution', 'Normal');
p_water_exp = mle(water(:), 'distribution', 'Exponential');
p_water_ray = mle(water(:), 'distribution', 'Rayleigh');
p_water_nor = mle(water(:), 'distribution', 'Normal');

figure('Name', 'Ice'); histogram(ice(:), 'Normalization', 'probability') %normalized histogram of the ice values
ice_exp = exppdf(ice(:), p_ice_exp); %compute the pdf with exponential distribution
figure('Name', 'Ice - Exponential'); scatter(ice(:), ice_exp, 'filled')
ice_ray = raylpdf(ice(:), p_ice_ray); %compute the pdf with Rayleigh distribution
figure('Name', 'Ice - Rayleigh'); scatter(ice(:), ice_ray, 'filled')
ice_nor = normpdf(ice(:), p_ice_nor(1), p_ice_nor(2)); %compute the pdf with normal distribution
figure('Name', 'Ice - Normal'); scatter(ice(:), ice_nor, 'filled')

figure('Name', 'Water'); histogram(water(:), 'Normalization', 'probability') %normalized histogram of the water values
water_exp = exppdf(water(:), p_water_exp); %compute the pdf with exponential distribution
figure('Name', 'Water - Exponential'); scatter(water(:), water_exp, 'filled')
water_ray = raylpdf(water(:), p_water_ray); %compute the pdf with Rayleigh distribution
figure('Name', 'Water - Rayleigh'); scatter(water(:), water_ray, 'filled')
water_nor = normpdf(water(:), p_water_nor(1), p_water_nor(2)); %compute the pdf with normal distribution
figure('Name', 'Water - Normal'); scatter(water(:), water_nor, 'filled')

%% R2.a)
load("sar_image.mat");
ice = imcrop(I, [760 2453 949 188]);
water = imcrop(I, [1 1 629 1234]);
p_ice_nor = mle(ice(:), 'distribution', 'Normal');
p_water_nor = mle(water(:), 'distribution', 'Normal');

I_A = zeros(size(I)); %store the image segmented by regions pixel by pixel
for x = 1:size(I, 1)
    for y = 1:size(I, 2)
        prob1 = normpdf(I(x,y), p_ice_nor(1), p_ice_nor(2));
        prob2 = normpdf(I(x,y), p_water_nor(1), p_water_nor(2));
        I_A(x,y) = prob1 < prob2;
    end
end

figure; colormap hsv
imcontour(I_A, 1) %draws the contour of the regions

%% R2.b)
load("sar_image.mat");
ice = imcrop(I, [760 2453 949 188]);
water = imcrop(I, [1 1 629 1234]);
p_ice_nor = mle(ice(:), 'distribution', 'Normal');
p_water_nor = mle(water(:), 'distribution', 'Normal');

I_B = zeros(size(I)); %store the image segmented by regions by 9x9 patch of pixel
for x = 1:size(I, 1)
    for y = 1:size(I, 2)
        val = [];
        for a = -4:4
            for b = -4:4
                c = x + a;
                d = y + b;
                if(c > 0 && c <= size(I, 1) && d > 0 && d <= size(I, 2))                
                    val = [val I(c,d)];
                end
            end
        end
        prob1 = normpdf(val, p_ice_nor(1), p_ice_nor(2));
        prob2 = normpdf(val, p_water_nor(1), p_water_nor(2));
        I_B(x,y) = mean(prob1 < prob2) > 0.5;
    end
end

figure; colormap hsv
imcontour(I_B, 1)

%% R2.c)
load("sar_image.mat");
threshold = 90;
I_C = zeros(size(I)); %store the image segmented with a threshold
I_C = I > threshold;
figure; colormap hsv
imcontour(I_C, 1)

%% R2.d) needs to run R2.a-c) first
ice_C = imcrop(I_C, [760 2453 949 188]);
figure; colormap hsv
imcontour(ice_C, 1)
water_C = imcrop(I_C, [1 1 629 1234]);
figure; colormap hsv
imcontour(water_C, 1)
rate_ice_C = sum(ice_C(:))/prod(size(ice));
rate_water_C = 1 - sum(water_C(:))/prod(size(water));