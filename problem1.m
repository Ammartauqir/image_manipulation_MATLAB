clear all
close all
clc
AppleTree_img = imread('images\AppleTree.png');
red_channel = AppleTree_img(:,:,1);
green_channel = AppleTree_img(:,:,2);
blue_channel = AppleTree_img(:,:,3);
red_min_green = red_channel - green_channel;
red_min_blue = red_channel - blue_channel;

img_size = size(green_channel);
count = 0;
cor_x = [] ;
cor_y = [] ;
fprintf('Cordinates:(y,x)\n\n')
for y = (1:img_size(1))
    for x = ((1:img_size(2)))
    if(red_min_green(y,x)>50 & red_min_blue(y,x)>50)
        if (red_channel(y,x)>(blue_channel(y,x)+green_channel(y,x)))
            fprintf('Apple coordinates: (%i,%i) \n', y,x)
        end
    end
    end
end
