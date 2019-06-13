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

########### Page functions ########### 
#' @templateVar name Page
#' @templateVar urlSlug online_store/page
#' @template api
NULL

## GET /admin/pages.json
## Retrieves a list of pages
#' @rdname Page
getPages <- function(...) {
    private$.fetchAll("pages", ...)
}

## GET /admin/pages/count.json
##  a page count
#' @rdname Page
getPagesCount <- function(...) {
    private$.request(private$.url("pages","count"), ...)$count
}

## GET /admin/pages/#{page_id}.json
## Retrieves a single page by its ID
#' @rdname Page
getPage <- function(pageId, ...) {
    private$.request(private$.url("pages",pageId), ...)$page
}

## POST /admin/pages.json
## Create a new Page
#' @rdname Page
createPage <- function(page, ...) {
    page <- private$.wrap(page, "page", check=FALSE)
    private$.request("pages", reqType="POST", data=page, ...)$page
}

## PUT /admin/pages/#{page_id}.json
## Updates a page
#' @rdname Page
modifyPage <- function(page, ...) {
    page <- private$.wrap(page, "page")
    private$.request(private$.url("pages",page$page$id), reqType="PUT", data=page, ...)$page
}

## DELETE /admin/pages/#{page_id}.json
## Deletes a page
#' @rdname Page
deletePage <- function(pageId, ...) {
    private$.request(private$.url("pages",pageId), reqType="DELETE", ...)
}
