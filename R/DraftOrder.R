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

########### DraftOrder functions ###########
#' @param draftOrderInvoice an list of draft order invoice fields
#' @templateVar name DraftOrder
#' @templateVar urlSlug orders/draftorder
#' @template api
NULL

## POST /admin/api/#{api_version}/draft_orders.json
## Create a new DraftOrder
#' @rdname DraftOrder
createDraftOrder <- function(draftOrder, ...) {
    draftOrder <- private$.wrap(draftOrder, "draft_order", check=FALSE)
    private$.request("draft_orders", reqType="POST", data=draftOrder, ...)$draft_order
}

## PUT /admin/api/#{api_version}/draft_orders/#{draft_order_id}.json
## Modify an existing DraftOrder
#' @rdname DraftOrder
modifyDraftOrder <- function(draftOrder, ...) {
    draftOrder <- private$.wrap(draftOrder, "draft_order")
    private$.request(private$.url("draft_orders",draftOrder$draft_order$id), reqType="PUT", data=draftOrder, ...)$draft_order
}

## GET /admin/api/#{api_version}/draft_orders.json
## Retrieves a list of draft orders
#' @rdname DraftOrder
getDraftOrders <- function(...) {
    private$.fetchAll("draft_orders", ...)
}

## GET /admin/api/#{api_version}/draft_orders/#{draft_order_id}.json
## Receive a single DraftOrder
#' @rdname DraftOrder
getDraftOrder <- function(draftOrderId, ...) {
    private$.request(private$.url("draft_orders",draftOrderId), ...)$draft_order
}

## GET /admin/api/#{api_version}/draft_orders/count.json
## Receive a count of all DraftOrders
#' @rdname DraftOrder
getDraftOrdersCount <- function(...) {
    private$.request(private$.url("draft_orders","count"), ...)$count
}

## POST /admin/api/#{api_version}/draft_orders/#{draft_order_id}/send_invoice.json
## Send an invoice
#' @rdname DraftOrder
sendDraftOrderInvoice <- function(draftOrderId, draftOrderInvoice, ...) {
    draftOrderInvoice <- private$.wrap(draftOrderInvoice, "draft_order_invoice", check=FALSE)
    private$.request(private$.url("draft_orders",draftOrderId,"send_invoice"), reqType="POST", data=draftOrderInvoice, ...)$draft_order_invoice
}

## DELETE /admin/api/#{api_version}/draft_orders/#{draft_order_id}.json
## Remove an existing DraftOrder
#' @rdname DraftOrder
deleteDraftOrder <- function(draftOrderId, ...) {
    private$.request(private$.url("draft_orders",draftOrderId), reqType="DELETE", ...)
}

## PUT /admin/api/#{api_version}/draft_orders/#{draft_order_id}/complete.json
## Complete a draft order
#' @rdname DraftOrder
completeDraftOrder <- function(draftOrderId, ...) {
    private$.request(private$.url("draft_orders",draftOrderId), reqType="DELETE", ...)
}
