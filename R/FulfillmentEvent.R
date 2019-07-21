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

########### FulfillmentEvent functions ########### 
#' @param orderId an \code{\link{Order}} id
#' @param fulfillmentId a \code{\link{Fulfillment}} id
#' @templateVar name FulfillmentEvent
#' @templateVar urlSlug shipping_and_fulfillment/fulfillmentservice
#' @template api
NULL

## GET /admin/api/#{api_version}/orders/#{order_id}/fulfillments/#{fulfillment_id}/events.json
## Retrieves a list of fulfillment events for a specific fulfillment
#' @rdname FulfillmentEvent
getFulfillmentEvents <- function(orderId, fulfillmentId, ...) {
    private$.request(private$.url("orders",orderId,"fulfillments",fulfillmentId,"events"), ...)$fulfillment_events
}

## GET /admin/api/#{api_version}/orders/#{order_id}/fulfillments/#{fulfillment_id}/events/#{event_id}.json
## Retrieves a specific fulfillment event
#' @rdname FulfillmentEvent
getFulfillmentEvent <- function(orderId, fulfillmentId, fulfillmentEventId, ...) {
    private$.request(private$.url("orders",orderId,"fulfillments",fulfillmentId,"events",fulfillmentEventId), ...)$fulfillment_event
}

## POST /admin/api/#{api_version}/orders/#{order_id}/fulfillments/#{fulfillment_id}/events.json
## Creates a fulfillment event
#' @rdname FulfillmentEvent
createFulfillmentEvent <- function(orderId, fulfillmentId, fulfillmentEvent, ...) {
    fulfillmentEvent <- private$.wrap(fulfillmentEvent, "fulfillment_event", check=FALSE)
    private$.request(private$.url("orders",orderId,"fulfillments",fulfillmentId,"events"), reqType="POST", data=fulfillmentEvent, ...)$fulfillment_event
}

## DELETE /admin/api/#{api_version}/orders/#{order_id}/fulfillments/#{fulfillment_id}/events/#{event_id}.json
## Deletes a fulfillment event
#' @rdname FulfillmentEvent
deleteFulfillmentEvent <- function(orderId, fulfillmentId, fulfillmentEventId, ...) {
    private$.request(private$.url("orders",orderId,"fulfillments",fulfillmentId,"events",fulfillmentEventId), reqType="DELETE", ...)
}
