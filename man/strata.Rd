\name{strata}
\alias{strata}
\title{Stratified sampling}
\description{Stratified sampling with equal/unequal probabilities.}
\usage{strata(data, stratanames=NULL, size, method=c("srswor","srswr","poisson","systematic"),
pik,description=FALSE)}
\arguments{
\item{data}{the data frame or data matrix; its number of rows is N, the population size.}
\item{stratanames}{vector of stratification variables.}
\item{size}{vector of stratum sample sizes (in the order in which the strata appear in the input
data set).}
\item{method}{method to select units; the following methods are implemented: simple random 
sampling without replacement (srswor), simple random sampling with replacement (srswr), 
Poisson sampling (poisson), systematic sampling (systematic); by default, the method is "srswor".}
\item{pik}{vector of selection probabilities or auxiliary information used to compute them; 
this argument is needed only for unequal probability sampling (Poisson, systematic). If an
auxiliary information is provided, the function uses the \link{inclusionprobabilities} function for
computing these probabilities. If the method is "srswr" and the sample size is larger than
the population size, this vector is normalized to one.}
\item{description}{a message is printed if the value is TRUE; the message gives the number 
of selected units and the number of the units in the population. 
By default, the value is FALSE.}
}
\details{ The function produces an object, which contains the following information:
 the selected units within strata,
 the identifier of the units,
 the final inclusion probabilities of the units.
If the method is "srswr", the number of replicates is also given. 
}
\seealso{
\code{\link{getdata}}, \code{\link{mstage}}}
\examples{
############
## Example 1
############
# Example from An and Watts (New SAS procedures for Analysis of Sample Survey Data)
# Generates artificial data (a 235X3 matrix with 3 columns: state, region, income).
# The variable "state" has 2 categories (nc and sc). 
# The variable "region" has 3 categories (1, 2 and 3).
# The sampling frame is stratified by region within state.
data=rbind(matrix(rep("nc",165),165,1,byrow=TRUE),matrix(rep("sc",70),70,1,byrow=TRUE))
data=cbind.data.frame(data,c(rep(1,100), rep(2,50), rep(3,15), rep(1,30),rep(2,40)),1000*runif(235))
names(data)=c("state","region","income")
# Computes the population stratum sizes
table(data$region,data$state)
# do not run
#     nc  sc
#  1 100  30
#  2  50  40
#  3  15   0
# there are 5 cells with non-zero values; one draws 5 samples (1 sample in each stratum)
# the sample stratum sizes are 10,5,10,4,6, respectively
# the method is 'srswor' (equal probability, without replacement)
s=strata(data,c("region","state"),size=c(10,5,10,4,6), method="srswor")
# extracts the observed data
getdata(data,s)
############
## Example 2
############
# The same data as in Example 1
# the method is 'systematic' (unequal probability, without replacement)
# the selection probabilities are computed using the variable 'income'
s=strata(data,c("region","state"),size=c(10,5,10,4,6), method="systematic",pik=data$income)
# extracts the observed data
getdata(data,s)
############
## Example 3
############
# Uses the 'swissmunicipalities' data for drawing a sample of units
data(swissmunicipalities)
# the variable 'REG' has 7 categories in the population; it is used as stratification variable
# Computes the population stratum sizes
table(swissmunicipalities$REG)
# do not run
#  1   2   3   4   5   6   7 
# 589 913 321 171 471 186 245 
# the sample stratum sizes are given by size=c(30,20,45,15,20,11,44)
# the method is simple random sampling without replacement (equal probability, without replacement)
st=strata(swissmunicipalities,stratanames=c("REG"),size=c(30,20,45,15,20,11,44), method="srswor")
# extracts the observed data
# the order of the columns is different from the order in the swsissmunicipalities database
getdata(swissmunicipalities, st)
}
\keyword{survey}