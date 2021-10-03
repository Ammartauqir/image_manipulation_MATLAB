clear all
close all
clc
img_sqr = rgb2gray(imread('images/WhiteSquare2019.tif'));
img_rect = rgb2gray(imread('images/WhiteRectangle2019.tif'));
img_tri = imread('images/WhiteTriangle2019.tif');
img_dimd = imread('images/WhiteDiamond2019.tif');
img_dimd = rgb2gray(img_dimd(:,:,1:3));
img_tri = rgb2gray(img_tri(:,:,1:3));

figure(1)
corners  = detectHarrisFeatures(img_sqr) ;
imshow(img_sqr); hold on;
plot(corners);
hold off;

figure(2)
corners  = detectHarrisFeatures(img_rect) ;
imshow(img_rect); hold on;
plot(corners);
hold off;


figure(3)
corners  = detectHarrisFeatures(img_dimd) ;
imshow(img_dimd); hold on;
plot(corners);
hold off;

