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

########### InventoryLevel functions ###########
#' @param locationIds a vector of Location ids
#' @param locationId a single Location id
#' @param inventoryItemIds a vector of InventoryItem ids
#' @param inventoryItemId a single InventoryItem id
#' @param inventoryLevel a list containing InventoryLevel fields
#' @templateVar name InventoryLevel
#' @templateVar urlSlug inventory/inventorylevel
#' @templateVar default.params FALSE
#' @template api
NULL

## GET /admin/inventory_levels.json
## Retrieves a list of inventory levels
#' @rdname InventoryLevel
getInventoryLevels <- function(locationIds, inventoryItemIds, ...) {
    if (missing(locationIds) && missing(inventoryItemIds)) 
        stop("must provide 'locationIds', 'inventoryItemIds' or both")
    
    if (missing(locationIds)) {
        private$.fetchAll("inventory_levels", inventory_item_ids=inventoryItemIds, .queryParam="inventory_item_ids", .queryMax=50, ...)
    } else if (missing(inventoryItemIds)) {
        private$.fetchAll("inventory_levels", location_ids=locationIds, .queryParam="location_ids", .queryMax=50, ...)
    } else {
        # have both
        inventoryItemIds <- paste0(inventoryItemIds, collapse=",") 
        locationIds <- paste0(locationIds, collapse=",")
        private$.fetchAll("inventory_levels", inventory_item_ids=inventoryItemIds, location_ids=locationIds, ...)
    }
}

## POST /admin/inventory_levels/adjust.json
## Adjusts the inventory level of an inventory item at a location
#' @rdname InventoryLevel
modifyInventoryLevel <- function(inventoryLevel, ...) {
    private$.request(private$.url("inventory_levels","adjust"), reqType="POST", data=inventoryLevel, ...)$inventory_level
}

## DELETE /admin/inventory_levels.json?inventory_item_id=808950810&location_id=905684977
## Deletes an inventory level from a location
#' @rdname InventoryLevel
deleteInventoryLevel <- function(locationId, inventoryItemId, ...) {
    private$.request("inventory_levels", inventory_item_id=inventoryItemId, location_id=locationId, ...)
}

## POST /admin/inventory_levels/connect.json
## Connects an inventory item to a location
#' @rdname InventoryLevel
connectInventoryItem <- function(locationId, inventoryItemId, ...) {
    inventoryLevel <- list(location_id=locationId, inventory_item_id=inventoryItemId)
    private$.request(private$.url("inventory_levels","connect"), reqType="POST", data=inventoryLevel, ...)$inventory_level
}

## POST /admin/inventory_levels/set.json
## Sets the inventory level for an inventory item at a location
#' @rdname InventoryLevel
setInventoryLevel <- function(inventoryLevel, ...) {
    private$.request(private$.url("inventory_levels","set"), reqType="POST", data=inventoryLevel, ...)$inventory_level
}

