function PSNR=full_search(pic_R, pic_T,range)
% read reference frame and target frame
R = imread(pic_R);
T = imread(pic_T);

% change to double type
R = double(R);
T = double(T);

[h w c] = size(R);

% initialize
p = int16(zeros(h/8,w/8)); % y-component of motion vector
q = int16(zeros(h/8,w/8)); % x-component of motion vector

% full search ME
tic % 計時開始
for x = 0:8:h-8
	for y = 0:8:w-8
        % initial 'min'
        min = T( (x+1:x+8), (y+1:y+8)) - R( (x+1:x+8), (y+1:y+8));
        min = sum(abs(min(:)));
        for i = -range:range
            for j = -range:range
                if (x+i+1>=1 && y+j+1>=1 && x+i+8<=h && y+j+8<=w)
                    avg = T( (x+1:x+8), (y+1:y+8) ) - R( (x+i+1:x+i+8), (y+j+1:y+j+8) );
                    avg = sum(abs(avg(:)));% city block distance between pixels
                    if avg < min
                        min = avg;
                        % motion vector(p,q)
                        p(floor((x+8)/8),floor((y+8)/8)) = j; 
						q(floor((x+8)/8),floor((y+8)/8)) = i;
                    end
                end
            end
        end
        % save the SAD for this block
        SAD(floor((x+8)/8),floor((y+8)/8)) = min;
	end
end
fprintf('==============================================\n');
fprintf('2D_Logarithm_Search\nReference Frame:%s\n Target Frame: %s \n Range: %d :\n',pic_R,pic_T,range);
toc % 計時結束，並把執行時間顯示在Command Window上
% compute matching image
for x = 0:h-1
    for y = 0:w-1
        p1 = p( (floor(x/8)+1), (floor(y/8)+1) ); 
        q1 = q( (floor(x/8)+1), (floor(y/8)+1) ); 
        matching_img(x+1,y+1) = R(x+1+q1,y+1+p1);
    end
end

% compute residual image
residual_img = T (:,:,1)- matching_img(:,:,1);

% prediction error(SAD) caculation and show it on Command Window
total_SAD=sum(SAD(:));
fprintf('SAD = %f\n', total_SAD);

% PSNR caculation and show it on Command Window
PSNR = psnr(T,matching_img,h,w,1);
fprintf('PSNR = %f\n', PSNR);

% output image
%imwrite(uint8(round(matching_img)), 'full_search_m.png');

%imwrite(uint8(round(residual_img)),'full_search_residual.png' );

%fprintf('full_search done!\n');
fprintf('==============================================\n');

end