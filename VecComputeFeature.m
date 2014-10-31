function fs = VecComputeFeature (ii_ims, ftype_vec);
%VECCOMPUTEFEATURE Extracts the feature defined by ftype_vec from each
%integral image defined in ii_ims
%Inputs:    ii_ims     ni x W*H   contains all integral images we want to process
%           ftype_vec  W*H x 1    column vector containing te description of a feature
%Output:    fs         ni x 1     contains the feature of all integral images

fs = ii_ims*ftype_vec; 

end

