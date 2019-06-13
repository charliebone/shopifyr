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

########### AccessScope functions ########### 
#' @templateVar name AccessScope
#' @templateVar urlSlug access/accessscope
#' @templateVar article an
#' @templateVar default.params FALSE
#' @template api
NULL

## GET /admin/oauth/access_scopes.json
## Retrieves a list of access scopes associated to the access token
#' @rdname AccessScope
getAccessScopes <- function(...) {
    private$.fetchAll("access_scopes", ...)
}
