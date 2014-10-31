clear all;

%% 16. Learn Weak Classifiers
load FeaturesToUse.mat
load FaceData.mat
ftype_vec = fmat(:,12028);
fs_faces = VecComputeFeature(ii_ims, ftype_vec);
ys_faces = ones(size(fs_faces , 1), 1);
load NonFaceData.mat
fs_nonfaces = VecComputeFeature(ii_ims, ftype_vec);
ys_nonfaces = zeros(size(fs_nonfaces, 1), 1);
fs = [fs_faces ; fs_nonfaces];
ys = [ys_faces ; ys_nonfaces];
%ws = rand(size(ys,1),1);
%ws = ws / norm(ws,1);
ws = 1/size(fs,1) * ones(size(fs,1),1);
[theta, p, err] = LearnWeakClassifier(ws, fs, ys);

%%
[elem_f, cent_f] = hist(fs_faces);
[elem_nf, cent_nf] = hist(fs_nonfaces);
elem_f = elem_f / size(fs_faces,1);
elem_nf = elem_nf / size(fs_nonfaces,1);
%%
figure
hold on;
plot(cent_nf, elem_nf, 'bo-');
plot(cent_f, elem_f, 'ro-');
plot([theta theta], [0 0.45], 'black');
hold off

%% 17. Make Feature Picture
fpic = MakeFeaturePic([4,5,5,5,5], 19, 19);
figure;
imagesc(fpic)
colormap(gray)

%% 18. Make Classifier Picture
cpic = MakeClassifierPic(all_ftypes, [5192, 12765], [1.8725, 1.467], [1,-1], 19, 19);
figure;
colormap(gray);
imagesc(cpic)

%% 19. Boosting Algorithm
clear all;
FTdata = 'FeaturesToUse.mat';
Fdata = 'FaceData.mat';
NFdata = 'NonFaceData.mat';
Cparams = BoostingAlg(Fdata, NFdata, FTdata, 3, 1)

fpic1 = MakeFeaturePic(Cparams.all_ftypes(Cparams.thetas(1,1),:), 19, 19);
fpic2 = MakeFeaturePic(Cparams.all_ftypes(Cparams.thetas(2,1),:), 19, 19);
fpic3 = MakeFeaturePic(Cparams.all_ftypes(Cparams.thetas(3,1),:), 19, 19);
fpic = [fpic1 fpic2 fpic3];
chosen_f = Cparams.thetas(:,1);
ps = Cparams.thetas(:,3);

cpic = MakeClassifierPic(Cparams.all_ftypes, chosen_f, Cparams.alphas, ps, 19,19);

figure;
colormap(gray);
imagesc(fpic);

figure;
colormap(gray);
imagesc(cpic);

%% Debug Point 6
dinfo6 = load('DebugInfo/debuginfo6.mat');
T = dinfo6.T;
Cparams = BoostingAlg(Fdata, NFdata, FTdata, T, 1);
eps = 1e-6;
sum(abs(dinfo6.alphas-Cparams.alphas)>eps)
sum(abs(dinfo6.Thetas(:)-Cparams.thetas(:))>eps)

Cparams = BoostingAlg(Fdata, NFdata, FTdata, 1, 0);
cpic = MakeClassifierPic(Cparams.all_ftypes, Cparams.thetas(1), Cparams.alphas, Cparams.thetas(2), 19,19);
imagesc(cpic)
colormap(gray);
%% Debug Point 7
dinfo7 = load('DebugInfo/debuginfo7.mat');
T = dinfo7.T;
% Cparams = BoostingAlg(Fdata, NFdata, FTdata, T, 0);
% save('Cparams');
load('Cparams.mat');
sum(abs(dinfo7.alphas - Cparams.alphas)>eps);
sum(abs(dinfo7.Thetas(:)-Cparams.thetas(:))>eps);

%montage images
I = [];
for i=1:T
    fpic = MakeFeaturePic(Cparams.all_ftypes(Cparams.thetas(i,1),:), 19, 19);
    I = [I fpic];
end
chosen_f = Cparams.thetas(:,1);
ps = Cparams.thetas(:,3);
cpic = MakeClassifierPic(Cparams.all_ftypes, chosen_f, Cparams.alphas, ps, 19,19);
figure;
imagesc(I);
title('Initial features chosen by boosting');
colormap(gray);
figure;
imagesc(cpic);
title('The final strong classifier');
colormap(gray);
