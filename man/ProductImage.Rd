% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ProductImage.R
\name{ProductImage}
\alias{ProductImage}
\alias{getProductImages}
\alias{getProductImagesCount}
\alias{getProductImage}
\alias{createProductImage}
\alias{modifyProductImage}
\alias{deleteProductImage}
\title{ProductImage Functions}
\usage{
getProductImages(productId, ...)

getProductImagesCount(productId, ...)

getProductImage(productId, imageId, ...)

createProductImage(productId, image, ..., filepath)

modifyProductImage(productId, image, ..., filepath)

deleteProductImage(productId, imageId, ...)
}
\arguments{
\item{productId}{a \code{\link{Product}} id number}

\item{...}{additional request parameters}

\item{imageId}{a ProductImage id number}

\item{image}{a list containing ProductImage fields}

\item{filepath}{the filepath to an image to upload}
}
\value{
a list containing a ProductImage fields or a list of ProductImages
}
\description{
ProductImage Functions
}
\references{
Shopify API ProductImage documentation: \url{https://help.shopify.com/api/reference/products/product_image}
}
