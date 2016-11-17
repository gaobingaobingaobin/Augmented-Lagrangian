function [A b x_t] = LoadDataForCompressiveSensing

%%%%%% A is the sensing matrix, b is the measurement 
%%%%%%  x_t is the ground truth

m = 100;
n = 1000;
sparsity = 20;
A = rand(m,n);
x_t = zeros(n,1);
idx = randi(n,sparsity,1);
x_t(idx) = randn(length(idx),1);
b = A*x_t;
