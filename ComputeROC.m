%f_detected(length(fnontrain)+i,:) = [0,score(length(fnontrain)+i,2)>threshold];

function  ComputeROC( Cparams, Fdata, NFdata )

%images for training
faces = load (Fdata);
nonfaces = load(NFdata);
fnums = faces.fnums;
nfnums = nonfaces.fnums;

%directories
fdir = 'TrainingImages/FACES/*.bmp';
nfdir = 'TrainingImages/NFACES/*.bmp';

%images not for training
fnontrain = setdiff(3:size(dir(fdir),1), fnums);
nfnontrain = setdiff(3:size(dir(nfdir),1), nfnums);

%set score=0 ,  (column1)=score , set (column2)=label(face/nface)
sc=zeros(length(fnontrain)+length(nfnontrain),2);

%run ApplyDetector
im_files = dir(fdir);
for i=1:size(fnontrain,2)
    [foo, temp] = LoadIm(im_files(fnontrain(i)).name);

    face_scores(i) = ApplyDetector(Cparams, temp);
end
face_labels = ones(size(fnontrain,2),1);
im_files = dir(nfdir);
for i=1:size(nfnontrain,2)
    [foo, temp] = LoadIm(im_files(nfnontrain(i)).name);
    nonface_scores(i) = ApplyDetector(Cparams, temp);
end
nonface_labels = zeros(size(nfnontrain,2),1);
scores = [face_scores nonface_scores]';
labels = [face_labels ; nonface_labels];

%% TODO
%with one threshold value
%compute threshold
threshold = 0.5*sum(Cparams.alphas);
results = scores>threshold;
%
min = min(scores);
max = max(scores);
threshold = linspace(min, max, 100);


end
