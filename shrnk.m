function out = shrnk(r,y,p)

% out = shrnk(r,y,p) calculates the the maximum between 0 and 1-1/r|y|^p
% and returns that value times y

y1 = y(:,1); y2 = y(:,2);
rght1 = 1-1./(r*abs(y1));
rhgt1(rght1 < 0) = 0;
rght2 = 1-1./(r*abs(y2));
rhgt2(rght2 < 0) = 0;

out = [rght1.*y1 rght2.*y2];



% right = 1-1./(r*norm(y(:,1).^2 + y(:,2).^2,p)); % For our algorithm the data y is a matrix
% out = max([0 right])*y;

end