function imv = vector_field_var2d(im,imvx,imvy,r)
%%  vector_field_var2d - 2d vector field variance
%   
%   REFERENCE:
%       B. Obara, M. Fricker, V. Grau, 
%       Contrast independent detection of branching points in network-like 
%       structures, SPIE Medical Imaging, 83141L, 
%       4-9 February, San Diego, CA, USA, 2012
%
%   INPUT:
%       im      - first image
%       imx     - vector field x image
%       imy     - vector field y image
%       r       - radius
%
%   OUTPUT:
%       imv     - vector field variance image
%
%   AUTHOR:
%       Boguslaw Obara

[xs,ys] = size(im);
imv = zeros([xs,ys]);
for x=1:xs
    for y=1:ys
        x1 = max(1,x-r); x2 = min(xs,x+r); 
        y1 = max(1,y-r); y2 = min(ys,y+r); 
        [xg,yg] = meshgrid(x1:x2,y1:y2);
        idx1 = find( ((xg-x).^2 + (yg-y).^2) <= r^2);
        idx2 = sub2ind([xs,ys],xg(idx1),yg(idx1));
        v = [imvx(idx2) imvy(idx2)];
        w = im(idx2);

        theta = atan2(abs(v(:,2)),abs(v(:,1)));
        [vc,~,~] = circular_var(theta, w);
        if ~isnan(vc)
            imv(x,y) = vc;            
        else
            imv(x,y) = 0;
        end
    end
end
imv = im.*imv;

%% normalize
imv = double(imv); imv = (imv - min(imv(:))) / (max(imv(:)) - min(imv(:)));

end