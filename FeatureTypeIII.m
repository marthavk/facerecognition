function f = FeatureTypeIII( ii_im,x,y,w,h )

%F3(x,y,w,h) = B(x+w,y,w,h)-B(x,y,w,h)-B(x+2w,y,w,h)
f = ComputeBoxSum(ii_im,x+w,y,w,h)-ComputeBoxSum(ii_im,x,y,w,h)-ComputeBoxSum(ii_im,x+2*w,y,w,h);

end