function sc = ApplyDetector(Cparams, ii_im, mu, sigma)
%Computes the Score of the integral image
%Inputs:    Cparams:    struct contining all the parameters of the detector:
%                          all_ftypes: [16373x5 double]
%                          fmat:       [(W*H)x16373 double]
%                          alphas:     [Tx1 double]
%                          thetas:     [Tx3 double]
%           ii_im   19x19  the integral image
%
%           IF mu AND sigma ARE OMITTED THEN WE ASSUME THAT THE PICTURE IS
%           NORMALIZED
%           mu      1x1     the mean of the original image
%           sigma   1x1     the standar deviation of the original image
%            
%Outputs:   sc      1x1     the score of the image

if nargin<4
    mu = 0;
    sigma = 1;
end

%w=19;
%h=19;
sc=0;

for i = 1:size(Cparams.alphas,1);
    w = Cparams.all_ftypes(Cparams.thetas(i,1),4);
    h = Cparams.all_ftypes(Cparams.thetas(i,1),5);
    %extract each feature
    f = ii_im(:)'*Cparams.fmat(:,Cparams.thetas(i,1));
    %check feature type
    type = Cparams.all_ftypes(Cparams.thetas(i,1),1);
    if (type==3)
        f = (1/sigma)*f + w*h*mu/sigma;
    else
        f = (1/sigma)*f;
    end
    
    %compute score
    sc = sc + Cparams.alphas(i)*(Cparams.thetas(i,3)*f < Cparams.thetas(i,3)*Cparams.thetas(i,2));
end

end
