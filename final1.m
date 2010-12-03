% Final exam - problem 1
% Thanh Doan 

p1data = dataset('file','Final1.data', 'delimiter',',');             
X  = [p1data.X1, p1data.X2];
[n,p] = size(X);

xbar = mean(X)';
S = cov(X);
S_inv = inv(S);

mu_prime = [6;12 ];
T_sq = n*(xbar-mu_prime)'*S_inv*(xbar-mu_prime);

critvalue = (p*(n-1)/(n-p)) * finv(.95,p,n-p);

% The direction and lengths of axes of ellipsoid
%   n * (xbar - mu)'*inv(S)*(xbar - mu) 
%       <= c^2 = [p(n-1)/(n-p)]*F(.95, p, n-p)     
% are:
[v d] = eig(S);
ellipse_center = xbar;
disp(ellipse_center);
for i = 1:size(d,2)
    lambda = d(i,i);
    half_len = sqrt(lambda) * sqrt( (p*(n-1)/(n*(n-p))) * finv(.95,p,n-p) );
    fprintf('Axis %d, half-length = %10.4f, direction:  \n', i, half_len);
    disp(v(:,i));    
end

theta = [0:0.1:360]';
theta = theta .* (pi/180);
a = sqrt(d(1,1))*sqrt(((p*(n-1))/(n*(n-p)))*finv(0.95,p,n-p)) .* v(:,1);
b = sqrt(d(2,2))*sqrt(((p*(n-1))/(n*(n-p)))*finv(0.95,p,n-p)) .* v(:,2);
for i = 1:length(theta)
    x(i) = xbar(1) + a(1)*sin(theta(i)) + b(1)*cos(theta(i));
    y(i) = xbar(2) + a(2)*sin(theta(i)) + b(2)*cos(theta(i));
end

plot(x,y);
hold on
axis equal
plot(xbar(1),xbar(2),'r*');
hold off