clearvars
% close all
clc


%% Initialize Program

[A,b,u0] = LoadDataForCompressiveSensing;
[y,x] = size(A);

% Pick some parameters here
r1 = 100;
r2 = 0.1;
maxIter = 200;


%% Construct Operators
LHS = r1*(A'*A) + r2*speye(x);


%% Augmented Lagrangian Iteration
u_nxt = u0;
lmda_nxt = A*u0-b;
p_nxt = u0;
mu_nxt = u0-p_nxt;
data1 = zeros(1,maxIter);
data2 = zeros(1,maxIter);
for j = 1:maxIter
    u = u_nxt;
    p = p_nxt;
    lmda = lmda_nxt;
    mu = mu_nxt;
    
    [u_nxt,flag] = cgs(LHS, r1*A'*(b-lmda) + r2*(p-mu),[],20);
%     u_nxt = cgs(LHS, r1*A'*(b-lmda) + r2*(p-mu),[],200);
%     p_nxt = shrnk3(u_nxt - mu,r2);
    p_nxt = (1-1./(r2*abs(u_nxt + mu))).*(u_nxt + mu);
    lmda_nxt = lmda + A*u_nxt - b;
    mu_nxt = mu + u_nxt - p_nxt;
    
    data1(j) = norm(A*u_nxt - b,inf);
    if (norm(A*u_nxt - b,inf) < 1e-10)
        break;
    end
    data2(j) = sum(u_nxt < 1e-12);
end


%% Plot results
data1 = data1(1:j);
plot(1:j,data1);
% plot(1:maxIter,data1,'r',1:maxIter,data2,'b');






