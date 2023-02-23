function TC = H2RGB(img,a,b,c) 

TC(:,:,1) = img(:,:,a);
TC(:,:,2) = img(:,:,b);
TC(:,:,3) = img(:,:,c);


end