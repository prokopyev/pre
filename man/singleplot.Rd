% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/pre.R
\name{singleplot}
\alias{singleplot}
\title{Create partial dependence plot for a single variable}
\usage{
singleplot(object, varname, penalty.par.val = "lambda.1se", nvals = NULL,
  type = "response", ...)
}
\arguments{
\item{object}{an object of class \code{\link{pre}}}

\item{varname}{character vector of length one, specifying the variable for
which the partial dependence plot should be created.
penalty.par.val character. Penalty parameter criterion to be used for
selecting final model: lambda giving minimum cv error ("lambda.min") or lambda
giving cv error that is within 1 standard error of minimum cv error
("lambda.1se"). Alternatively, a numeric value may be specified, 
corresponding to one of the values of lambda in the sequence used by glmnet,
for which estimated cv error can be inspected by running 
\code{object$glmnet.fit} and \code{plot(object$glmnet.fit)}.}

\item{penalty.par.val}{character. Penalty parameter criterion to be used for
selecting final model: lambda giving minimum cv error (\code{"lambda.min"}) or
lambda giving cv error that is within 1 standard error of minimum cv error
("\code{lambda.1se}"). Alternatively, a numeric value may be specified, 
corresponding to one of the values of lambda in the sequence used by glmnet,
for which estimated cv error can be inspected by running 
\code{object$glmnet.fit} and \code{plot(object$glmnet.fit)}.}

\item{nvals}{optional numeric vector of length one. For how many values of x
should the partial dependence plot be created?}

\item{type}{character string. Type of prediction to be plotted on y-axis.
\code{type = "response"} gives fitted values for continuous outputs and
fitted probabilities for nominal outputs. \code{type = "link"} gives fitted
values for continuous outputs and linear predictor values for nominal outputs.}

\item{...}{Further arguments to be passed to 
\code{\link[graphics]{plot.default}}.}
}
\description{
\code{singleplot} creates a partial dependence plot, which shows the effect of
a predictor variable on the ensemble's predictions
}
\details{
By default, a partial dependence plot will be created for each unique
observed value of the specified predictor variable. When the number of unique
observed values is large, this may take a long time to compute. In that case,
specifying the nvals argument can substantially reduce computing time. When the
nvals argument is supplied, values for the minimum, maximum, and (nvals - 2)
intermediate values of the predictor variable will be plotted. Note that nvals
can be specified only for numeric and ordered input variables. If the plot is
requested for a nominal input variable, the \code{nvals} argument will be
ignored and a warning is printed.
}
\examples{
\donttest{
set.seed(42)
airq.ens <- pre(Ozone ~ ., data = airquality[complete.cases(airquality),])
singleplot(airq.ens, "Temp")}
}
\seealso{
\code{\link{pre}}, \code{\link{pairplot}}
}
