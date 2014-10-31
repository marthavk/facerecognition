function DisplayDetections( im, dets )

%im = imread(im);

imagesc(im);
axis equal
hold on
for i = 1:size(dets,1)
%     x1 = dets(i,1);
%     x2 = dets(i,3);
%     y1 = dets(i,2);
%     y2 = dets(i,4);
%     x = [x1,x1,x2,x2,x1];
%     y = [y1,y2,y2,y1,y1];
%     plot(x,y)
    rectangle('Position', dets(i,:));
end
hold off

end

