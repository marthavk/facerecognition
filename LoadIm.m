function [ im,ii_im ] = LoadIm(im_fname)

%read image
im = imread(im_fname);
if size(im,3) == 3
    im = rgb2gray(im);
end
im = double(im);

%image normalization
sigma = std(im(:));
im = (im-mean(im(:)))/(sigma+0.0000000000000000001);

%integral image
ii_im = cumsum(cumsum(im,1),2);

end