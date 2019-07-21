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

########### ProductListing functions ########### 
#' @param productId a \code{\link{Product}} id
#' @param productListingId a ProductListing id
#' @templateVar name ProductListing
#' @templateVar urlSlug sales-channels/productlisting
#' @templateVar default.params FALSE
#' @template api
NULL

## GET /admin/api/#{api_version}/product_listings.json
## Retrieve product listings that are published to your app
#' @rdname ProductListing
getProductListings <- function(...) {
    private$.fetchAll("product_listings", ...)
}

## GET /admin/api/#{api_version}/product_listings/product_ids.json
## Retrieve product_ids that are published to your app
#' @rdname ProductListing
getProductListingProducts <- function(...) {
    private$.request(private$.url("product_listings","product_ids"), ...)$product_ids
}

## GET /admin/api/#{api_version}/product_listings/count.json
## Retrieve a count of products that are published to your app
#' @rdname ProductListing
getProductListingsCount <- function(...) {
    private$.request(private$.url("product_listings","count"), ...)$count
}

## GET /admin/api/#{api_version}/product_listings/#{product_listing_id}.json
## Retrieve a specific product listing that is published to your app
#' @rdname ProductListing
getProductListing <- function(productListingId, ...) {
    private$.request(private$.url("product_listings",productListingId), ...)$product_listing
}

## PUT /admin/api/#{api_version}/product_listings/#{product_listing_id}.json
## Create a product listing to publish a product to your app
#' @rdname ProductListing
createProductListing <- function(productId, ...) {
    productListing <- private$.wrap(list(product_id=productId), "product_listing", check=FALSE)
    private$.request("product_listings", reqType="PUT", data=productListing, ...)$product_listing
}

## DELETE /admin/api/#{api_version}/product_listings/#{product_listing_id}.json
## Delete a product listing to unpublish a product from your app
#' @rdname ProductListing
deleteProductListing <- function(productListingId, ...) {
    private$.request(private$.url("product_listings",productListingId), reqType="DELETE", ...)
}