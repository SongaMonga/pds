%% R1.b)
clear all; close all
load("sar_image.mat");
colormap cool %apply a different color mapping to better distinguish ice from water
imagesc(I);

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
clear all; close all
load("sar_image.mat");
ice = imcrop(I, [760 2453 949 188]);
water = imcrop(I, [1 1 629 1234]);
p_ice_nor = mle(ice(:), 'distribution', 'Normal');
p_water_nor = mle(water(:), 'distribution', 'Normal');
ice_nor = normpdf(ice(:), p_ice_nor(1), p_ice_nor(2));
water_nor = normpdf(water(:), p_water_nor(1), p_water_nor(2));

for x = 1:size(I, 1)
    for y = 1:size(I, 2)
        dist1 = ice_nor(I(x,y));
        dist2 = water_nor(I(x,y));
        if(dist1 < dist2)
            I(x,y) = 1;
        else
            I(x,y) = 0;
        end
    end
end

figure; imcontour(I)

%% R2.b)

%% R2.c)

%% R2.d)