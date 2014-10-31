function all_ftypes = EnumAllFeatures(W,H)

all_ftypes=[];
% use index i for sanity check with return values: [all_ftypes,i]
% i=0;
for w = 1:W-2
    for h = 1:floor(H/2)-2
        for x = 2:W-w
            for y = 2:H-2*h
                all_ftypes = [all_ftypes;[1,x,y,w,h]];
%                 i=1+i;
            end
        end
    end
end

for w = 1:floor(W/2)-2
    for h = 1:H-2
        for x = 2:W-2*w
            for y = 2:H-h
                all_ftypes = [all_ftypes;[2,x,y,w,h]];
%                 i=1+i;
            end
        end
    end
end

for w = 1:floor(W/3)-2;
    for h = 1:H-2;
        for x = 2:W-3*w;
            for y =2:H-h;
                all_ftypes = [all_ftypes;[3,x,y,w,h]];
%                 i=1+i;
            end
        end
    end
end

for w = 1:floor(W/2)-2;
    for h = 1:floor(H/2)-2;
        for x = 2:W-2*w;
            for y = 2:H-2*h;
                all_ftypes = [all_ftypes;[4,x,y,w,h]];
%                 i=1+i;
            end
        end
    end
end

end

