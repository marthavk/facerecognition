function dets = ScanOverScale( Cparams, im, min_s, max_s, step_s )

dets =[];
for i = min_s:step_s:max_s
%     temp_dets = ScanImageFixedSize(Cparams, imresize(im,i));
%     temp_dets(:,3) = temp_dets(:,3)/i;
%     temp_dets(:,4) = temp_dets(:,4)/i
    dets = [dets; ScanImageFixedSize(Cparams, imresize(im,i))/i];
end


end

