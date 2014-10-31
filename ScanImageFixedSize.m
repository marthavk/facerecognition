function dets = ScanImageFixedSize(Cparams, im)
%SCANIMAGEFIXEDSIZE: Applies a learnt classifier to an image to detect
%faces in the image. The detector is applied in every possible subwindow of
%the image to detect all faces in the image. 
%Inputs:    Cparams:    struct contining all the parameters of the detector:
%                          all_ftypes: [16373x5 double]
%                          fmat:       [(W*H)x16373 double]
%                          alphas:     [Tx1 double]
%                          thetas:     [Tx3 double]
%           im:         the image to be processed
%Outputs:   dets: ndx4  the parameters of the bounding boxes (sub-windows) 
%                       classified as faces 
%                           nd: the number of face detections
%                           4:  x,y,w,l

%sub window height and width = 19x19
h = 19;
w = 19;
L = 19;
%If necessary convert to grayscale

if length(size(im)) == 3
    im = rgb2gray(im);
end
im = double(im);
%Compute square of the image
imSquared = im.*im;
%Compute integral images
ii_im  = cumsum(cumsum(im, 1), 2);
ii_imSquared = cumsum(cumsum(imSquared,1),2);
[H,W]=size(im);
%Threshold for classification
%threshold = 0.5*sum(Cparams.alphas);
threshold = 8;
%initialize dets
dets = [];
fmat = sparse(Cparams.fmat);
for y=1:H-h+1
    for x=1:W-w+1
        %each sub window has an upper left corner at (x,y) 
        %and w,h as width and height respectively
        
        %% Compute mu and sigma of the sub-window
        if(x==1&&y==1)
            A = ii_im(y+L-1,x+L-1);
            B = ii_imSquared(y+L-1,x+L-1);
        elseif (x==1)
            A = ii_im(y+L-1,x+L-1) - ii_im(y-1, x+L-1);
            B = ii_imSquared(y+L-1,x+L-1) - ii_imSquared(y-1, x+L-1);

        elseif (y==1)
            A = ii_im(y+h-1,x+w-1) - ii_im(y+h-1, x-1);
            B = ii_imSquared(y+h-1,x+w-1) - ii_imSquared(y+h-1, x-1);
        else
            A = ii_im(y+h-1,x+w-1) - ii_im(y+h-1,x-1) - ii_im(y-1,x+w-1) + ii_im(y-1,x-1);
            B = ii_imSquared(y+h-1,x+w-1) - ii_imSquared(y+h-1,x-1) - ii_imSquared(y-1,x+w-1) + ii_imSquared(y-1,x-1);
        end
        mu = A/(L*L);
        sigma = sqrt((1/(L*L-1))*(B-L*L*mu*mu));
%         mu = (1/(L*L))*ComputeBoxSum(ii_im,x,y,L,L);
%         sigma = sqrt((1/(L*L-1))*(ComputeBoxSum(ii_imSquared,x,y,L,L)-L*L*mu*mu));
        %normalize sub-window
        sub_window = im(y:y+h-1,x:x+w-1);
        %sub_window_n = (sub_window-mu)/(sigma+1.0000e-19);
        %compute integral image of sub-window
        ii_sub_window = cumsum(cumsum(sub_window,1),2);
        %% APPLY DETECTOR:
        sc=0;
        for i = 1:size(Cparams.alphas,1)
            fw = Cparams.all_ftypes(Cparams.thetas(i,1),4);
            fh = Cparams.all_ftypes(Cparams.thetas(i,1),5);
           %extract each feature
           % f = ii_sub_window(:)'*Cparams.fmat(:,Cparams.thetas(i,1));
            f = ii_sub_window(:)'*fmat(:, Cparams.thetas(i,1));

            %check feature type
            type = Cparams.all_ftypes(Cparams.thetas(i,1),1);
            if (type==3)
                f = (1/sigma)*f + fw*fh*mu/sigma;
            else
                f = (1/sigma)*f;
            end
            %compute score
            sc = sc + Cparams.alphas(i)*(Cparams.thetas(i,3)*f < Cparams.thetas(i,3)*Cparams.thetas(i,2));
        end
%          sc = ApplyDetector(Cparams, ii_sub_window, mu, sigma);
        %%
        if sc>threshold
            dets = [dets; x,y,w,h];
        end

    end
end
        

end