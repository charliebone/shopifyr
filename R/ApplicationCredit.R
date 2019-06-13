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

########### ApplicationCredit functions ########### 
#' @templateVar slug credit
#' @templateVar urlSlug billing/applicationcredit
#' @templateVar article an
#' @templateVar name ApplicationCredit
#' @template api
NULL

## POST /admin/application_credits.json
## Creates an application credit
#' @rdname ApplicationCredit
createApplicationCredit <- function(credit, ...) {
    charge <- private$.wrap(charge, "application_credits", check=FALSE)
    private$.request("application_credits", reqType="POST", data=credit, ...)$application_credit
}

## GET /admin/application_credits/#{application_credit_id}.json
## Retrieves a single application credit
#' @rdname ApplicationCredit
getApplicationCredit <- function(creditId, ...) {
    private$.request(private$.url("application_credits",creditId), ...)$application_credit
}

## GET /admin/application_credits.json
## Retrieves all application credits
#' @rdname ApplicationCredit
getApplicationCredits <- function(...) {
    private$.request("application_credits", ...)$application_charges
}
