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

########### UsageCharge functions ########### 
#' @param recurringApplicationChargeId a \code{\link{RecurringApplicationCharge}} id
#' @templateVar name UsageCharge
#' @templateVar urlSlug billing/usagecharge
#' @template api
NULL

## POST /admin/api/#{api_version}/recurring_application_charges/#{recurring_application_charge_id}/usage_charges.json
## Creates a usage charge
#' @rdname UsageCharge
createUsageCharge <- function(recurringApplicationChargeId, usageCharge, ...) {
    usageCharge <- private$.wrap(usageCharge, "usage_charge", check=FALSE)
    private$.request(private$.url("recurring_application_charges",recurringApplicationChargeId,"usage_charges"), reqType="POST", data=usageCharge, ...)$usage_charge
}

## GET /admin/api/#{api_version}/recurring_application_charges/#{recurring_application_charge_id}/usage_charges/#{usage_charge_id}.json
## Retrieves a single charge
#' @rdname UsageCharge
getUsageCharge <- function(recurringApplicationChargeId, usageChargeId, ...) {
    private$.request(private$.url("recurring_application_charges",recurringApplicationChargeId,"usage_charges",usageChargeId), ...)$usage_charge
}

## GET /admin/api/#{api_version}/recurring_application_charges/#{recurring_application_charge_id}/usage_charges.json
## Retrieves a list of usage charges
#' @rdname UsageCharge
getUsageCharges <- function(recurringApplicationChargeId, ...) {
    private$.fetchAll(private$.url("recurring_application_charges",recurringApplicationChargeId,"usage_charges"), "usage_charges", ...)
}
