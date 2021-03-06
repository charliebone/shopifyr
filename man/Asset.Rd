% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Asset.R
\name{Asset}
\alias{Asset}
\alias{getAssets}
\alias{getAsset}
\alias{createAsset}
\alias{modifyAsset}
\alias{deleteAsset}
\title{Asset Functions}
\usage{
getAssets(themeId, ...)

getAsset(themeId, assetKey, ...)

createAsset(themeId, asset, ...)

deleteAsset(themeId, assetKey, ...)
}
\arguments{
\item{themeId}{a \code{\link{Theme}} id number}

\item{...}{additional request parameters}

\item{assetKey}{an Asset key e.g. \code{"templates/index.liquid"}}

\item{asset}{a list containing Asset fields}
}
\value{
a list containing an Asset fields or a list of Assets
}
\description{
Asset Functions
}
\references{
Shopify API Asset documentation: \url{https://help.shopify.com/api/reference/online_store/asset}
}
