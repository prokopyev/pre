% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/pre.R
\name{corplot}
\alias{corplot}
\title{Plotting baselearner correlations}
\usage{
corplot(object, penalty.par.val = "lambda.1se", colors = NULL,
  fig.plot = c(0, 0.85, 0, 1), fig.legend = c(0.8, 0.95, 0, 1),
  legend.breaks = seq(-1, 1, by = 0.1))
}
\arguments{
\item{object}{object of class pre}

\item{penalty.par.val}{character. Value of the penalty parameter value 
\eqn{\lambda} to be used for selecting the final ensemble. The ensemble 
with penalty parameter criterion yielding minimum cv error 
(\code{"lambda.min"}) is taken, by default. Alternatively, the penalty 
parameter yielding error within 1 standard error of minimum cv error 
("\code{lambda.1se}"), or a numeric value may be specified, corresponding 
to one of the values of lambda in the sequence used by glmnet,
for which estimated cv error can be inspected by running \code{x$glmnet.fit}
and \code{plot(x$glmnet.fit)}.}

\item{colors}{vector of contiguous colors to be used for plotting. If 
\code{colors = NULL} (default), \code{colorRampPalette(c("#053061", "#2166AC", 
"#4393C3", "#92C5DE", "#D1E5F0", "#FFFFFF", "#FDDBC7", "#F4A582", "#D6604D", 
"#B2182B", "#67001F"))(200)} is used. A different set of plotting colors can 
be specified, for example: \code{colors = cm.colors(100)}, or
\code{colorRampPalette(c("blue", "white", "red"))(150)}. See
\code{\link[grDevices]{cm.colors}} or \code{\link[grDevices]{colorRampPalette}}.}

\item{fig.plot}{plotting region to be used for correlation plot. See 
\code{fig} under \code{\link{par}}.}

\item{fig.legend}{plotting region to be used for legend. See \code{fig} 
under \code{\link{par}}.}

\item{legend.breaks}{numeric vector of breakspoints and colors to be 
depicted in the plot's legend.}
}
\description{
\code{corplot} plots correlations between baselearners
}
\examples{
\donttest{set.seed(42)
airq.ens <- pre(Ozone ~ ., data = airquality[complete.cases(airquality),])
corplot(airq.ens)
}
}
