function f = FeatureTypeI( ii_im,x,y,w,h )

%F1(x,y,w,h) = B(x,y,w,h)-B(x,y+h,w,h)
f = ComputeBoxSum(ii_im,x,y,w,h)-ComputeBoxSum(ii_im,x,y+h,w,h);

end