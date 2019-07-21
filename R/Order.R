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

########### Order functions ########### 
#' @templateVar name Order
#' @templateVar urlSlug orders/order
#' @template api
NULL

## GET /admin/api/#{api_version}/orders.json
## Receive a list of all Orders
#' @rdname Order
getOrders <- function(...) {
    private$.fetchAll("orders", ...)
}

## GET /admin/api/#{api_version}/orders/#{id}.json
## Receive a single Order
#' @rdname Order
getOrder <- function(orderId, ...) {
    private$.request(private$.url("orders",orderId), ...)$order
}

## GET /admin/api/#{api_version}/orders/count.json
## Receive a count of all Orders
#' @rdname Order
getOrdersCount <- function(...) {
    private$.request(private$.url("orders","count"), ...)$count
}

## POST /admin/api/#{api_version}/orders/#{id}/close.json
## Close an Order
#' @rdname Order
closeOrder <- function(orderId, ...) {
    private$.request(private$.url("orders",orderId,"close"), reqType="POST", data=list(), ...)$order
}

## POST /admin/api/#{api_version}/orders/#{id}/open.json
## Re-open a closed Order
#' @rdname Order
openOrder <- function(orderId, ...) {
    private$.request(private$.url("orders",orderId,"open"), reqType="POST", data=list(), ...)$order
}

## POST /admin/api/#{api_version}/orders/#{id}/cancel.json
## Cancel an Order
#' @rdname Order
cancelOrder <- function(orderId, ...) {
    private$.request(private$.url("orders",orderId,"cancel"), reqType="POST", data=list(), ...)$order
}

## POST /admin/api/#{api_version}/orders.json
## Create a new Order
#' @rdname Order
createOrder <- function(order, ...) {
    order <- private$.wrap(order, "order", check=FALSE)
    private$.request("orders", reqType="POST", data=order, ...)$order
}

## PUT /admin/api/#{api_version}/orders/#{id}.json
## Modify an existing Order
#' @rdname Order
modifyOrder <- function(order, ...) {
    order <- private$.wrap(order, "order")
    private$.request(private$.url("orders",order$order$id), reqType="PUT", data=order, ...)$order
}

## DELETE /admin/api/#{api_version}/orders/#{id}.json
## Remove a Order from the database
#' @rdname Order
deleteOrder <- function(orderId, ...) {
    private$.request(private$.url("orders",orderId), reqType="DELETE", ...)
}