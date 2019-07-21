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

########### Article functions ########### 
#' @param blogId a \code{\link{Blog}} id number
#' @templateVar name Article
#' @templateVar urlSlug online_store/blog_article
#' @templateVar article an
#' @template api
NULL

## GET /admin/api/#{api_version}/blogs/#{id}/articles.json
## Receive a list of all Articles
#' @rdname Article
getArticles <- function(blogId, ...) {
    private$.fetchAll(private$.url("blogs",blogId,"articles"), "articles", ...)
}

## GET /admin/api/#{api_version}/blogs/#{id}/articles/count.json
## Receive a count of all Articles
#' @rdname Article
getArticlesCount <- function(blogId, ...) {
    private$.request(private$.url("blogs",blogId,"articles","count"), ...)$count
} 

## GET /admin/api/#{api_version}/blogs/#{id}/articles/#{id}.json
## Receive a single Article
#' @rdname Article
getArticle <- function(blogId, articleId, ...) {
    private$.request(private$.url("blogs",blogId,"articles",articleId), ...)$article
}

## POST /admin/api/#{api_version}/blogs/#{id}/articles.json
## Create a new Article
#' @rdname Article
createArticle <- function(blogId, article, ...) {
    article <- private$.wrap(article, "article", check=FALSE)
    private$.request(private$.url("blogs",blogId,"articles"), reqType="POST", data=article, ...)$article
}

## PUT /admin/api/#{api_version}/blogs/#{id}/articles/#{id}.json
## Modify an existing Article
#' @rdname Article
modifyArticle <- function(blogId, article, ...) {
    article <- private$.wrap(article, "article")
    private$.request(private$.url("blogs",blogId,"articles",article$article$id), reqType="PUT", data=article, ...)$article
}

## GET /admin/api/#{api_version}/articles/authors.json
## Get a list of all the authors
#' @rdname Article
getArticleAuthors <- function(...) {
    private$.request(private$.url("articles","authors"), ...)$authors
}

## GET /admin/api/#{api_version}/articles/tags.json
## Get a list of all the tags
#' @rdname Article
getArticleTags <- function(...) {
    private$.request(private$.url("articles","tags"), ...)$tags
}

## DELETE /admin/api/#{api_version}/blogs/#{id}/articles/#{id}.json
## Remove a Article from the database
#' @rdname Article
deleteArticle <- function(blogId, articleId, ...) {
    private$.request(private$.url("blogs",blogId,"articles",articleId), reqType="DELETE", ...)
}