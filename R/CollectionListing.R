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

########### CollectionListing functions ########### 
#' @param collectionId a Collection id
#' @param collectionListingId a CollectionListing id
#' @templateVar name CollectionListing
#' @templateVar urlSlug sales-channels/collectionlisting
#' @templateVar default.params FALSE
#' @return a list of Checkouts
#' @template api
NULL

## PUT /admin/api/#{api_version}/collection_listings/#{collection_listing_id}.json
## Create a collection listing to publish a collection to your app
#' @rdname CollectionListing
createCollectionListing <- function(collectionId, ...) {
    collect <- private$.wrap(list(collection_id=collectionId), "collection_listing", check="collection_id")
    private$.request(private$.url("collection_listings",collectionId), reqType="PUT", data=collect, ...)$collection_listing
}

## DELETE /admin/api/#{api_version}/collection_listings/#{collection_listing_id}.json
## Delete a collection listing to unpublish a collection from your app
#' @rdname CollectionListing
deleteCollectionListing <- function(collectionListingId, ...) {
    private$.request(private$.url("collection_listings",collectionListingId), reqType="DELETE", ...)
}


## GET /admin/api/#{api_version}/collection_listings.json
## Retrieve collection listings that are published to your app
#' @rdname CollectionListing
getCollectionListings <- function(...) {
    private$.fetchAll("collection_listings", ...)
}

## GET /admin/api/#{api_version}/collection_listings/#{collection_listing_id}.json
## Retrieve a specific collection listing that is published to your app
#' @rdname CollectionListing
getCollectionListingCount <- function(...) {
    private$.request(private$.url("collection_listings","count"), ...)$count
}

## GET /admin/api/#{api_version}/collection_listings/#{collection_listing_id}/product_ids.json
## Retrieve product_ids that are published to a collection_id
#' @rdname CollectionListing
getCollectionListingProductIds <- function(collectionListingId, ...) {
    private$.request(private$.url("collection_listings",collectionListingId,"product_ids"), ...)$product_ids
}