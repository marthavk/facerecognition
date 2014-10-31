function fpic = MakeFeaturePic( ftype, W, H )
%MAKEFEATUREPIC: Creates an image representing a feature
%Creates a matrix WxH with values 1 and -1 which correspond 
%to the feature type in params 
%fpic = MakeFeaturePic( ftype, W, H )
%Inputs:  ftype  1x5  Feature type 
%         W      1x1  Width
%         H      1x1  Height
%Outputs: fpic   WxH  output picture

%initialization
x = ftype(2);
y = ftype(3);
w = ftype(4);
h = ftype(5);


%create zero matrix
fpic = zeros(H,W);

%image representing the feature
if (ftype(1) == 1)
    fpic(y:y+h-1 , x:x+w-1) = -1;
    fpic(y+h:y+2*h-1 , x:x+w-1) = 1;
elseif (ftype(1) == 2)
    fpic(y:y+h-1 , x+w:x+2*w-1) = -1;
    fpic(y:y+h-1 , x:x+w-1) = 1;
elseif (ftype(1) == 3)
    fpic(y:y+h-1 , x+w:x+2*w-1) = -1;
    fpic(y:y+h-1 , x:x+w-1) = 1;
    fpic(y:y+h-1 , x+2*w:x+3*w-1) = 1;
elseif (ftype(1) ==4)
    fpic(y+h:y+2*h-1 , x:x+w-1) = -1;
    fpic(y:y+h-1 , x+w:x+2*w-1) = -1;
    fpic(y:y+h-1 , x:x+w-1) = 1;
    fpic(y+h:y+2*h-1 , x+w:x+2*w-1)= 1;
    
end


end

