% From
% http://www.mathworks.com/help/toolbox/stats/bq_676m-2.html#bq_676m-39

% Linear models describe a linear relationship between a response variable
% and one or more predictive variables. 

% Linear models have the following characteristics:
%   - At each set of values for the predictors, the response ~ normal
%       distribution with mean ?.
%   - A coefficient vector b defines a linear combination Xb of the
%       predictors X.
%   - The model is ? = Xb.

% In GLMs, these characteristics are generalized as follows:
%    - At each set of values for the predictors, the response has a distribution 
%       that may be normal, binomial, Poisson, gamma, or inverse Gaussian, 
%        with parameters including a mean ?.
%    - A coefficient vector b defines a linear combination Xb of the predictors X.
%    - A link function f defines the model as f(?) = Xb.

% Example:

% The following data are derived from carbig.mat, which contains
% measurements of large cars of various weights.

% Each weight in w has a corresponding number of cars in total 
% and a corresponding number of poor-mileage cars in poor:

w = [2100 2300 2500 2700 2900 3100 ...
     3300 3500 3700 3900 4100 4300]';
total = [48 42 31 34 31 21 23 23 21 16 17 21]';
poor = [1 2 0 3 8 8 14 17 19 15 17 21]';

% Plot shows the proportion of poor-mileage cars follows an S-shaped sigmoid:
plot(w,poor./total,'x','LineWidth',2);
grid on;
xlabel('Weight');
ylabel('Proportion of Poor-Mileage Cars');

% The logistic model is useful for proportion data. 
% It defines the relationship between the proportion p and the weight w by:

%   log[p/(1 � p)] = b1 + b2w

% Some of the proportions in the data are 0 and 1, making the left-hand
% side of this equation undefined. To keep the proportions within range, 
% add relatively small perturbations to the poor and total values. 


% A semi-log plot then shows a nearly linear relationship, as predicted by
% the model.

p_adjusted = (poor+.5)./(total+1);
plot(w,p_adjusted,'x','LineWidth',2);
grid on;
xlabel('Weight');
ylabel('Proportion of Poor-Mileage Cars');

p_adjusted = (poor+.5)./(total+1);
semilogy(w,p_adjusted./(1-p_adjusted),'x','LineWidth',2);
grid on;
xlabel('Weight');
ylabel('Adjusted  p / (1 - p)');

% It is reasonable to assume that the values of poor follow binomial
% distributions, with the number of trials given by total and the
% percentage of successes depending on w. This distribution can be
% accounted for in the context of a logistic model by using a generalized
% linear model with link function log(�/(1 � �)) = Xb 

% Use the glmfit function to carry out the associated regression:

b = glmfit(w,[poor total],'binomial','link','logit');
disp(b);

% To use the coefficients in b to compute fitted proportions, invert the
% logistic relationship:

p = 1./(1 + exp(-b(1) - b(2).*w));

% Use the glmval function to compute the fitted values:
x = 2100:100:4500;
y = glmval(b,x,'logit');

plot(w,poor./total,'x','LineWidth',2)
hold on
plot(x,y,'r-','LineWidth',2)
grid on
xlabel('Weight')
ylabel('Proportion of Poor-Mileage Cars')




