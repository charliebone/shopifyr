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

########### PriceRule functions ########### 
#' @templateVar name PriceRule
#' @templateVar urlSlug discounts/pricerule
#' @template api
NULL

## GET /admin/api/#{api_version}/price_rules.json
## Receive a list of all PriceRules
#' @rdname PriceRule
getPriceRules <- function(...) {
    private$.fetchAll("priceRules", ...)
}

## GET /admin/api/#{api_version}/price_rules/count.json
## Receive a count of all PriceRules
#' @rdname PriceRule
getPriceRulesCount <- function(...) {
    private$.request(private$.url("price_rules","count"), ...)$count
} 

## GET /admin/api/#{api_version}/price_rules/#{id}.json
## Receive a single PriceRule
#' @rdname PriceRule
getPriceRule <- function(priceRuleId, ...) {
    private$.request(private$.url("price_rules",priceRuleId), ...)$price_rule
}

## POST /admin/api/#{api_version}/price_rules.json
## Create a new PriceRule
#' @rdname PriceRule
createPriceRule <- function(priceRule, ...) {
    priceRule <- private$.wrap(priceRule, "price_rule", check=FALSE)
    private$.request("price_rules", reqType="POST", data=priceRule, ...)$price_rule
}

## PUT /admin/api/#{api_version}/price_rules/#{id}.json
## Modify an existing PriceRule
#' @rdname PriceRule
modifyPriceRule <- function(priceRule, ...) {
    priceRule <- private$.wrap(priceRule, "price_rule")
    private$.request(private$.url("price_rules",priceRule$price_rule$id), reqType="PUT", data=priceRule, ...)$price_rule
}

## DELETE /admin/api/#{api_version}/price_rules/#{id}.json
## Remove a PriceRule from the database
#' @rdname PriceRule
deletePriceRule <- function(priceRuleId, ...) {
    private$.request(private$.url("price_rules",priceRuleId), reqType="DELETE", ...)
}