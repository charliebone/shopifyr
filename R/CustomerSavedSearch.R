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

########### CustomerSavedSearch functions ########### 
#' @templateVar name CustomerSavedSearch
#' @templateVar urlSlug customers/customersavedsearch
#' @template api
NULL

## GET /admin/api/#{api_version}/customer_saved_searches.json
## Retrieves a list of customer saved searches
#' @rdname CustomerSavedSearch
getCustomerSavedSearches <- function(...) {
    private$.fetchAll("customer_saved_searches", ...)$customer_saved_searches
}

## GET /admin/api/#{api_version}/customer_saved_searches/count.json
## Retrieves a count of all customer saved searches
#' @rdname CustomerSavedSearch
getCustomerSavedSearchesCount <- function(...) {
    private$.request(private$.url("customer_saved_searches","count"), ...)$count
}

## GET /admin/api/#{api_version}/customer_saved_searches/#{customer_saved_search_id}.json
## Retrieves a single customer saved search
#' @rdname CustomerSavedSearch
getCustomerSavedSearch <- function(customerSavedSearchId, ...) {
    private$.request(private$.url("customer_saved_searches",customerSavedSearchId), ...)$customer_saved_search
}

## GET /admin/api/#{api_version}/customer_saved_searches/#{customer_saved_search_id}/customers.json
## Retrieves all customers returned by a customer saved search
#' @rdname CustomerSavedSearch
getCustomerSavedSearchResults <- function(customerSavedSearchId, ...) {
    private$.request(private$.url("customer_saved_searches",customerSavedSearchId,"customers"), ...)$customers
}

## POST /admin/api/#{api_version}/customer_saved_searches.json
## Creates a customer saved search
#' @rdname CustomerSavedSearch
createCustomerSavedSearch <- function(customerSavedSearch, ...) {
    customerSavedSearch <- private$.wrap(customerSavedSearch, "customer_saved_search", check=FALSE)
    private$.request("customer_saved_searches", reqType="POST", data=customerSavedSearch, ...)$customer_saved_search
}

## PUT /admin/api/#{api_version}/customer_saved_searches/#{customer_saved_search_id}.json
## Updates a customer saved search
#' @rdname CustomerSavedSearch
modifyCustomerSavedSearch <- function(customerSavedSearch, ...) {
    customerSavedSearch <- private$.wrap(customerSavedSearch, "customer_saved_search")
    private$.request(private$.url("customer_saved_searches",customerSavedSearch$customer_saved_search$id), reqType="PUT", data=customerSavedSearch, ...)$customer_saved_search
}

## DELETE /admin/api/#{api_version}/customer_saved_searches/#{customer_saved_search_id}.json
## Deletes a customer saved search
#' @rdname CustomerSavedSearch
deleteCustomerSavedSearch <- function(customerSavedSearchId, ...) {
    private$.request(private$.url("customer_saved_searches",customerSavedSearchId), reqType="DELETE", ...)
}
