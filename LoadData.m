function [I_exact I_noise I_contaminated D] = LoadData



I_exact = imread('data/cameraman.png');
I_exact = double(I_exact);
r = 20
I_noise = I_exact + r*randn(size(I_exact));
% figure; 
% subplot(1,3,1);
% a
% title('Clean image','FontSize',20);
% subplot(1,3,2);
% imshow(I_noise,[]);
% title('Noisy image','FontSize',20);


% Construct inpainting region
[x,y] = meshgrid(1:size(I_exact,2),1:size(I_exact,1));
[th,r] = cart2pol(x-size(I_exact,2)/2,y-size(I_exact,1)/2);
D = (sin(r/2+th) > 0.75);   %%%%% the indicator function of the inpainting domain

I_contaminated = I_exact;
I_contaminated(D) = rand(nnz(D),1);

% subplot(1,3,3);
% imshow(I_contaminated,[]);
% title('contaminated','FontSize',20);