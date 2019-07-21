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

########### User functions ########### 
#' @param userId a User id
#' @note This functionality is only available to Shopify Plus stores
#' @templateVar name User
#' @templateVar urlSlug plus/user
#' @templateVar default.params FALSE
#' @template api
NULL

## GET /admin/api/#{api_version}/users.json
## Retrieves a list of all users
#' @rdname User
getUsers <- function(...) {
    private$.fetchAll("users", ...)
}

## GET /admin/api/#{api_version}/users/#{user_id}.json
## Retrieves a single user
#' @rdname User
getUser <- function(userId, ...) {
    private$.request(private$.url("users",userId), ...)$user
}

## GET /admin/api/#{api_version}/users/current.json
## Retrieves the currently logged-in user
#' @rdname User
getCurrentUser <- function(...) {
    private$.request(private$.url("users","current"), ...)$user
}
