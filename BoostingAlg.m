function Cparams = BoostingAlg (Fdata, NFdata, FTdata, T, verbose)
%BOOSTINGALG: Implementation of the AdaBoost algorithm. The inputs of this
%function are the training data obtained from the positive and negative
%images and the number of weak classifiers T to include in the final strong
%classifier. The output is then the structure representing the final
%classifier.
%More specifically, the AdaBoost algorithm takes as input a set of feature
%vectors {fx1,...,fxn} extracted from each example image xi and associated
%labels {y1,..yn} where yi=0 denotes a negative example while yi=1 a
%positive one. m is the number of negative examples.
%
%Cparams = BoostingAlg (Fdata, NFdata, FTdata, T)
%
%Inputs: Fdata, NFdata, FTdata: .mat files containing the training data
%        T:                     the number of weak classifiers used in the
%                               final strong classifier
%        verbose:               set to 1 to use the first 1000 features     
%Output: Cparams:
%            Cparams.alphas:   Tx1        represent the alpha weights in  
%                                         eq.(4), algorithm 1.
%            Cparams.thetas:   Tx3        the parameters of the weak 
%                                         classifiers.
%                                         thetas (: , 1) = j
%                                         thetas (: , 2) = theta
%                                         thetas (: , 3) = p     
%            Cparams.fmat      (WxH) x nf contains column vectors which are
%                                         then used to generate each 
%                                         feature defined in all_ftypes.
%                                         nf is the multitude of all
%                                         different feature types.
%            Cparams.allftypes nf x 5     all feature types.

%% Load Data
Cparams = struct;
faces = load (Fdata);
nonfaces = load(NFdata);
ft_data = load(FTdata);
% faces = load ('FaceData.mat');
% nonfaces = load('NonFaceData.mat');
% ft_data = load('FeaturesToUse.mat');
%%ii_ims_faces = face_data.ii_ims;
%%ii_ims_nonfaces = nonface_data.ii_ims;
Cparams.all_ftypes = ft_data.all_ftypes;
if (verbose == 1)
    Cparams.fmat = ft_data.fmat(:, 1:1000);
else
    Cparams.fmat = ft_data.fmat;
end
Cparams.alphas = [];
Cparams.thetas = [];

%Compute a set of feature vectors {fx1,...,fxn} extracted from each example
%image xi and the associated labels {y1,...,yn} where yi = 0 denotes a
%negative example while yi = 1 denotes a positive one. 

% n = number of all examples
n = size(faces.ii_ims,1) + size(nonfaces.ii_ims,1);
% m = number of negative examples
m = size(nonfaces.ii_ims,1);
% nf = number of all ftypes
nf = size(Cparams.fmat,2);

% extract feature vectors 
% ft_data.fmat: (WxH) x nf      (361x16373)
% faces.ii_ims: (n-m) x (WxH)   integral images for face data (2000x361)
% fs_faces:     (n-m) x nf      (2000x16373) 
% ys_faces:     (n-m) x 1       (2000x1)
fs_faces = faces.ii_ims*Cparams.fmat;
ys_faces = ones(n-m, 1);
% nonfaces.ii_ims: m x (WxH)    integral images for nonface data (4000x361)
% fs_nonfaces:     m x nf       (4000x16373)
% ys_nonfaces:     m x n        (4000x1)
fs_nonfaces = nonfaces.ii_ims*Cparams.fmat;
ys_nonfaces = zeros(m, 1);
% fs: n x nf  (6000x16373) a set of feature vectors extracted from each
%                          example image xi
% ys: n x 1   (6000x1)     the associated labels
fs = [fs_faces ; fs_nonfaces];
ys = [ys_faces ; ys_nonfaces];

%initialize weights:
w = zeros(n,1);
for i = 1 : n
    if (ys(i)==0)
        w(i) = 1/(2*m);
    else
        w(i) = 1/(2*(n-m));
    end
end

for t = 1 : T
    %normalize weights so they sum to one
    w = w / norm (w,1);

    %for each feature j train a weak classifier h restricted to using this
    %feature that tries to minimize the error
    theta = zeros(nf,1);
    p = zeros(nf,1);
    err = zeros(nf,1);   
    for j = 1 : nf
        [theta(j), p(j), err(j)] = LearnWeakClassifier(w, fs(:,j), ys); 
    end

    %choose the weak classifier with the lowest error
    [et, argm] = min(err);
    h = p(argm)*fs(:,argm)<p(argm)*theta(argm);

    %set thetas and err
    Cparams.thetas = [Cparams.thetas ; argm theta(argm) p(argm)];
    
    %update the weights
    beta = et / (1-et);        
    w = w.*(repmat(beta,n,1).^(1-abs(h-ys)));
    
    %set alphas
    alpha = log(1/beta);
    Cparams.alphas = [Cparams.alphas; alpha];

end

end

