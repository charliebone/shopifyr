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

########### Product functions ########### 
#' @templateVar name Product
#' @template api
NULL

## GET /admin/products.json
## Receive a list of all Products
#' @rdname Product
getProducts <- function(...) {
    private$.fetchAll("products", ...)
}

## GET /admin/products/count.json
## Receive a count of all Products
#' @rdname Product
getProductsCount <- function(...) {
    private$.request(private$.url("products","count"), ...)$count
}

## GET /admin/products/#{id}.json
## Receive a single Product
#' @rdname Product
getProduct <- function(productId, ...) {
    private$.request(private$.url("products",productId), ...)$product
}

## POST /admin/products.json
## Create a new Product
#' @rdname Product
createProduct <- function(product, ...) {
    product <- private$.wrap(product, "product", check=FALSE)
    private$.request("products", reqType="POST", data=product, ...)$product
}

## PUT /admin/products/#{id}.json
## Modify an existing Product
#' @rdname Product
modifyProduct <- function(product, ...) {
    product <- private$.wrap(product, "product")
    private$.request(private$.url("products",product$product$id), reqType="PUT", data=product, ...)$product
}

## DELETE /admin/products/#{id}.json
## Remove a product from the database
#' @rdname Product
deleteProduct <- function(productId, ...) {
    private$.request(private$.url("products",productId), reqType="DELETE", ...)
}