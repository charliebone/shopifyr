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

########### Customer functions ########### 
#' @param query a query string to use when searching Customer records
#' @templateVar name Customer
#' @templateVar urlSlug customers/customer
#' @template api
NULL

## GET /admin/api/#{api_version}/customers.json
## Receive a list of all Customers
#' @rdname Customer
getCustomers <- function(...) {
    private$.fetchAll("customers", ...)
}

## GET /admin/api/#{api_version}/customers/search.json?query=Bob country:United States
## Search for customers matching supplied query
#' @rdname Customer
searchCustomers <- function(query, ...) {
    private$.fetchAll(private$.url("customers","search"), "customers", query=query, .queryParam="query", ...)
}

## GET /admin/api/#{api_version}/customers/#{id}.json
## Receive a single Customer
#' @rdname Customer
getCustomer <- function(customerId, ...) {
    private$.request(private$.url("customers",customerId), ...)$customer
}

## POST /admin/api/#{api_version}/customers.json
## Create a new Customer
#' @rdname Customer
createCustomer <- function(customer, ...) {
    customer <- private$.wrap(customer, "customer", check=FALSE)
    private$.request("customers", reqType="POST", data=customer, ...)$customer
}

## PUT /admin/api/#{api_version}/customers/#{id}.json
## Modify an existing Customer
#' @rdname Customer
modifyCustomer <- function(customer, ...) {
    customer <- private$.wrap(customer, "customer")
    private$.request(private$.url("customers",customer$customer$id), reqType="PUT", data=customer, ...)$customer
}

## DELETE /admin/api/#{api_version}/customers/#{id}.json
## Remove a Customer from the database
#' @rdname Customer
deleteCustomer <- function(customerId, ...) {
    private$.request(private$.url("customers",customerId), reqType="DELETE", ...)
}

## GET /admin/api/#{api_version}/customers/count.json
## Receive a count of all Customers
#' @rdname Customer
getCustomersCount <- function(...) {
    private$.request(private$.url("customers","count"), ...)$count
}

## GET /admin/api/#{api_version}/orders.json?customer_id=207119551
## Find orders belonging to this customer
#' @rdname Customer
getCustomerOrders <- function(customerId, ...) {
    private$.request("orders", customer_id=customerId, ...)$orders
}