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

########### DiscountCode functions ###########
#' @param priceRuleId a \code{\link{PriceRule}} id
#' @param code one discount code string
#' @param codes one or more discount code strings
#' @param batchId an id of a DiscountCode batch job
#' @templateVar name DiscountCode
#' @templateVar urlSlug discounts/discountcode
#' @template api
NULL

## POST /admin/api/#{api_version}/price_rules/#{price_rule_id}/discount_codes.json
## Creates a discount code
#' @rdname DiscountCode
createDiscountCode <- function(priceRuleId, code, ...) {
    discountCode <- private$.wrap(list(code=code), "discount_code")
    private$.request(private$.url("price_rules",priceRuleId,"discount_codes"), reqType="POST", data=discountCode, ...)$discount_code
}

## PUT /admin/api/#{api_version}/price_rules/#{price_rule_id}/discount_codes/#{discount_code_id}.json
## Updates an existing discount code
#' @rdname DiscountCode
modifyDiscountCode <- function(priceRuleId, discountCode, ...) {
    discountCode <- private$.wrap(discountCode, "discount_code")
    private$.request(private$.url("price_rules",priceRuleId,"discount_codes",discountCode$discount_code$id), reqType="PUT", data=discountCode, ...)$discount_code
}

## GET /admin/api/#{api_version}/price_rules/#{price_rule_id}/discount_codes.json
## Retrieves a list of discount codes
#' @rdname DiscountCode
getDiscountCodes <- function(priceRuleId, ...) {
    private$.fetchAll(private$.url("price_rules",priceRuleId,"discount_codes"), ...)
}

## GET /admin/api/#{api_version}/price_rules/#{price_rule_id}/discount_codes/#{discount_code_id}.json
## Retrieves a single discount code
#' @rdname DiscountCode
getDiscountCode <- function(priceRuleId, discountCodeId, ...) {
    private$.request(private$.url("price_rules",priceRuleId,"discount_codes",discountCodeId), ...)$discount_code
}

## GET /admin/api/#{api_version}/discount_codes/lookup.json?code=SUMMERSALE10OFF
## Retrieves the location of a discount code
#' @rdname DiscountCode
getDiscountCodeLocation <- function(code, ...) {
    private$.request(private$.url("discount_codes","lookup"), code=code, getRedirectUrl=TRUE, ...)
}

## DELETE /admin/api/#{api_version}/price_rules/#{price_rule_id}/discount_codes/#{discount_code_id}.json
## Deletes a discount code
#' @rdname DiscountCode
deleteDiscountCode <- function(priceRuleId, discountCodeId, ...) {
    private$.request(private$.url("price_rules",priceRuleId,"discount_codes",discountCodeId), reqType="DELETE", ...)
}

## POST /admin/api/#{api_version}/price_rules/#{price_rule_id}/batch.json
## Creates a discount code creation job
#' @rdname DiscountCode
createDiscountCodesCreationJob <- function(priceRuleId, codes, ...) {
    discountCodes <- private$.wrap(lapply(codes, function(x) list(code=x)), "discount_codes", check=FALSE)
    private$.request(private$.url("price_rules",priceRuleId,"batch"), reqType="POST", data=discountCodes, ...)$discount_code_creation
}

## GET /admin/api/#{api_version}/price_rules/#{price_rule_id}/batch/#{batch_id}.json
## Retrieves a discount code creation job
#' @rdname DiscountCode
getDiscountCodesCreationJob <- function(priceRuleId, batchId, ...) {
    private$.request(private$.url("price_rules",priceRuleId,"batch",batchId), ...)$discount_code_creation
}

## GET /admin/api/#{api_version}/price_rules/#{price_rule_id}/batch/#{batch_id}/discount_codes.json
## Retrieves a list of discount codes for a discount code creation job
#' @rdname DiscountCode
getDiscountCodesFromCreationJob <- function(priceRuleId, batchId, ...) {
    private$.request(private$.url("price_rules",priceRuleId,"batch",batchId,"discount_codes"), ...)$discount_codes
}
