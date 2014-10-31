function b_vec = VecBoxSum(x, y, w, h, W, H)

%VECBOXSUM Computes the correct b_vec so that ii_im(:)'*b_vec will 
%correspond to the sum of the pixel intensities in a rectangle defined by 
%(x, y, w, h) 
%
% Remember in ComputeBoxSum function
% A = ii_im(y+h-1,x+w-1) - ii_im(y+h-1,x-1) - ii_im(y-1,x+w-1) + ii_im(y-1,x-1);
% We have to find which are the corresponding coordinates in an array of
% size W*H so we can set them to 1, -1, -1 and 1 respectively
%
% Example: 
% The following array 
% a(y,x) = | 1  2  3  4  |
%          | 5  6  7  8  |
%          | 9 10 11 12  | 
% with the transformation a(:)' would be transformed into the array
% b(x') = [1  5  9  2  6  10  3  7  11 4  8  12]  
% so the new coordinates will now correspond to
%
% y' = (x-1)*H + y
%
% So will find the mappings
% (y + h - 1 , x + w -1 ) --> y1
% (y + h - 1 , x - 1 )    --> y2
% (y - 1 , x + w - 1 )    --> y3
% (y - 1 , x - 1 )        --> y4


b_vec = zeros(W*H, 1);

y1 = (x+w-2)*H + y+h-1;
y2 = (x-2)*H + y+h-1;
y3 = (x+w-2)*H + y-1;
y4 = (x-2)*H + y-1;

b_vec(y1) = 1;
b_vec(y2) = -1;
b_vec(y3) = -1;
b_vec(y4) = 1;

end

