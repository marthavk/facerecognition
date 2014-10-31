function fs = ComputeFeature( ii_ims, ftype )

% p=size(ii_ims,1);
p = length(ii_ims);
x = ftype(2);
y = ftype(3);
w = ftype(4);
h = ftype(5);
fs = zeros(1,100);
for i=1:p
    if(ftype(1) ==1)
        fs(i) = FeatureTypeI(ii_ims,x,y,w,h);
    elseif(ftype(1) == 2)
        fs(i) = FeatureTypeII(ii_ims,x,y,w,h);
    elseif(ftype(1) == 3)
        fs(i) = FeatureTypeIII(ii_ims,x,y,w,h);
    elseif(ftype(1) == 4)
        fs(i) = FeatureTypeIV(ii_ims,x,y,w,h);
    end
end


end

