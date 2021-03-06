######################################################################
## a two-way miltivariate analysis of variance of plastic film data ##
######################################################################

#	data = read.table("film.data", header=F);
#	rate <- factor(data$V1, labels=c("Low", "High"));
#	additive <- factor(data$V2, labels=c("Low", "High"));
#	Y = as.matrix(data[,3:5]);
# 
	tear <- c(6.5, 6.2, 5.8, 6.5, 6.5, 6.9, 7.2, 6.9, 6.1, 6.3,
		6.7, 6.6, 7.2, 7.1, 6.8, 7.1, 7.0, 7.2, 7.5, 7.6);

	gloss <- c(9.5, 9.9, 9.6, 9.6, 9.2, 9.1, 10.0, 9.9, 9.5, 9.4,
		9.1, 9.3, 8.3, 8.4, 8.5, 9.2, 8.8, 9.7, 10.1, 9.2);

	opacity <- c(4.4, 6.4, 3.0, 4.1, 0.8, 5.7, 2.0, 3.9, 1.9, 5.7,
		2.8, 4.1, 3.8, 1.6, 3.4, 8.4, 5.2, 6.9, 2.7, 1.9);

	Y <- cbind(tear, gloss, opacity);
	rate <- factor(gl(2,10), labels=c("Low", "High"));
	additive <- factor(gl(2, 5, len=20), labels=c("Low", "High"));


	fit <- manova(Y ~ rate * additive);
	#interation not significant
	summary(fit, test = c("Wilks")); 

	#
	fit2 <- manova(Y ~ rate + additive);
	summary(fit2, test = c("Wilks")); 
	summary.aov(fit2);

#	using by() to examine various group means
	by(Y, rate, mean);
	by(Y, additive, mean);
	by(Y, list(rate,additive), mean);
