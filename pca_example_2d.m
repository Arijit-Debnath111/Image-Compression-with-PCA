
Data_2d = [1.00 1.00 2.00 0.00 5.00 4.00 5.00 3.00;
3.00 2.00 3.00 3.00 4.00 5.00 5.00 4.00];
Data_2d = Data_2d';
Data_mean = mean(Data_2d);     
[a b] = size(Data_2d);
Data_meanNew = repmat(Data_mean,a,1);

% mean shifted data
X = Data_2d - Data_meanNew;

% Find Covariance data
cov_data = cov(X);  % X*Xt

% Find Eig values
[E, D] = eig(cov_data);

% Assign P = Et
P = transpose(E);
X_trans = transpose(X); 
% End of PCA code
      

% Image compression
PCs= 1;  ;%input('Enter number of PC colomuns needed?  ');                   

Reduced_E = E(:,1:2); % only pca1 - 0.28 variance

Y_projected=Reduced_E'* X_trans; % Projected data on reduced number of PCs                                      

% reconstructed data
Compressed_Data=Reduced_E*Y_projected; % E*Et*X   


% Add mean to see the compressed image
Compressed_Data = Compressed_Data' + Data_meanNew;  
Err = double(Compressed_Data - Data_2d);
PRESS = norm(Err,2) % Reconstruction error
syms = {'o' 's' '+' '*' 'x' 'd' '^' '.' 'v' '<' '>' 'p' 'h'};
c={'1'; '2'; '3'; '4'; '5'; '6';'7';'8'};
rc={'pca1'; 'pca2'; 'pca3'; 'pca4'; 'pca5'; 'pca6';'pca7';'pca8'};
hold on % important
h = gobjects(size(Data_2d,1)); 
for i = 1:size(Data_2d,1)
    % Assign the label to the legend string using DisplayName
    h(i) = scatter(Data_2d(i,1),Data_2d(i,2),36,[0 0 1],syms{i},'DisplayName',c{i});
    h(i) = scatter(Compressed_Data(i,1),Compressed_Data(i,2),36,[1 0 0],syms{i},'DisplayName',rc{i});
end
legend()

