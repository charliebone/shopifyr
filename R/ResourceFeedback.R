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

########### ResourceFeedback functions ########### 
#' @param resourceFeedback a list containing ResourceFeedback fields
#' @templateVar name ResourceFeedback
#' @templateVar urlSlug sales-channels/resourcefeedback
#' @templateVar default.params FALSE
#' @template api
NULL

## POST /admin/api/#{api_version}/resource_feedback.json
## Create a new ResourceFeedback
#' @rdname ResourceFeedback
createResourceFeedback <- function(resourceFeedback, ...) {
    resourceFeedback <- private$.wrap(resourceFeedback, "resource_feedback", check=FALSE)
    private$.request("resource_feedback", reqType="POST", data=resourceFeedback, ...)$resource_feedback
}

## GET /admin/api/#{api_version}/resource_feedback.json
## Receive a list of all ResourceFeedbacks
#' @rdname ResourceFeedback
getResourceFeedbacks <- function(...) {
    private$.fetchAll("resource_feedback", ...)
}
