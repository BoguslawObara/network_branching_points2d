%% clear
clc; clear all; close all;

%% path
addpath('./lib')
addpath('../vesselness2d/lib')
addpath('../blob2d/lib')

%% load image
im = imread('./im/leaf_network.png');

%% normalize
im = double(im); im = (im - min(im(:))) / (max(im(:)) - min(im(:))); 

%% vesselness2d
sigma = 1:1:5; gamma = 2; beta = 0.5; c = 15; wb = true;
[imv,v,vidx,vx,vy,l1,l2] = vesselnessv2d(imcomplement(im),sigma,gamma,beta,c,wb);

%% vector field variance
r = 5;
imvar = vector_field_var2d(imv,vx,vy,r);

%% blob detection
s = [3 3]; t = 0.20;
b = blob_detector2d(imvar,s,t);

%% plot
bp = round(b(:,1:2));
bp(bp<1) = 1;
bp(bp(:,1)>size(im,1),1) = size(im,1);
bp(bp(:,2)>size(im,2),2) = size(im,2);
immask = false(size(im));
immask(sub2ind(size(immask),bp(:,1),bp(:,2))) = 1;

se = strel('disk',5);
immask = imdilate(immask,se);

imr = im; img = im; imb = im;
imr(immask) = 1; img(immask) = 0; imb(immask) = 0;
imrgb = zeros(size(im,1),size(im,2),3);
imrgb(:,:,1) = imr; imrgb(:,:,2) = img; imrgb(:,:,3) = img;

figure; 
imagesc(imrgb); colormap gray; colormap jet; 
set(gca,'ytick',[]); set(gca,'xtick',[]); axis image; axis tight;

