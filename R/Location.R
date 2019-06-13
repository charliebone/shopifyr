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

########### Location functions ########### 
#' @param locationId a Location id
#' @templateVar name Location
#' @templateVar urlSlug inventory/location
#' @templateVar default.params FALSE
#' @template api
NULL

## GET /admin/locations.json
## Retrieves a list of locations
#' @rdname Location
getLocations <- function(...) {
    private$.request("locations", ...)$locations
}

## GET /admin/locations/#{location_id}.json
## Retrieves a single location by its ID
#' @rdname Location
getLocation <- function(locationId, ...) {
    private$.request(private$.url("locations",locationId), ...)$location
}

## GET /admin/locations/count.json
## Retrieves a count of locations
#' @rdname Location
getLocationsCount <- function(...) {
    private$.request(private$.url("locations","count"), ...)$count
}

## GET /admin/locations/#{location_id}/inventory_levels.json
## Retrieves a list of inventory levels for a location
#' @rdname Location
getLocationInventoryLevels <- function(locationId, ...) {
    private$.request(private$.url("locations",locationId,"inventory_levels"), ...)$inventory_levels
}
