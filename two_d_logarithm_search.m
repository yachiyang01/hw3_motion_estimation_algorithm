function PSNR=two_d_logarithm_search(pic_R, pic_T,range)
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
SAD = int16(zeros(h/8,w/8));

% 2D log search ME
tic % 計時開始
for x = 0:8:h-8
	for y = 0:8:w-8
        % initial the center
        x_center = floor((x+x+8)/2);
        y_center = floor((y+y+8)/2);
        % save the original center
        x_center_ori = floor((x+x+8)/2);
        y_center_ori = floor((y+y+8)/2);
        % initial 'min' and 'd'
        min = abs(T( (x_center_ori-3:x_center_ori+4), (y_center_ori-3:y_center_ori+4) ) - R( (x_center-3:x_center+4), (y_center-3:y_center+4) ));
        min = sum(abs(min(:)));
        d_plum=floor(log2(range)); %d=15
        d = max(2,2^d_plum-1);
        while (d >= 1)
            i_temp = 0;
        	j_temp = 0;
            for i = -d:d:d
                for j = -d:d:d
                    if ( (d ~= 1) && (i == j || i == -j) );% d != 1時只做五個點
                    else % d = 1時做九個點
                        if (x_center+i-3>=1 && y_center+j-3>=1 && x_center+i+4<=h && y_center+j+4<=w)
                            avg = T( (x_center_ori-3:x_center_ori+4), (y_center_ori-3:y_center_ori+4) ) - R( (x_center+i-3:x_center+i+4), (y_center+j-3:y_center+j+4) );
                            avg = sum(abs(avg(:)));
                            if avg < min
                                min = avg;
                                i_temp = i;
                                j_temp = j;
                            end
                        end
                    end
                end
            end
            % motion vector(p,q)
            p(floor((x+8)/8),floor((y+8)/8)) = p(floor((x+8)/8),floor((y+8)/8)) + j_temp; 
            q(floor((x+8)/8),floor((y+8)/8)) = q(floor((x+8)/8),floor((y+8)/8)) + i_temp;
            % new center
            x_center = x_center + i_temp;
            y_center = y_center + j_temp;
            % next 'd'
            if (d == 1) 
                break;
            end
            if (i_temp == 0 && j_temp == 0)
                d = floor(d/2);
            end
        end
        % caculate the SAD for this block
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


% compute residual images
residual_img = abs(T(:,:,1)- matching_img(:,:,1));

% prediction error(SAD) caculation and show it on Command Window
total_SAD=sum(SAD(:));
fprintf('SAD = %f\n', total_SAD);

% PSNR caculation and show it on Command Window
PSNR = psnr(T,matching_img,h,w,1);
fprintf('PSNR = %f\n', PSNR);
% output image
%imwrite(uint8(round(matching_img)), '2D_logarithm_search_matching_img.png');

%imwrite(uint8(round(residual_img)), '2D_logarithm_search_residual_img.png');
%fprintf('2D_logarithm_search_matching_img done!\n');
imwrite(uint8(round(residual_img)), '2Dimg.png');

fprintf('==============================================\n');

end