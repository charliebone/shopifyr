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

########### SmartCollection functions ########### 
#' @param productIds a vector of \code{\link{Product}} ids in the desired sort order
#' @templateVar name SmartCollection
#' @templateVar urlSlug products/smartcollection
#' @template api
NULL

## GET /admin/api/#{api_version}/smart_collections.json
## Receive a list of all SmartCollections
#' @rdname SmartCollection
getSmartCollections <- function(...) {
    private$.fetchAll("smart_collections", ...)
}

## GET /admin/api/#{api_version}/smart_collections/count.json
## Receive a count of all SmartCollections
#' @rdname SmartCollection
getSmartCollectionsCount <- function(...) {
    private$.request(private$.url("smart_collections","count"), ...)$count
}

## GET /admin/api/#{api_version}/smart_collections/#{id}.json
## Receive a single SmartCollection
#' @rdname SmartCollection
getSmartCollection <- function(smartCollectionId, ...) {
    private$.request(private$.url("smart_collections",smartCollectionId), ...)$smart_collection
}

## POST /admin/api/#{api_version}/smart_collections.json
## Create a new SmartCollection
#' @rdname SmartCollection
createSmartCollection <- function(smartCollection, ...) {
    smartCollection <- private$.wrap(smartCollection, "smart_collection", check=FALSE)
    private$.request("smart_collections", reqType="POST", data=smartCollection, ...)$smart_collection
}

## PUT /admin/api/#{api_version}/smart_collections/#{id}.json
## Modify an existing SmartCollection
#' @rdname SmartCollection
modifySmartCollection <- function(smartCollection, ...) {
    smartCollection <- private$.wrap(smartCollection, "smart_collection")
    private$.request(private$.url("smart_collections",smartCollection$smart_collection$id), reqType="PUT", data=smartCollection, ...)$smart_collection
}

## PUT /admin/api/#{api_version}/smart_collections/#{id}/order.json?products[]=921728736&products[]=632910392
## Set the ordering type and/or the manual order of products in a smart collection
#' @rdname SmartCollection
orderSmartCollection <- function(smartCollectionId, productIds, ...) {
    orderStr <- paste0(paste0("products[]=",productIds), collapse="&")
    private$.request(private$.url("smart_collections",smartCollectionId,"order"),`products[]`=productIds, ...) 
}

## DELETE /admin/api/#{api_version}/smart_collections/#{id}.json
## Remove a SmartCollection from the database
#' @rdname SmartCollection
deleteSmartCollection <- function(smartCollectionId, ...) {
    private$.request(private$.url("smart_collections",smartCollectionId), reqType="DELETE", ...)
}