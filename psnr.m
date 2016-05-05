function PSNR = psnr(img_ori, img_new, m, n, c)
sum = 0;

for i = 1:m
    for j = 1:n
        for k = 1:c
            sum = sum + (img_ori(i,j,k)-img_new(i,j,k))^2;
        end
    end
end
MSE = sum/(m*n*c);
PSNR = 10*log10(255*255/MSE); 
end
