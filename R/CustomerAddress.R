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
#' @param customerId a \code{\link{Customer}} id
#' @templateVar name CustomerAddress
#' @templateVar urlSlug customers/customer_address
#' @template api
NULL

## GET /admin/api/#{api_version}/customers/#{customer_id}/addresses.json
## Retrieves a list of addresses for a customer
#' @rdname CustomerAddress
getCustomerAddresses <- function(customerId, ...) {
    private$.request(private$.url("customers",customerId,"addresses"), ...)$addresses
}

## GET /admin/api/#{api_version}/customers/#{customer_id}/addresses/#{address_id}.json
## Retrieves details for a single customer address
#' @rdname CustomerAddress
getCustomerAddress <- function(customerId, customerAddressId, ...) {
    private$.request(private$.url("customers",customerId,"addresses",customerAddressId), ...)$address
}

## POST /admin/api/#{api_version}/customers/#{customer_id}/addresses.json
## Creates a new address for a customer
#' @rdname CustomerAddress
createCustomerAddress <- function(customerAddress, customerId, ...) {
    customerAddress <- private$.wrap(customerAddress, "address", check=FALSE)
    private$.request(private$.url("customers",customerId,"addresses"), reqType="POST", data=customerAddress, ...)$address
}

## PUT /admin/api/#{api_version}/customers/#{customer_id}/addresses/#{address_id}.json
## Updates an existing customer address
#' @rdname CustomerAddress
modifyCustomerAddress <- function(customerAddress, customerId, ...) {
    customerAddress <- private$.wrap(customerAddress, "address")
    private$.request(private$.url("customers",customerId,"addressess",customerAddress$address$id), reqType="PUT", data=customerAddress, ...)$address
}

## DELETE /admin/api/#{api_version}/customers/#{customer_id}/addresses/#{address_id}.json
## Removes an address from a customer's address list
#' @rdname CustomerAddress
deleteCustomerAddress <- function(customerId, customerAddressId, ...) {
    private$.request(private$.url("customers",customerId,"addresses",customerAddressId), reqType="DELETE", ...)
}

## PUT /admin/api/#{api_version}/customers/#{customer_id}/addresses/#{address_id}/default.json
## Sets the default address for a customer
#' @rdname CustomerAddress
setCustomerDefaultAddress <- function(customerId, customerAddressId, ...) {
    private$.request(private$.url("customers",customerId,"addresses",customerAddressId,"default"), reqType="PUT", ...)
}