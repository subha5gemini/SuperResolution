function fin = deblur(res,NSR)

PSF = fspecial('gaussian',[3 3],1);
im_recon = deconvwnr(res, PSF, NSR);
im_recon = im_recon*80;
% fin = im_recon;
figure;imshow(im_recon);
title('Restored Image')
