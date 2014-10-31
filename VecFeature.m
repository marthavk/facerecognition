function ftype_vec = VecFeature(ftype, W, H);
%VECFEATURE Calculation of the column vector required to compute the
%response for a feature defined by ftype. So for instance features of type
%I can be calulated with 
%ftype_vec = VecBoxSum(x,y,w,h,W,H)-VecBoxSum(x,y+h,w,h,W,H)
%

x = ftype(2);
y = ftype(3);
w = ftype(4);
h = ftype(5);

switch(ftype(1))
    case {1}
        ftype_vec = VecBoxSum(x,y,w,h,W,H)-VecBoxSum(x,y+h,w,h,W,H);
    case {2}
        ftype_vec = VecBoxSum(x+w,y,w,h,W,H)-VecBoxSum(x,y,w,h,W,H);
    case {3}
        ftype_vec = VecBoxSum(x+w,y,w,h,W,H)-VecBoxSum(x,y,w,h,W,H)-VecBoxSum(x+2*w,y,w,h,W,H);
    case {4}
        ftype_vec = VecBoxSum(x+w,y,w,h,W,H)+VecBoxSum(x,y+h,w,h,W,H)-VecBoxSum(x,y,w,h,W,H)-VecBoxSum(x+w,y+h,w,h,W,H);
    otherwise
        error('ftype not supported');
end
        
        


end

