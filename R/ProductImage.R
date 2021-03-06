#
#   shopifyr: An R Interface to the Shopify API
#
#   Copyright (C) 2015 Charlie Friedemann cfriedem @ gmail.com
#   Shopify API (c) 2006-2015 Shopify Inc.
#
#   This program is free software: you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

########### ProductImage functions ########### 
#' @param productId a \code{\link{Product}} id number
#' @param filepath the filepath to an image to upload
#' @templateVar name ProductImage
#' @templateVar slug image
#' @templateVar urlSlug products/product_image
#' @template api
NULL

## GET /admin/api/#{api_version}/products/#{id}/images.json
## Receive a list of all Product Images
#' @rdname ProductImage
getProductImages <- function(productId, ...) {
    private$.request(private$.url("products",productId,"images"), ...)$images
}

## GET /admin/api/#{api_version}/products/#{id}/images/count.json
## Receive a count of all Product Images
#' @rdname ProductImage
getProductImagesCount <- function(productId, ...) {
    private$.request(private$.url("products",productId,"images","count"), ...)$count
}

## GET /admin/api/#{api_version}/products/#{id}/images/#{id}.json
## Receive a single Product Image
#' @rdname ProductImage
getProductImage <- function(productId, imageId, ...) {
    private$.request(private$.url("products",productId,"images",imageId), ...)$image
}

## POST /admin/api/#{api_version}/products/#{id}/images.json
## Create a new Product Image
#' @rdname ProductImage
createProductImage <- function(productId, image, ..., filepath) {
    if (!missing(filepath)) {
        image <- private$.encodeImageFile(filepath)
    } else {
        image <- private$.wrap(image, "image", check=FALSE)
    }
    private$.request(private$.url("products",productId,"images"), reqType="POST", data=image,  ...)$image
}

## PUT /admin/api/#{api_version}/products/#{id}/images/#{id}.json
## Modify an existing Product Image
#' @rdname ProductImage
modifyProductImage <- function(productId, image, ..., filepath) {
    if (!missing(filepath)) {
        image <- private$.encodeImageFile(filepath)
    } else {
        image <- private$.wrap(image, "image")
    }
    private$.request(private$.url("products",productId,"images",image$image$id), reqType="PUT", data=image,  ...)$image
}

## DELETE /admin/api/#{api_version}/products/#{id}/images/#{id}.json
## Remove a Product Image from the database
#' @rdname ProductImage
deleteProductImage <- function(productId, imageId, ...) {
    private$.request(private$.url("products",productId,"images",imageId), reqType="DELETE",  ...)
}