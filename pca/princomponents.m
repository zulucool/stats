% From http://www.mathworks.com/help/toolbox/stats/brkgqnt.html#f14047
% in multivariate datasets,  groups of variables might move together. 
% this is true if more than one variable measures the same driving principle 
% governing the behavior of the system. I
% n many systems there are only a few such driving forces... but an abundance 
% of instrumentation enables us to measure dozens of system variables. 
% When this happens, we can simplify the problem by replacing a group of variables 
% with a single new variable.

% PCA generates a new set of variables, called principal components. 
% Each principal component is a linear combination of the original variables. 
% All the principal components are orthogonal to each other, so there is no redundant information. 
% The principal components as a whole form an orthogonal basis for the space of the data.


% The first principal component is a single axis in space. 
% When we project each observation on that axis, the resulting values form 
% a new variable. And the variance of this variable is the maximum among 
% all possible choices of the first axis.

% The second principal component is another axis in space, perpendicular to the first. 
% Projecting the observations on this axis generates another new variable. 
% The variance of this variable is the maximum among all possible choices of this second axis.

% The full set of principal components is as large as the original set of variables. 
% It is common for the sum of the variances of the first few principal components 
% to exceed 80% of the total variance of the original data. 

% By examining plots of these few new variables, researchers often develop 
% a deeper understanding of the driving forces that generated the original data.

% Computing Components.  Consider a sample application that uses nine different 
% indices of the quality of life in 329 U.S. cities. These are climate, housing, 
% health, crime, transportation, education, arts, recreation, and economics. 

% For each index, higher is better. e.g. a higher index for crime means a lower crime rate.

%load in the data in cities.mat.
load cities;
disp(categories);
disp(names);

%  get a quick impression of the ratings data
% substantially more variability in the ratings of the arts and housing 
% than in the ratings of crime and climate.
boxplot(ratings,'orientation','horizontal','labels',categories);

% if we graph pairs of the  variables, there would be 36 two-variable plots. 
% Perhaps PCA can reduce the number of variables we need to consider.


% it is appropriate to compute principal components for raw data when all 
% variables are in the same units. Standardizing the data is often 
% preferable when the variables are in different units or when the variance 
% of the different columns is substantial (as in this case).
cov(ratings);

%standardize the data by dividing each column by its standard deviation.
stdr = std(ratings);
sr = ratings./repmat(stdr,329,1);

% find the principal components.
[coefs,scores,variances,t2] = princomp(sr);

% four outputs from princomp.
% Component Coefficients.  coefs contains the coefficients of the linear 
% combinations of the original variables that generate the principal components. 
% The coefficients are also known as loadings.

% The first three principal component coefficient vectors are:
c3 = coefs(:,1:3);
disp(c3);

% The largest coefficients in the first principal component are the third 
% and seventh elements, corresponding to the variables health and arts. 
% All the coefficients of the first principal component have the same sign, 
% making it a weighted average of all the original variables.

%The principal components are unit length and orthogonal:
I = c3'*c3;
disp(I);

% The second output, scores, contains the coordinates of the original data 
% in the new coordinate system defined by the principal components. 
% This output is the same size as the input data matrix.

% A plot of the first two columns of scores shows the ratings data 
% projected  onto the first two principal components. 
% princomp computes the scores to have mean zero.
plot(scores(:,1),scores(:,2),'+');
xlabel('1st Principal Component');
ylabel('2nd Principal Component');

% function gname is useful for graphically identifying a few points in a plot. 
% call gname with a string matrix containing as many case labels as points 
%in the plot. The string matrix names works for labeling points with the city names.
gname(names);

% To remove the labeled cities from the data, first identify their corresponding row numbers as follows:

% 1. Close the plot window.

% 2. Redraw the plot by entering

    plot(scores(:,1),scores(:,2),'+');
    xlabel('1st Principal Component');
    ylabel('2nd Principal Component');

% 3. Enter gname without any arguments.
    gname;
    
% 4. Click near the points you labeled in the preceding figure. 
% This labels the points by their row numbers, as shown in the following figure.

% Then create an index variable containing the row numbers of all the metropolitan areas. 
metro = [43 65 179 213 234 270 314];
names(metro,:)

% To remove these rows from the ratings matrix, enter the following.
rsubset = ratings;
nsubset = names;
nsubset(metro,:) = [];
rsubset(metro,:) = [];
disp(size(ratings));
disp(size(rsubset));

% The third output, variances, is a vector containing the variance 
% explained by the corresponding principal component. Each column of scores 
% has a sample variance equal to the corresponding element of variances.

disp(variances);

% calculate the percent of the total variability explained by each principal component.
percent_explained = 100*variances/sum(variances);
disp(percent_explained );

% Use the pareto function to make a scree plot of the percent variability
% explained by each principal component.
pareto(percent_explained);
xlabel('Principal Component');
ylabel('Variance Explained (%)');

% The figure shows that the only clear break in the amount of variance 
% accounted for by each component is between the first and second components. 
% However, that component by itself explains less than 40% of the variance, 
% so more components are probably needed. 
% The first three principal components explain roughly two-thirds of the 
% total variability in the standardized ratings, so 3 pcs might be a 
% reasonable way to reduce the dimensions in order to visualize the data.

% The last output, t2, is Hotelling's T2, a statistical measure of the 
% multivariate distance of each observation from the center of the data set. 
% This is an analytical way to find the most extreme points in the data.
[st2, index] = sort(t2,'descend'); % Sort in descending order.
extreme = index(1);
disp(extreme);
disp(names(extreme,:));

% It is not surprising that the ratings for New York are the furthest from the average U.S. town.
% Use biplot function to help visualize both the principal component coefficients 
% for each variable and the principal component scores for each observation 
% in a single plot. 
% The following command plots the results from the principal components analysis 
% on the cities and labels each of the variables.

biplot(coefs(:,1:2), 'scores',scores(:,1:2),... 
'varlabels',categories);
axis([-.26 1 -.51 .51]);
gname(names);

% Each of the nine variables is represented in this plot by a vector, 
% and the direction and length of the vector indicates how each variable 
% contributes to the two principal components in the plot. 
% For example, you have seen that the first principal component, 
% represented in this biplot by the horizontal axis, has positive coefficients 
% for all nine variables. That corresponds to the nine vectors directed 
% into the right half of the plot. 

% we also see that the second principal component, represented by the vertical axis, 
% has positive coefficients for the variables education, health, arts, and transportation, 
% and negative coefficients for the remaining five variables. 
% That corresponds to vectors directed into the top and bottom halves of the plot, respectively.
% This indicates that this component distinguishes between cities that 
% have high values for the first set of variables and low for the second, 
% and cities that have the opposite.

% If variable labels in the figure are crowded, we could either leave out the 
% VarLabels parameter when making the plot, or simply select and drag some 
% of the labels to better positions using the Edit Plot tool from the figure window toolbar.

% Each of the 329 observations is represented in this plot by a point, 
% and their locations indicate the score of each observation for the
% two principal components in the plot. 

% points near the left edge of this plot have the lowest scores for the 
% first principal component. The points are scaled to fit within the unit square, 
% so only their relative locations may be determined from the plot.

% Can use the Data Cursor, in the Tools menu in the figure window, 
% to identify the items in this plot. By clicking on a variable (vector), 
% you can read off that variable's coefficients for each principal component. 
% By clicking on an observation (point), you can read off that 
% observation's scores for each principal component.


% Can also make a biplot in 3 dimensions. This can be useful if the first two 
% principal coordinates do not explain enough of the variance in your data. 
% Selecting Rotate 3D in the Tools menu enables you to rotate the figure to see it from different angles.

biplot(coefs(:,1:3), 'scores',scores(:,1:3),...  
'obslabels',names);
axis([-.26 1 -.51 .51 -.61 .81]);
view([30 40]);



 
 

