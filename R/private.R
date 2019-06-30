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

########### ShopifyShop constructor ###########
.initialize <- function(shopURL, password, quiet = FALSE) {
    if (missing(shopURL)) stop("shopURL is required to create a ShopifyShop")
    if (missing(password)) stop("password is required to create a ShopifyShop")
    
    self$shopURL <- paste0(gsub(".myshopify.com", "", tolower(shopURL)), ".myshopify.com")
    self$password <- password
    
    # fetch shop information
    self$shopInfo <- try(self$getShop(), silent=TRUE)
    if (inherits(self$shopInfo, "try-error"))
        stop(paste("Error accessing Shopify : ", attr(self$shopInfo,"condition")$message))
    
    # show announcements if there are any
    if (!isTRUE(quiet))
        self$showAnnouncements()
}

########### ShopifyShop print method ###########
print.ShopifyShop <- function(...) {
    cat("--", self$shopInfo$name, "Shopify API Client --\n")
    cat("Site Domain:", self$shopInfo$domain, "\n")
    cat("Shopify Domain:", self$shopInfo$myshopify_domain, "\n")
}

########### Private ShopifyShop member functions ###########
#' @importFrom utils URLencode
.params <- function(params) {
    nms <- names(params)
    ret <- NULL
    for (i in 1:length(params)) {
        if (is.null(params[[i]])) 
            next
        if (!is.null(ret))
            ret <- paste0(ret, "&")
        
        prms <- sapply(as.character(params[[i]]), URLencode)
        if (length(prms) > 1)
            ret <- paste0(ret, URLencode(nms[i]), "=", paste0(prms, collapse=paste0(URLencode(nms[i]),"=")))
        else 
            ret <- paste0(ret, URLencode(nms[i]), "=", prms)
    }
    ret
}

.url <- function(...) { 
    paste0(Filter(Negate(is.null), list(...)), collapse="/") 
}

.baseUrl <- function() {
    paste0("https://",self$shopURL,"/admin/api/",private$.apiVersion,"/")
}

.graphQlUrl <- function(type = "admin") {
    paste0(private$.baseUrl(),"graphql.json")
}

.wrap <- function(data, name, check = "id") {
    if ((length(data) != 1) || (names(data) != name)) {
        ret <- list()
        ret[[name]] <- data
    } else ret <- data
    
    if (is.character(check)) {
        missingFields <- check[which(!check %in% names(ret[[name]]))]
        if (length(missingFields) > 0)
            stop(paste(name, "missing mandatory field(s): ", paste(missingFields, collapse=", ")))
    }
    ret
}

.fetchAll <- function(slug, name = slug, limit = 250, page = NULL, sinceId = 0, paceRequests = TRUE, queryParam = NULL, queryMax = 100, silent = FALSE, ...) {
    if (!is.null(queryParam)) {
        dots <- list(...)
        if (!queryParam %in% names(dots)) 
            stop(paste0("specified queryParam '",queryParam,"' not found as argument to fetchAll"))
        
        querySplits <- split(dots[[queryParam]], ceiling(seq_along(dots[[queryParam]]) / queryMax))
        baseArgs <- list(slug=slug, name=name, limit=limit, paceRequests=paceRequests, queryParam=NULL, silent=silent)
        baseArgs <- c(baseArgs, dots[-which(names(dots) == queryParam)])
        
        results <- lapply(querySplits, function(x) {
            fargs <- baseArgs
            fargs[[queryParam]] <- paste0(x, collapse=",")
            do.call(private$.fetchAll, fargs)
        })
        
        return(do.call(c, results))
    }
    
    if (is.null(page)) {
        env <- new.env()
        
        req <- 1
        if (!isTRUE(silent))
            message(paste0("Request ",req,": fetching ",gsub("_"," ",name,fixed=TRUE)," 1 - ",limit))
        
        result <- private$.request(slug, limit=limit, since_id=sinceId, ...)
        env[[paste0("r",req)]] <- result[[name]]
        
        while (length(result[[name]]) == limit) {
            req <- req + 1
            sinceId <- sapply(result[[name]], `[[`, "id")[length(result[[name]])]
            
            if (!isTRUE(silent))
                message(paste0("Request ",req,": fetching ",gsub("_"," ",name,fixed=TRUE)," ",(req-1)*limit+1," - ",req*limit))
            
            result <- private$.request(slug, limit=limit, since_id=sinceId, paceRequests=paceRequests, ...)
            env[[paste0("r",req)]] <- result[[name]]
        }
        
        # combine results
        fetched <- do.call(c, lapply(ls(env), function(nm) env[[nm]]))
    } else {
        # if page is specified, just make the request
        fetched <- private$.request(slug, limit=limit, page=page, paceRequests=paceRequests, ...)[[name]]
    }
    fetched
}

#' @importFrom jsonlite toJSON
#' @importFrom jsonlite validate
.encode <- function(data, validate = TRUE) {
    if (is.list(data)) {
        if (length(data) == 0)
            data <- "{}" # use '{}' not '[]' which toJSON() would give for empty list
        else
            data <- jsonlite::toJSON(data, digits=20, auto_unbox=TRUE)
    } else if (is.character(data)) {
        isValid <- !isTRUE(validate) || jsonlite::validate(data)
        if (!isTRUE(isValid)) stop(attr(isValid, "err"))
    } else {
        stop("data must be of type list or character")
    }
    data
}

.graphQlRequest <- function(query, 
                            paceRequests = TRUE, 
                            parse. = TRUE, 
                            verbose = FALSE, 
                            retryCount = 1) {
    private$.request(data=query, 
                     graphQl=TRUE, 
                     paceRequests=paceRequests,
                     parse.=parse., 
                     verbose=verbose,
                     retryCount = retryCount)
}

#' @importFrom curl curl_fetch_memory
#' @importFrom curl parse_headers_list
.request <- function(slug, reqType = "GET", 
                     data = NULL, 
                     paceRequests = TRUE,
                     ..., 
                     parse. = TRUE, 
                     type. = "json",
                     graphQl = FALSE,
                     verbose = FALSE,
                     retryCount = 1) {
    
    # generate url and check request type
    if (isTRUE(graphQl)) {
        reqUrl <- private$.graphQlUrl()
        reqType <- "POST"
    } else {
        reqUrl <- paste0(private$.baseUrl(), slug, ".", type.)
        reqType <- match.arg(toupper(reqType), c("GET","POST","PUT","DELETE"))
    }
    
    # parse url parameters
    params <- list(...)
    if (!is.null(params) && length(params) > 0)
        reqUrl <- paste0(reqUrl, "?", private$.params(params))
    
    # pace requests
    while(isTRUE(paceRequests) && ((isTRUE(graphQl) && !private$.costLimitOk()) || (!isTRUE(graphQl) && !private$.rateLimitOk()))) { } 
    
    # send request
    handle <- private$.createHandle(reqType, data=data, verbose=verbose, graphQl=graphQl, encodeData=parse.)
    res <- try(curl::curl_fetch_memory(reqUrl, handle=handle), silent=TRUE)
    
    # check result for error
    if (inherits(res, "try-error")) {
        if (retryCount > 0) {
            return(private$.request(slug=slug, 
                                reqType=reqType, 
                                data=data, 
                                ..., 
                                parse.=parse., 
                                type.=type., 
                                graphQl=graphQl,
                                verbose=verbose,
                                retryCount=retryCount-1))
        } else 
            stop(attr(res,"condition")$message)
    }
    
    private$.responseHeaders <- curl::parse_headers_list(res$headers)
    
    # parse response
    rawResult <- rawToChar(res$content)
    if (isTRUE(parse.)) {
        parsedResult <- try(private$.parseResponseBody(rawResult), silent=TRUE)
        if (inherits(parsedResult, "try-error")) {
            if (retryCount > 0) {
                return(private$.request(slug=slug, 
                                        reqType=reqType, 
                                        data=data, 
                                        ..., 
                                        parse.=parse., 
                                        type.=type., 
                                        graphQl=graphQl,
                                        verbose=verbose,
                                        retryCount=retryCount-1))
            } else 
                stop(paste("Error parsing response body :", attr(parsedResult,"condition")$message))
        }
    }
    
    # update rate limit
    if (isTRUE(paceRequests)) {
        if (isTRUE(graphQl)) {
            # parse results if we haven't already to get cost info
            if (!isTRUE(parse.)) 
                parsedResult <- try(private$.parseResponseBody(rawResult), silent=TRUE)
            
            if (!inherits(parsedResult, "try-error")) 
                private$.updateCostLimit(parsedResult$extensions)
        } else {
            private$.updateRateLimit()
        }
    }
    
    # return response
    if (!isTRUE(parse.)) 
        return(rawResult)
    else
        return(parsedResult)
}

#' @importFrom curl new_handle
#' @importFrom curl handle_setopt
#' @importFrom curl handle_setheaders
.createHandle <- function(reqType, data, verbose = FALSE, graphQl = FALSE, encodeData = TRUE) {
    handle <- curl::new_handle(sslversion = 6L, # force TLS v1.2
                               post = ifelse(reqType=="POST",1L,0L),
                               customrequest = reqType,
                               verbose = verbose)
    
    if (isTRUE(graphQl)) {
        reqType <- "POST"
        contentType <- "application/graphql"
    } else {
        contentType <- "application/json"
    }
    
    # add form data for POST or PUT requests
    if (reqType %in% c("POST","PUT")){
        if (isTRUE(encodeData) && !is.null(data))
            data <- private$.encode(data, validate=!isTRUE(graphQl))
    
        handle <- curl::handle_setopt(handle, postfields=data)
    }
    
    # set request headers
    handle <- curl::handle_setheaders(handle, 'Content-Type' = contentType,
                                              'Accept' = 'application/json',
                                              'X-Shopify-Access-Token' = self$password)
    private$.curlHandle <- handle
    handle
}

.updateRateLimit <- function(timestamp = Sys.time()) {
    private$.lastReqTime <- timestamp
    
    limitStr <- private$.responseHeaders[["x-shopify-shop-api-call-limit"]]
    if (!is.null(limitStr)) {
        split <- suppressWarnings(as.integer(strsplit(limitStr,"/",fixed=TRUE)[[1]]))
        if (length(split) == 2 && all(!is.na(split))) {
            private$.rateLimitUsed <- split[1]
            private$.rateLimitTotal <- split[2]
        }
    }
}

.rateLimitOk <- function() {
    if (is.null(private$.lastReqTime)) return(TRUE) 
    
    if ((private$.rateLimitTotal - private$.rateLimitUsed) > 2) return (TRUE)
    
    # if at limit and less than a second since last request then not ok
    return(difftime(Sys.time(), private$.lastReqTime, units="secs") >= 1)
}

.updateCostLimit <- function(extensions, timestamp = Sys.time()) {
    private$.costLimitUsed <- extensions$cost$throttleStatus$currentlyAvailable
    private$.costLimitTotal <- extensions$cost$throttleStatus$maximumAvailable
    private$.costLimitRestoreRate <- extensions$cost$throttleStatus$restoreRate
    
    return(TRUE)
}

.costLimitOk <- function() {
    if (is.null(private$.lastReqTime)) return(TRUE) 
    
    # not sure of best method as it depends on future query cost
    return(TRUE)
}

#' @importFrom jsonlite fromJSON
.parseResponseBody <- function(response) {
    if (missing(response) || is.null(response) || nchar(response) < 2)
        return(NULL)
    
    parsed <- jsonlite::fromJSON(response, simplifyDataFrame=FALSE)
    
    if (!is.null(parsed$errors))
        stop(paste(parsed$errors, collapse="; "), call.=FALSE)
    
    parsed
}

.parseShopifyTimestamp <- function(str) {
    # strings are in format like "2015-01-23T00:01:00-04:00" 
    # strip out last colon so %z works
    as.POSIXct(gsub("^(\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}-\\d{2}):(\\d{2})$", "\\1\\2", str), format="%FT%T%z")
}

.encodeImageFile <- function(filepath) {
    if (!file.exists(filepath))
        stop("image file does not exist")
    
    if (!requireNamespace("base64enc"))
        stop("The 'base64enc' package is required to upload images to Shopify")
    
    imgData <- base64enc::base64encode(filepath)
    image <- list(attachment = imgData, filename = basename(filepath))
    image
}
