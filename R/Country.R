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

########### Country functions ########### 
#' @templateVar name Country
#' @templateVar urlSlug store_properties/country
#' @template api
NULL

## GET /admin/api/#{api_version}/countries.json
## Receive a list of all Countries
#' @rdname Country
getCountries <- function(...) {
    private$.request("countries", ...)$countries
}

## GET /admin/api/#{api_version}/countries/count.json
## Receive a count of all Countries
#' @rdname Country
getCountriesCount <- function(...) {
    private$.request(private$.url("countries","count"), ...)$count
}

## GET /admin/api/#{api_version}/countries/#{id}.json
## Receive a single Country
#' @rdname Country
getCountry <- function(countryId, ...) {
    private$.request(private$.url("countries",countryId), ...)$country
}

## POST /admin/api/#{api_version}/countries.json
## Create a new Country
#' @rdname Country
createCountry <- function(country, ...) {
    country <- private$.wrap(country, "country", check=FALSE)
    private$.request("countries", reqType="POST", data=country, ...)$country
}

## PUT /admin/api/#{api_version}/countries/#{id}.json
## Modify an existing Country
#' @rdname Country
modifyCountry <- function(country, ...) {
    country <- private$.wrap(country, "country")
    private$.request(private$.url("countries",country$country$id), reqType="PUT", data=country, ...)$country
}

## DELETE /admin/api/#{api_version}/countries/#{id}.json
## Remove a Country from the database
#' @rdname Country
deleteCountry <- function(countryId, ...) {
    private$.request(private$.url("countries",countryId), reqType="DELETE", ...)
}