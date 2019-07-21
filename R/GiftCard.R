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

########### GiftCard functions ########### 
#' @param query a query string to use when searching GiftCards
#' @templateVar name GiftCard
#' @templateVar urlSlug products/product
#' @template api
NULL

## GET /admin/api/#{api_version}/gift_cards.json
## Retrieves a list of gift cards
#' @rdname GiftCard
getGiftCards <- function(...) {
    private$.fetchAll("gift_cards", ...)
}

## GET /admin/api/#{api_version}/gift_cards/#{gift_card_id}.json
## Retrieves a single gift card
#' @rdname GiftCard
getGiftCard <- function(giftCardId, ...) {
    private$.request(private$.url("gift_cards",giftCardId), ...)$gift_card
}

## GET /admin/api/#{api_version}/gift_cards/count.json
## Retrieves a count of gift cards
#' @rdname GiftCard
getGiftCardsCount <- function(...) {
    private$.request(private$.url("gift_cards","count"), ...)$count
}

## POST /admin/api/#{api_version}/gift_cards.json
## Creates a gift card
#' @rdname GiftCard
createGiftCard <- function(giftCard, ...) {
    giftCard <- private$.wrap(giftCard, "gift_card", check=FALSE)
    private$.request("gift_cards", reqType="POST", data=giftCard, ...)$gift_card
}

## PUT /admin/api/#{api_version}/gift_cards/#{gift_card_id}.json
## Updates an existing gift card
#' @rdname GiftCard
modifyGiftCard <- function(giftCard, ...) {
    product <- private$.wrap(giftCard, "gift_card")
    private$.request(private$.url("gift_cards",giftCard$gift_card$id), reqType="PUT", data=giftCard, ...)$gift_card
}

## POST /admin/api/#{api_version}/gift_cards/#{gift_card_id}/disable.json
## Disables a gift card
#' @rdname GiftCard
disableGiftCard <- function(giftCardId, ...) {
    private$.request(private$.url("gift_cards",giftCardId,"disable"), reqType="POST", ...)
}

## GET /admin/api/#{api_version}/gift_cards/search.json?query=mnop
## Searches for gift cards
#' @rdname GiftCard
searchGiftCards <- function(query, ...) {
    private$.request(private$.url("gift_cards","search"), query=query, .queryParam="query", ...)$gift_cards
}
