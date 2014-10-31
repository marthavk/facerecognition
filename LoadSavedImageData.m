function LoadSavedImageData(dirname, ni, im_sfn)
%LOADSAVEDIMAGEDATA Loads ni images of the dirname folder

face_fnames = dir(dirname);
aa = 3:length(face_fnames);
a=randperm(length(aa));
fnums=aa(a(1:ni));
ii_ims = [];
for i=1:ni
    im_fname = [dirname, face_fnames(fnums(i)).name];
    [im ii_im] = LoadIm(im_fname);
    ii_ims = [ii_ims ; ii_im(:)'];
end
save(im_sfn, 'dirname', 'fnums', 'ii_ims');
end

