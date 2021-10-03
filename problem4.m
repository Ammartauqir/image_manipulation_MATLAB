clear all
close all
clc

img = imread('images/WhiteDiamond2019.tif');
img = rgb2gray(img(:,:,1:3));

[y, x] = ndgrid(1:size(img, 1), 1:size(img, 2));
non_zero_x = x(logical(img));
non_zero_y = y(logical(img));
centroid = mean([non_zero_x, non_zero_y]);
imshow(img); hold on;
plot(centroid(1),centroid(2),'-*','MarkerEdgeColor','red');



%Finding bounding boxes
x_max = max(non_zero_x);
x_min = min(non_zero_x);
y_max = max(non_zero_y);
y_min = min(non_zero_y);
bounding_box_vertices = [x_min y_max; x_min y_min; x_max y_min; x_max y_max];
faces_to_connect = [1 2 3 4];
patch('Faces',faces_to_connect,'Vertices',bounding_box_vertices,'EdgeColor','green','FaceColor','none','LineWidth',1)

% Applying sobel filter for edge detection
kx= [1 ,0 ,-1; 1,0,-1; 1, 0 ,-1];
ky= [1,1,1; 0,0, 0; -1, -1 ,-1];
H = conv2(im2double(img),kx,'same');
V = conv2(im2double(img),ky,'same');
E = sqrt(H.*H + V.*V);
E = imbinarize(E);

B = bwboundaries(E);
B = B{1, 1};
boundry_img = zeros(size(E));
for i = 1:size(B,1)
    boundry_img(B(i,1),B(i,2)) = 1;
end


figure(2)
imshow(boundry_img, []);
hold on;
parameter = nnz(boundry_img);
[row ,col] = find(boundry_img);
edge_pixels = [row ,col];

count2 =0;
slope_arr = [];
ar = [];
minimize_equ = 20;
% Making equ of lines passing from two edge points
for i = 1:size(edge_pixels,1)
   for j = 1:size(edge_pixels,1)
       if(i~=j)
           P1 = [edge_pixels(i,1) edge_pixels(i,2)];
           P2 = [edge_pixels(j,1) edge_pixels(j,2)];
           
           m = (P2(2)-P1(2))/(P2(1)-P1(1));
           n = P1(1)*m - P1(2);
           % if mx-b-y near to zero
           minimize = m*centroid(2)- n -centroid(1); 
           ar = [ar minimize];
           
           if minimize<minimize_equ
               minimize_equ = minimize;
              points = [P1 ; P2];  
           end
       end
   end 
end

D1 = pdist2([row col],[row col],'euclidean');

[value,column] = max(max(D1));
[~,row] = max(D1(:,column));
P_X = [edge_pixels(row,2) edge_pixels(column,2)];
P_Y = [edge_pixels(row,1) edge_pixels(column,1)];
           
line(P_X,P_Y,'color','r') 
plot(edge_pixels(row,2),edge_pixels(row,1),'-*','MarkerEdgeColor','green')
plot(edge_pixels(column,2),edge_pixels(column,1),'-*','MarkerEdgeColor','blue')


m = (P_Y(2)-P_Y(1))/(P_X(2)-P_X(1));
n = P_Y(1)*m - P_X(1);
theta =   atan(m) ;   
%Angle
Deg = rad2deg(theta);
% Area 
area = size(img(logical(img)),1);
% Circularity
circularity = (4 * pi * area)./(parameter .^ 2) ;


