clear all;
%% 0 Initialize x,y,w,h,W,H
clc
W=19;
H=19;
x = 12;
y = 14;
w = 5;
h = 6;
%% 1 Initial image processing
clc
[im ii_im] = LoadIm('face00001.bmp');
dinfo1 = load('DebugInfo/debuginfo1.mat');
eps = 1e-6;
sum(abs(dinfo1.im(:) - im(:)) > eps)
sum(abs(dinfo1.ii_im(:) - ii_im(:)) > eps)
clear dinfo1;
%% 2 Sum of pixel values within a rectangular region
clc
sum(sum(im(y:y+h-1, x:x+w-1)))
ComputeBoxSum(ii_im, x, y, w, h)

%% 7 Enum all features
clc
all_ftypes = EnumAllFeatures(W,H);
save('all_ftypes.mat', 'all_ftypes');

%% 8 Compute Feature
DirName = 'TrainingImages/FACES';
mystr = [DirName, '/*.bmp'];
im_files = dir(mystr);
ii_ims1=cell(1,100);
for i=1:100
[foo, temp] = LoadIm(im_files(i).name);
ii_ims1{i} = temp;
end
dinfo3 = load('DebugInfo/debuginfo3.mat');
ftype = dinfo3.ftype;
a = sum(abs(dinfo3.fs - ComputeFeature(ii_ims1,ftype,1))>eps)
clear dinfo3 foo temp i ftype;

%% 9 Vectorization of BoxSum
clc
clear a;
b_vec = VecBoxSum(x,y,w,h,19,19);
ii_im(:)'*b_vec
ComputeBoxSum(ii_im, x,y,w,h)

%% 11 Vec All Features
clc
fmat = VecAllFeatures(all_ftypes, W, H);

%% 12 Vec Compute Feature
clc
ii_ims = zeros(100, W*H);
for i=1:100
[foo, temp] = LoadIm(im_files(i).name);
ii_ims(i,:) = temp(:)';
end

fs1 = VecComputeFeature(ii_ims, fmat(:,1));
fs2 = ComputeFeature(ii_ims, all_ftypes(1,:),0);
%debug
sum(sum(fs1'-fs2))>eps

%% 13 14 Load and Save Image Data / Compute and Save FData
dirname = 'TrainingImages/FACES/';
clear fnums ii_ims fmat;
dinfo4 = load('DebugInfo/debuginfo4.mat');
ni=dinfo4.ni;
all_ftypes = dinfo4.all_ftypes;
im_sfn = 'FaceData.mat';
f_sfn = 'FeaturesToMat.mat';
rng(dinfo4.jseed);
LoadSavedImageData(dirname, ni, im_sfn);
ComputeSaveFData(all_ftypes, f_sfn);
load('FeaturesToMat');
load('FaceData');
sum(sum(dinfo4.fmat - fmat))
sum(sum(dinfo4.ii_ims-ii_ims))

%% 15 and final code for Task I
dinfo5 = load('DebugInfo/debuginfo5.mat');
np = dinfo5.np;
nn=dinfo5.nn;
all_ftypes=dinfo5.all_ftypes;
rng(dinfo5.jseed);
GetTrainingData(all_ftypes, np, nn); %takes some time! (some minutes)

Fdata = load('FaceData.mat');
NFdata = load('NonFaceData.mat');
FTdata = load('FeaturesToUse.mat');


