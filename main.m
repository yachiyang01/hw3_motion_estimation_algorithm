clear all;close all;clc;

%Assume (i) caltrain001.bmp is the reference frame, the rest are target frames
%(ii) caltrain001.bmp and caltrain011.bmp are reference frames, and the rest are target frames

%=========================================================

%problem (a)
%Compare the total SAD values by using the two ME methods. 
%Show the residual images (caltrain002.bmp, caltrain010.bmp, caltrain012.bmp, and caltrain020.bmp) 
%in the above two cases for using the two ME methods
%=========================================================

%case(i)


%function full_search(pic_R, pic_T,range)

%full_search('bmp/caltrain001.bmp','bmp/caltrain002.bmp',8);
%full_search('bmp/caltrain001.bmp','bmp/caltrain010.bmp',8);
%full_search('bmp/caltrain001.bmp','bmp/caltrain012.bmp',8);
%full_search('bmp/caltrain001.bmp','bmp/caltrain020.bmp',8);
%full_search('bmp/caltrain011.bmp','bmp/caltrain002.bmp',8);
%full_search('bmp/caltrain011.bmp','bmp/caltrain010.bmp',8);
%full_search('bmp/caltrain011.bmp','bmp/caltrain012.bmp',8);
%full_search('bmp/caltrain011.bmp','bmp/caltrain020.bmp',8);
%full_search('bmp/caltrain001.bmp','bmp/caltrain002.bmp',16);
%full_search('bmp/caltrain001.bmp','bmp/caltrain010.bmp',16);
%full_search('bmp/caltrain001.bmp','bmp/caltrain012.bmp',16);
%full_search('bmp/caltrain001.bmp','bmp/caltrain020.bmp',16);
%full_search('bmp/caltrain011.bmp','bmp/caltrain002.bmp',16);
%full_search('bmp/caltrain011.bmp','bmp/caltrain010.bmp',16);
%full_search('bmp/caltrain011.bmp','bmp/caltrain012.bmp',16);
%full_search('bmp/caltrain011.bmp','bmp/caltrain020.bmp',16);
%two_d_logarithm_search('bmp/caltrain001.bmp','bmp/caltrain002.bmp',8);
%two_d_logarithm_search('bmp/caltrain001.bmp','bmp/caltrain010.bmp',8);
%two_d_logarithm_search('bmp/caltrain001.bmp','bmp/caltrain012.bmp',8);
%two_d_logarithm_search('bmp/caltrain001.bmp','bmp/caltrain020.bmp',8);
%two_d_logarithm_search('bmp/caltrain011.bmp','bmp/caltrain002.bmp',8);
%two_d_logarithm_search('bmp/caltrain011.bmp','bmp/caltrain010.bmp',8);
%two_d_logarithm_search('bmp/caltrain011.bmp','bmp/caltrain012.bmp',8);
%two_d_logarithm_search('bmp/caltrain011.bmp','bmp/caltrain020.bmp',8);
%two_d_logarithm_search('bmp/caltrain001.bmp','bmp/caltrain002.bmp',16);
%two_d_logarithm_search('bmp/caltrain001.bmp','bmp/caltrain010.bmp',16);
%two_d_logarithm_search('bmp/caltrain001.bmp','bmp/caltrain012.bmp',16);
%two_d_logarithm_search('bmp/caltrain001.bmp','bmp/caltrain020.bmp',16);
%two_d_logarithm_search('bmp/caltrain011.bmp','bmp/caltrain002.bmp',16);
%two_d_logarithm_search('bmp/caltrain011.bmp','bmp/caltrain010.bmp',16);
%two_d_logarithm_search('bmp/caltrain011.bmp','bmp/caltrain012.bmp',16);
%two_d_logarithm_search('bmp/caltrain011.bmp','bmp/caltrain020.bmp',16);

%function two_d_logarithm_search(pic_R, pic_T,range);
%two_d_logarithm_search('bmp/caltrain001.bmp','bmp/caltrain020.bmp',8);


%=========================================================
% poblem (b)
% plot all psnr(including (i) & (ii)) and compare results
%=========================================================



 for index=1:20
    if index==1
        continue;
    elseif index<=9
        str=['caltrain00' num2str(index) '.bmp'];
    else
        str=['caltrain0' num2str(index) '.bmp'];
    end
    
   two_d_logarithm_psnr=two_d_logarithm_search('caltrain001.bmp',str,16);
   full_search_psnr=full_search('caltrain001.bmp',str,16);

   full(index)=full_search_psnr;
   two(index)=two_d_logarithm_psnr;
 

 end
 for index=1:20
    if index==11
        continue;
    elseif index<=9
        str=['caltrain00' num2str(index) '.bmp'];
    else
        str=['caltrain0' num2str(index) '.bmp'];
    end
  
    
   two_d_logarithm_psnr_11=two_d_logarithm_search('caltrain011.bmp',str,16);
   full_search_psnr_11=full_search('caltrain011.bmp',str,16);


   two_11(index)=two_d_logarithm_psnr_11;
   full_11(index)=full_search_psnr_11;

 end
    figure(1),plot(full)
    xlabel('Frame')           %X座標名稱
    ylabel('PSNR')           %Y座標名稱
    title('Full Search(case (i))');        %圖的名稱
    figure(2),plot(two)
    xlabel('Frame')           %X座標名稱
    ylabel('PSNR')           %Y座標名稱
    title('2D Logarithm Search(case (i))');        %圖的名稱;
    figure(3),plot(full_11)
    xlabel('Frame')           %X座標名稱
    ylabel('PSNR')           %Y座標名稱
    title('Full Search(case (ii))');
    figure(4),plot(two_11) 
    xlabel('Frame')           %X座標名稱
    ylabel('PSNR')           %Y座標名稱
    title('2D Logarithm Search(case (ii))');        %圖的名稱;;    
    fprintf('problme(b) done!\n');

