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

########### roxygen template for Shopify API functions ########### 
<%= article <- ifelse(exists("article") && article == "an", "an", "a") %>
<%= slug <- ifelse(exists("slug"), slug, paste0(tolower(substring(name,1,1)),substring(name,2))) %>
<%= urlSlug <- ifelse(exists("urlSlug"), tolower(urlSlug), tolower(name)) %>
<%= default.params <- ifelse(exists("default.params"), as.logical(default.params), TRUE) %>
<%= default.return <- ifelse(exists("default.return"), as.logical(default.return), TRUE) %>

#' <%= name %> Functions
#' 
<%= if (default.params) paste0("#' @param ",slug,"Id ",article," ",name," id number") %>
<%= if (default.params) paste0("#' @param ",slug," a list containing ",name," fields") %>
#' @param ... additional request parameters
<%= if (default.return) paste0("#' @return a list containing ",article," ",name," fields or a list of ",name,"s") %>
#' @name <%= name %>
#' @references Shopify API <%= name %> documentation: \url{http://docs.shopify.com/api/<%= urlSlug %>}
NULL
