clear
Data_gray = imread('butterfly512.gif');       
gray = 0.2989 * Data_gray(:,:,1) + 0.5870 * Data_gray(:,:,2) + 0.1140 * Data_gray(:,:,3);
Data_grayD = double(gray);
%imshow(uint8(Data_grayD))
% im_name = strcat('dog_gray','.jpg');
% imwrite(uint8(gray),im_name,'jpg')
% Find mean

Data_mean = mean(Data_grayD);     
[a b] = size(gray);
Data_meanNew = repmat(Data_mean,a,1);

% mean shifted data
X = Data_grayD - Data_meanNew;

% Find Covariance data
cov_data = cov(X);  % X*Xt

% Find Eig values
[E, D] = eig(cov_data);

% Assign P = Et
P = transpose(E);
X_trans = transpose(X); 
% End of PCA code
      

% Image compression
PCs= 120  ;%input('Enter number of PC colomuns needed?  ');                   
PC_remove = b - PCs;                                                        
Reduced_E = E(:,b-PCs+1:b);                                                        

Y_projected=Reduced_E'* X_trans; % Projected data on reduced number of PCs                                      

% reconstructed data
Compressed_Data=Reduced_E*Y_projected; % E*Et*X   


% Add mean to see the compressed image
Compressed_Data = Compressed_Data' + Data_meanNew;  
Compressed_Data = uint8(Compressed_Data);
Err = double(Compressed_Data - gray);
PRESS = norm(Err,2) % Reconstruction error


% Write the compressed image
im_name = strcat('butterfly_',num2str(PCs),'.jpg');
imwrite((Compressed_Data),im_name,'jpg')
figure
title(im_name)
imshow(Compressed_Data)


