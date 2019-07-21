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

########### MarketingEvent functions ########### 
#' @param engagements a list of one or more engagements
#' @templateVar name MarketingEvent
#' @templateVar urlSlug reference/marketingevent
#' @template api
NULL

## GET /admin/api/#{api_version}/marketing_events.json
## Retrieves a list of all marketing events
#' @rdname MarketingEvent
getMarketingEvents <- function(...) {
    private$.fetchAll("marketing_events", ...)$marketing_events
}

## GET /admin/api/#{api_version}/marketing_events/count.json
## Retrieves a count of all marketing events
#' @rdname MarketingEvent
getMarketingEventsCount <- function(...) {
    private$.request(private$.url("marketing_events","count"), ...)$count
}

## GET /admin/api/#{api_version}/marketing_events/#{marketing_event_id}.json
## Retrieves a single marketing event
#' @rdname MarketingEvent
getMarketingEvent <- function(marketingEventId, ...) {
    private$.request(private$.url("marketing_events",marketingEventId), ...)$marketing_event
}

## POST /admin/api/#{api_version}/marketing_events.json
## Creates a marketing event
#' @rdname MarketingEvent
createMarketingEvent <- function(marketingEvent, ...) {
    marketingEvent <- private$.wrap(marketingEvent, "marketing_event", check=FALSE)
    private$.request("marketing_events", reqType="POST", data=marketingEvent, ...)$marketing_event
}

## PUT /admin/api/#{api_version}/marketing_events/#{marketing_event_id}.json
## Updates a marketing event
#' @rdname MarketingEvent
updateMarketingEvent <- function(marketingEvent, ...) {
    marketingEvent <- private$.wrap(marketingEvent, "marketing_event")
    private$.request(private$.url("marketing_events",marketingEvent$marketingEvent$id), reqType="PUT", data=marketingEvent, ...)$marketing_event
}

## DELETE /admin/api/#{api_version}/marketing_events/#{marketing_event_id}.json
## Deletes a marketing event
#' @rdname MarketingEvent
deleteMarketingEvent <- function(marketingEventId, ...) {
    private$.request(private$.url("marketing_events",marketingEventId), reqType="DELETE", ...)
}

## POST /admin/api/#{api_version}/marketing_events/#{marketing_event_id}/engagements.json
## Creates marketing engagements on a marketing event
#' @rdname MarketingEvent
createMarketingEventEngagements <- function(marketingEventId, engagements, ...) {
    engagements <- private$.wrap(engagements, "engagements", check=FALSE)
    private$.request(private$.url("marketing_events",marketingEventId,"engagements"), reqType="POST", data=engagements, ...)$engagements
}
