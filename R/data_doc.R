#### BOSTON ####

#' @name boston
#' @title Housing Values in Suburbs of Boston
#' @description This dataset is intended to be used in the modellatoR demos
#' for regression.
#' @docType data
#' @usage boston
#' @format A data.frame with 506 rows and 14 variables.
#' \itemize{
#'  \item \code{crim}: per capita crime rate by town.
#'  \item \code{zn}: proportion of residential land zoned for
#'  lots over 25,000 sq.ft.
#' 	\item \code{indus}: proportion of non-retail business acres per town.
#' 	\item \code{chas}: Charles River dummy variable (1 if tract bounds river;
#'   0 otherwise).
#' 	\item \code{nox}: nitrogen oxides concentration (parts per 10 million).
#' 	\item \code{rm}: average number of rooms per dwelling.
#' 	\item \code{age}: proportion of owner-occupied units built prior to 1940.
#' 	\item \code{dis}: weighted mean of distances to five Boston
#'   employment centres.
#' 	\item \code{rad}: index of accessibility to radial highways.
#' 	\item \code{tax}: full-value property-tax rate per $10,000.
#'  \item \code{ptratio}: pupil-teacher ratio by town.
#' 	\item \code{black}: 1000(Bk - 0.63)^2 where Bk is the proportion of
#'   blacks by town.
#' 	\item \code{lstat}: lower status of the population (percent).
#' 	\item \code{medv}: median value of owner-occupied homes in $1000s.
#' }
#' @source
#'  \itemize{
#'   \item Harrison, D. and Rubinfeld, D.L. (1978) Hedonic prices and the
#'   demand for clean air. \emph{J. Environ. Economics and Management} \bold{5}, 81--102.
#'   \item Belsley D.A., Kuh, E.  and Welsch, R.E. (1980) \emph{Regression
#'   Diagnostics. Identifying Influential Data and Sources of Collinearity.} New York: Wiley.
#'  }
#' @author This dataset is part of the MASS package and has copyright 1994-9
#' W. N. Venables and B. D. Ripley.
#' @keywords modellatoR, datasets
NULL

#### BREAST CANCER WISCONSIN ####

#' @name cancer_w
#' @title BNG Breast Cancer Wisconsin
#' @description This dataset is intended to be used in the modellatoR demos
#' for classification. It's a larger version of the Breast Cancer Wisconsin
#' dataset made via a Bayesian Network trained on the original dataset and
#' then using it to create pseudo instances.
#' @docType data
#' @usage cancer_w
#' @format A data.frame with 39366 rows and 10 variables. Each row contains 9
#' predictors and 1 response (\code{Class}).
#' \itemize{
#'  \item \code{Clump_Thickness}: num  4.8 5.59 5.17 8.21 1 ...
#' 	\item \code{Cell_Size_Uniformity}: num  1 1 1 4.56 1 ...
#' 	\item \code{Cell_Shape_Uniformity}: num  1 1 1 5.43 1 ...
#' 	\item \code{Marginal_Adhesion}: num  1 1 1 3.97 1 ...
#' 	\item \code{Single_Epi_Cell_Size}: num  2 2 2 3 2 2 1 2 2 2 ...
#' 	\item \code{Bare_Nuclei}: num  1 1 1 6.74 1 ...
#' 	\item \code{Bland_Chromatin}: num  2 2 3 9.16 1 ...
#' 	\item \code{Normal_Nucleoli}: num  1 1 1 10 1 ...
#' 	\item \code{Mitoses}: num  1 1 1 1 1 1 1 1 1 1 ...
#' 	\item \code{Class}: Factor w/ 2 levels "benign","malignant": 1 1 1 2 1 1 1 1 1 1 ...
#' }
#' @source openML - \href{http://www.openml.org/d/251}{dataset 251}
#' @author This extended version was made by Geoffrey Holmes,
#' Bernhard Pfahringer, Jan van Rijn and Joaquin Vanschoren.
#'
#' The original dataset was made by Dr. WIlliam H. Wolberg and donated by
#' Olvi Mangasarian and David W. Aha.
#' @keywords modellatoR, datasets
NULL
