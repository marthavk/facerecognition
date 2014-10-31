function [ theta, p, err ] = LearnWeakClassifier( ws, fs, ys )
%LEARNWEAKCLASSIFIER: Implements a weak classifier. It takes as input the
%vector of weights associated with each training image, a vector containing
%the value of a particular feature extracted from each training image and
%a vector of the labels associated with each training image. The outputs
%are then the learnt parameters of the weak classifier and its associated
%error.
%
%Inputs:  ws  1xn   a set of non-negative weights
%         fs  1xn   a set of feature responses {fj(x1),...,fs(xn)} 
%                   extracted by applying the feature fj to each training 
%                   image xi 
%         ys  1xn   associated labels {y1, ... , yn}  where yi takes values
%                   0 or 1
%
%Outputs: theta  1x1  threshold value
%         p      1x1  parity value (p=1 or p=-1)
%         err    1x1  error value (err>0)


%%compute the weighted mean of the positive (mp) and negative (mn) examples
mp = sum(ws.*fs.*ys) / sum(ws.*ys);
mn = sum(ws.*fs.*(1-ys)) / sum(ws.*(1-ys));

%set threshold
theta = 0.5*(mp+mn);

%error associated with the two possible values of parity
en = sum(ws.*abs(ys - (fs > theta)));
ep = sum(ws.*abs(ys - (fs <= theta)));

%returns the min(err) and its p
if en<ep
    err=en;
    p=-1;
else
    err=ep;
    p=1;
end


end

