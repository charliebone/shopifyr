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

########### Theme functions ########### 
#' @templateVar name Theme
#' @templateVar urlSlug online_store/theme
#' @template api
NULL

## GET /admin/api/#{api_version}/themes.json
## Receive a list of all Themes
#' @rdname Theme
getThemes <- function(...) {
    private$.request("themes", ...)$themes
}

## GET /admin/api/#{api_version}/themes/#{id}.json
## Receive a single Theme
#' @rdname Theme
getTheme <- function(themeId, ...) {
    private$.request(private$.url("themes",themeId), ...)$theme
}

## POST /admin/api/#{api_version}/themes.json
## Create a new Theme
#' @rdname Theme
createTheme <- function(theme, ...) {
    theme <- private$.wrap(theme, "theme", check="name")
    private$.request("themes", reqType="POST", data=theme, ...)$theme
}

## PUT /admin/api/#{api_version}/themes/#{id}.json
## Modify an existing Theme
#' @rdname Theme
modifyTheme <- function(theme, ...) {
    theme <- private$.wrap(theme, "theme")
    private$.request(private$.url("themes",theme$theme$id), reqType="PUT", data=theme, ...)$theme
}

## DELETE /admin/api/#{api_version}/themes/#{id}.json
## Remove a Theme from the database
#' @rdname Theme
deleteTheme <- function(themeId, ...) {
    private$.request(private$.url("themes",themeId), reqType="DELETE", ...)
}