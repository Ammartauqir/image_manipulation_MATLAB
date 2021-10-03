clear all
close all
clc
img = imread('cameraman.tif');
x1=zeros([size(img,1)*size(img,2) 1]);
x2=zeros([size(img,2)*size(img,1) 1]);

imshow(img);
%Specifying degree
deg=30;
%Defining new empty image 
C=uint8(zeros([size(img,1)  size(img,2) 3 ]));

m=1;
%Finding the midpoint
midx=ceil((size(C,1)+1)/2);
midy=ceil((size(C,2)+1)/2);

for i=1:size(img,1)
    i1=i-midx;
    for j=1:size(img,2)
        %convert from cartesian to polar
        [t,r]=cart2pol(i1,j-midy);
        %Convert from radians to degree and add the degree value
        t1=rad2deg(t)+deg;
        %Convert from degree to radians
        t=deg2rad(t1);
        %Convert to Cartesian Co-ordinates
        [x,y]=pol2cart(t,r);
        x1(m)=round(x+midx);
        x2(m)=round(y+midy);
        m=m+1;
    end
   
end
%checking whether the values are within the image size.
x1(x1 < 1)=1;
x2(x2 < 1)=1;

n=1;
for i=1:size(img,1)
    for j=1:size(img,2)
        C(x1(n),x2(n),:)=img(i,j,:);
       
        n=n+1;
    end
   
end
imshow(C);