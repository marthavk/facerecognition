clc;
clear all;
%%
load Cparams100;
im_fname = 'TestImages/facepic1.jpg';
im = imread(im_fname);
%%
profile on;

%dets = ScanImageFixedSize(Cparams, im);
dets = ScanOverScale(Cparams, im, 0.2, 1.0, 0.1);


DisplayDetections(im, dets);
profile viewer


profile off;