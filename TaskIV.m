im = imread('TestImages/one_chris.png');
load('Cparams.mat')
dets = ScanImageFixedSize(Cparams,im);
DisplayDetections(im,dets);
%%
im1=imread('TestImages/big_one_chris.png');
scdets=ScanOverScale(Cparams,im1,0.6,1.3,0.06);
DisplayDetections(im1,scdets)