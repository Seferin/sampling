\name{inclusionprobabilities}
\alias{inclusionprobabilities}
\title{Inclusion probabilities}
\description{Computes the first-order inclusion probabilities from a vector of positive numbers 
(for a probability proportional-to-size sampling design).
}
\usage{inclusionprobabilities(a,n)}
\arguments{
\item{a}{vector of positive numbers.}
\item{n}{sample size.}
}
\seealso{
\code{\link{inclusionprobastrata}}
}
\examples{
############
## Example 1
############
# a vector of positive numbers
a=1:20
# computation of the inclusion probabilities for a sample size n=12
pik=inclusionprobabilities(a,12)
pik
############
## Example 2
############
# Computation of the inclusion probabilities proportional to the number 
# of inhabitants in each municipality of the Belgian database.
data(belgianmunicipalities)
pik=inclusionprobabilities(belgianmunicipalities$Tot04,200)
# the first-order inclusion probabilities for each municipality
data.frame(pik=pik,name=belgianmunicipalities$Commune)
# the inclusion probability sum is equal to the sample size
sum(pik)
}
\keyword{survey}
