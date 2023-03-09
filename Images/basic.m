location1 = fullfile("C:\Users\uddha\OneDrive\Desktop\Stuff\Images");

images = imageDatastore(location1, "FileExtensions",{'.jpg', '.jpeg', '.png'});
maxAvgH = 0;
maxAvgS = 0;
maxAvgV = 0;

dataH = 0;
dataS = 0;
dataV = 0;
%{
for i = 1:length(images.Files)
    data = readimage(images, i);
    % code from MATLAB site
    if ~ismatrix(data)          % Only process 3-dimensional color data        
        hsv = rgb2hsv(data);    % Compute the HSV values from the RGB data 
        
        h = hsv(:,:,1);         % Extract the HSV values
        s = hsv(:,:,2);            
        v = hsv(:,:,3);            

        avgH = mean(h(:));      % Find the average HSV values across the image
        avgS = mean(s(:));
        avgV = mean(v(:));
        
        if avgH > maxAvgH       % Check for new maximum average hue
           maxAvgH = avgH;
           dataH = data;
        end

        if avgS > maxAvgS       % Check for new maximum average saturation
           maxAvgS = avgS;
           dataS = data;
        end

        if avgV > maxAvgV       % Check for new maximum average brightness
           maxAvgV = avgV;
           dataV = data;
        end
    end
    
end
%}
figure
rgbImg = readimage(images, 2);
imshow(rgbImg,'InitialMagnification','fit');
for i = 1:length(rgbImg(:, 1, 1))
    for j = 1: length(rgbImg(1, :, 1))
       if rgbImg(i, j, 1) > 0

            rgbImg(i, j, 1) = rgbImg(i, j, 1);
            rgbImg(i, j, 2) = rgbImg(i, j, 2) - i;
            rgbImg(i, j, 3) = rgbImg(i, j, 3) - j*0.2;
        end
    end
end
figure
imshow(rgbImg,'InitialMagnification','fit');
title('Increase rgb');
%{
figure
imshow(dataS,'InitialMagnification','fit');
title('Maximum Average Saturation');

figure
imshow(dataV,'InitialMagnification','fit');
title('Maximum Average Brightness');
%}