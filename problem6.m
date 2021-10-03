close all
clear all
clc

global label img currentlabel offset;

img = imread('images/WhiteMixComplex2019.tif');
img = imbinarize(rgb2gray(img(:,:,1:3)));

label = zeros(size(img));
count =0;
currentlabel = 1;
sz1 = size(img,1);
offset = [-sz1-1:-sz1+1 -1 +1 sz1-1:sz1+1];

for ind = 1:numel(img) 
    if img(ind)==1 && label(ind)==0
    labelconnected(ind);
    currentlabel = currentlabel + 1;            
    end
end

splitted_img = zeros([size(img) currentlabel-1]);
for shape_number = 1:currentlabel-1
    shape_img = zeros(size(img));
    [r, c] = find(label==shape_number);
    rc = [r c];
    for i = 1:size(rc,1)
        shape_img(rc(i,1),rc(i,2))=2;
    end
    figure(shape_number)
    imshow(shape_img)
    splitted_img(:,:,shape_number)=shape_img;
end

figure(10)
imshow(splitted_img)


function labelconnected(ind)
global label img currentlabel offset;
label(ind) = currentlabel;
%imshow(B, [])%, drawnow
neighbors = ind + offset;
neighbors(neighbors <= 0 | neighbors > numel(img)) = [];
for ind = neighbors
  if img(ind) == 1 && label(ind) == 0
    labelconnected(ind);
   end
end
end
