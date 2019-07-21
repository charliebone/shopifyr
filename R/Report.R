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

########### Report functions ########### 
#' @templateVar name Report
#' @templateVar urlSlug analytics/report
#' @template api
NULL

## GET /admin/api/#{api_version}/reports.json
## Retrieves a list of reports
#' @rdname Report
getReports <- function(...) {
    private$.fetchAll("reports", ...)
}

## GET /admin/api/#{api_version}/reports/#{report_id}.json
## Retrieves a single report
#' @rdname Report
getReport <- function(reportId, ...) {
    private$.request(private$.url("reports",reportId), ...)$report
}

## POST /admin/api/#{api_version}/reports.json
## Creates a new report
#' @rdname Report
createReport <- function(report, ...) {
    report <- private$.wrap(report, "report", check=FALSE)
    private$.request("reports", reqType="POST", data=report, ...)$report
}

## PUT /admin/api/#{api_version}/reports/#{report_id}.json
## Updates a report
#' @rdname Report
modifyReport <- function(report, ...) {
    report <- private$.wrap(report, "report")
    private$.request(private$.url("reports",report$report$id), reqType="PUT", data=report, ...)$report
}

## DELETE /admin/api/#{api_version}/reports/#{report_id}.json
## Deletes a report
#' @rdname Report
deleteReport <- function(reportId, ...) {
    private$.request(private$.url("reports",reportId), reqType="DELETE", ...)
}