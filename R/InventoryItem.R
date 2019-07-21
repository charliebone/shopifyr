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

########### InventoryItem functions ########### 
#' @param inventoryItemIds a vector of no more than 100 inventory item ids
#' @templateVar name InventoryItem
#' @templateVar urlSlug inventory/inventoryitem
#' @template api
NULL

## GET /admin/api/#{api_version}/inventory_items.json?ids=808950810,39072856,457924702
## Retrieves a list of inventory items
#' @rdname InventoryItem
getInventoryItems <- function(inventoryItemIds, ...) {
    private$.fetchAll("inventory_items", ids=inventoryItemIds, .queryParam="ids", .queryMax=100, ...)
}

## GET /admin/api/#{api_version}/inventory_items/#{inventory_item_id}.json
## Retrieves a single inventory item by its ID
#' @rdname InventoryItem
getInventoryItem <- function(inventoryItemId, ...) {
    private$.request(private$.url("inventory_items",inventoryItemId), ...)$inventory_item
}

## PUT /admin/api/#{api_version}/inventory_items/#{inventory_item_id}.json
## Updates an existing inventory item
#' @rdname InventoryItem
modifyInventoryItem <- function(inventoryItem, ...) {
    inventoryItem <- private$.wrap(inventoryItem, "inventory_item")
    private$.request(private$.url("inventory_items",inventoryItem$inventory_item$id), reqType="PUT", data=inventoryItem, ...)$inventory_item
}
