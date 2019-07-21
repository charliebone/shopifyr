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

########### CarrierService functions ########### 
#' @templateVar name CarrierService
#' @templateVar slug service
#' @templateVar urlSlug shipping_and_fulfillment/carrierservice
#' @template api
NULL

## POST /admin/api/#{api_version}/carrier_services.json
## Create a new CarrierService
#' @rdname CarrierService
createCarrierService <- function(service, ...) {
    service <- private$.wrap(service, "carrier_service", check=FALSE)
    private$.request("carrier_services", reqType="POST", data=service, ...)$carrier_service
}

## PUT /admin/api/#{api_version}/carrier_services/#{id}.json
## Modify an existing CarrierService
#' @rdname CarrierService
modifyCarrierService <- function(service, ...) {
    service <- private$.wrap(service, "carrier_service")
    private$.request(private$.url("carrier_services",service$carrier_service$id), reqType="PUT", data=service, ...)$carrier_service
}

## GET /admin/api/#{api_version}/carrier_services.json
## Receive a list of all CarrierServices
#' @rdname CarrierService
getCarrierServices <- function(...) {
    private$.request("carrier_services", ...)$carrier_services
}

## GET /admin/api/#{api_version}/carrier_services/#{id}.json
## Receive a single CarrierService
#' @rdname CarrierService
getCarrierService <- function(serviceId, ...) {
    private$.request(private$.url("carrier_services",serviceId), ...)$carrier_service
}

## DELETE /admin/api/#{api_version}/carrier_services/#{id}.json
## Remove a CarrierService from the database
#' @rdname CarrierService
deleteCarrierService <- function(serviceId, ...) {
    private$.request(private$.url("carrier_services",serviceId), reqType="DELETE", ...)
}