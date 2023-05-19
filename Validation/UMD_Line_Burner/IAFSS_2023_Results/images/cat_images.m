% McDermott
% 8 Feb 2023
% cat_images.m

close all
clear all

I1 = imread('propane_tri_coarse.png');
I2 = imread('propane_tri_medium.png');
I3 = imread('propane_tri_fine.png');

combImg = cat(2,I1,I2)
imshow(combImg);