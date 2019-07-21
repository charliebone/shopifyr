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

########### AbandonedCheckout functions ########### 
#' @templateVar name AbandonedCheckout
#' @templateVar urlSlug orders/abandoned_checkouts
#' @templateVar default.params FALSE
#' @template api
NULL

## GET /admin/api/#{api_version}/checkouts.json
## Receive a list of all Abandoned checkouts
#' @rdname AbandonedCheckout
getAbandonedCheckouts <- function(...) {
    private$.fetchAll("checkouts", ...)
}

## GET /admin/api/#{api_version}/checkouts/count.json
## Receive a count of all Abandoned Checkouts
#' @rdname AbandonedCheckout
getAbandonedCheckoutsCount <- function(...) {
    private$.request(private$.url("checkouts","count"), ...)$count
}
