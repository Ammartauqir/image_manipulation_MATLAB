clear all
close all
clc
img = imread('cameraman.tif');
% Display original image.
figure(1);
imshow(img);
title('Original Image');
[rows, columns] = size(img);
[X,Y] = meshgrid(1:columns,1:rows);
xi_reduce = linspace(1,columns,rows/2); 
yi_reduce = linspace(1,rows,columns/2); 
xi_expand = linspace(1,columns,rows*2); 
yi_expand = linspace(1,rows,columns*2); 
[Xi_reduce,Yi_reduce] = meshgrid(xi_reduce,yi_reduce) ; 
[Xi_expand,Yi_expand] = meshgrid(xi_expand,yi_expand) ; 

reduced_Image = uint8(interp2(X,Y,double(img),Xi_reduce,Yi_reduce));
expanded_Image = uint8(interp2(X,Y,double(img),Xi_expand,Yi_expand));


figure(2);
imshow(reduced_Image);
title('Shrinked Image');

figure(3);
imshow(expanded_Image);
title('Expanded Image');