function out = shrnk3(r,y)

% out = shrnk(r,y,p) calculates the the maximum between 0 and 1-1/r|y|^p
% and returns that value times y


out = (1-1./(r*abs(y))).*y;



% right = 1-1./(r*norm(y(:,1).^2 + y(:,2).^2,p)); % For our algorithm the data y is a matrix
% out = max([0 right])*y;

end