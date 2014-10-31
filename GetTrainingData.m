function GetTrainingData(all_ftypes, np, nn) 
%GETTRAININGDATA Compute and Save training data extracted from both face
%and non-face images
%np number of face images
%nn number of non face images

%load face images
dirname = 'TrainingImages/FACES/';
im_sfn = 'FaceData.mat';
LoadSavedImageData(dirname, np, im_sfn);

%load non-face images
dirname = 'TrainingImages/NFACES/';
im_sfn = 'NonFaceData.mat';
LoadSavedImageData(dirname, nn, im_sfn);

%compute and save face data
f_sfn = 'FeaturesToUse.mat';
ComputeSaveFData(all_ftypes, f_sfn);


end

