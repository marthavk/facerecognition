function fmat = VecAllFeatures(all_ftypes,W,H);
%VECALLFEATURES Will generate the column vectors used to generate each
%feature defined in all_ftypes.
%Inputs:  all_ftypes nf x 5   contains all ftypes in the format [ftype,x,y,w,h]
%         W          1x1      Width of original image
%         H          1x1      Height of original image
%Outputs: fmat       W*H x nf Each column corresponds to a feature
nf = size(all_ftypes,1);
fmat = zeros(W*H, nf);
for i=1:nf
    fmat(:,i) = VecFeature(all_ftypes(i,:),W,H);
end 


end

