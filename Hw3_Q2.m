clearvars
% close all
clc


%% Initialize Program

[~,~,u0,D] = LoadData;

[y,x] = size(u0); % Get the dimensions important for differencing
u0 = u0(:); % Reshape the image into a vector: L-R columns stack T-B
D = D(:);

% Pick some parameters here
maxIter = 20;
lmda = 0.5;
% r = 0.1;
r = 0.075;
B_nxt = zeros(y*x,2);


%% Construct Operators
% y = 3; x = 4;
n = y*x;
e = ones(n,1);
e1 = ones(n,1);
for i = y:y:n
    e1(i) = 0;
end
e2 = ones(n,1);
for i = y+1:y:n
    e2(i) = 0;
end

% Lapalcian
L = spdiags([e e1 -4*e e2 e],[-y -1 0 1 y],n,n);

% x-Gradient
Dx = spdiags([-e e],[0 y],n,n);

% y-Gradient
Dy = spdiags([e1 -e],[-1 0],n,n);

% x-Divergence
e3 = ones(n,1);
e3(end-y+1:end) = 0;
Divx = spdiags([-e e3],[-y 0],n,n);

% y-Divergence
e4 = ones(n,1);
for i = y:y:n
    e4(i) = 0;
end
e5 = ones(n,1);
for i = 1:y:n
    e5(i) = 0;
end
Divy = (spdiags([-e5 e4],[-1 0],n,n)).';



%% Augmented Lagrangian Iteration
D2 = spdiags(1-D,0,n,n);
p_nxt = [Dx*u0 Dy*u0];
u_nxt = u0;
for j = 1:maxIter
    u = u_nxt;
    B = B_nxt;
    p = p_nxt;
    
%     divr = Divx*(B(:,1)-p(:,1)) + Divy*(B(:,2)-p(:,2));
    divr = Divx*(B(:,1)-p(:,1)) + Divy*(B(:,2)-p(:,2));
    [u_nxt,flag] = cgs(-r*L + lmda*D2, lmda*(1-D).*u0 + r*divr,[],20); % Just do 1 iteration of cgs
    
    u_grad = [Dx*u_nxt Dy*u_nxt];
    p_nxt = shrnk(r,u_grad+B,2);
    
    B_nxt = B + u_grad - p_nxt;
    
end


%% Plot results
u = reshape(u_nxt,y,x);
u0 = reshape(u0,y,x);

figure(1), pcolor(flipud(u0)), title('Noisy'), shading interp, colormap gray
figure(2), pcolor(flipud(u)), title('Clean'), shading interp, colormap gray






