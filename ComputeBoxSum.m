function A = ComputeBoxSum( ii_im,x,y,w,h )
%COMPUTEBOXSUM Computes the sum of pixel intensities in the rectangle
%defined by x, y, w, h where:
%x: the x coordinate of the upper left corner
%y: the y coordinate of the upper left corner
%w: the width of the rectangle
%h: the height of the rectangle
if(x==1&&y==1)
    A = ii_im(y+h-1,x+w-1);
elseif (x==1)
    A = ii_im(y+h-1,x+w-1) - ii_im(y-1, x+w-1);
elseif (y==1)
    A = ii_im(y+h-1,x+w-1) - ii_im(y+h-1, x-1);
else
    A = ii_im(y+h-1,x+w-1) - ii_im(y+h-1,x-1) - ii_im(y-1,x+w-1) + ii_im(y-1,x-1);
end

end