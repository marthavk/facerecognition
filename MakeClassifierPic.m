function cpic = MakeClassifierPic( all_ftypes, chosen_f, alphas, ps, W, H )
%MAKECLASSIFIERPIC: Takes an input of the array defining each feature, a 
%vector chosen_f of positive integers that correspond to the features used 
%in the classifier and the weights alphas associated with each feature / 
%weak classifier. 
%Creates a matrix cpic of zeros of size(H,W) and for each feature in 
%chosen_f creates its picture.
%cpic = MakeClassifierPic( all_ftypes, chosen_f, alphas, ps, W, H )
%Inputs:    all_ftypes Nx5 	contains all possible feature types for a WxH
%                           image
%           chosen_f   1xm  m:number of features
%                           chosen_f is a vector of positive integers that 
%                           correspond to the features used in the 
%                           classifier  
%           alphas     1xm  the weights associated to each feature/weak
%                           classifier
%Output:    cpic            the weighted sum of each newly created picture


%create zero matrix
cpic = zeros(H,W);

%create cpic
for i = 1:length(chosen_f)
    cpic = cpic + ps(i)*alphas(i)*MakeFeaturePic(all_ftypes(chosen_f(i),:),W,H);
end

end

