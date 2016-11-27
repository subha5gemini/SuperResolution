function res = NLinterpolate(images,shifts,dfact)                                   

n=length(images);
s = size(images{1});
if (length(s)==2) 
    s=[s 1]; 
end

% compute the coordinates of the pixels from the N images.

for i=1:n % for each image
    s_c{i}=images{i};    
    r{i} = [1:dfact:dfact*s(1)]'*ones(1,s(2)); % create matrix with row indices
    c{i} = ones(s(1),1)*[1:dfact:dfact*s(2)]; % create matrix with column indices
    r{i} = r{i}-shifts(i,2);     
    c{i} = c{i}-shifts(i,1);
    if (r{i}>0)&(r{i}<=dfact*s(1))&(c{i}>0)&(c{i}<=dfact*s(2))
        rn{i} = r{i};
        cn{i} = c{i};
        sn{i} = s_c{i};
    end
end

 s_ = []; r_ = []; c_ = []; 
for i=1:n % for each image
    s_ = [s_; sn{i}];
    r_ = [r_; rn{i}];
    c_ = [c_; cn{i}];
end
 clear s_c r c coord rn cn sn

 % interpolate the high resolution pixels using bilinear interpolation
 rec_col = griddata(c_,r_,s_,[1:s(2)*dfact],[1:s(1)*dfact]','linear'); 
 res(:,:) = reshape(rec_col,s(1)*dfact,s(2)*dfact);
 res(isnan(res))=0;