#
#   shopifyr: An R Interface to the Shopify API
#
#   Copyright (C) 2014 Charlie Friedemann cfriedem @ gmail.com
#   Shopify API (c) 2006-2014 Shopify Inc.
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

########### ShopifyShop class definition ########### 
#' ShopifyShop class
#' 
#' The \code{ShopifyShop} class fully encapsulates the Shopify API. It is an \code{\link{R6}} class, and
#' as such is initialized via the \sQuote{new} function (see the example section for details). 
#' 
#' In order to access the Shopify API, users will need a set of authorized API access credentials.
#' Generally, users will create these so-called \sQuote{private app} credentials in their Shopify store's
#' admin section. More information about how to do this can be found 
#' \href{http://docs.shopify.com/api/tutorials/creating-a-private-app}{here}. Once the credentials are
#' created, they remain valid and can be used in subsequent R sessions.
#' 
#' @field shopInfo information about the shop as returned by \code{\link{getShop}}
#' 
#' @param shopName the name of your shop, as in shop-name.myshopify.com
#' @param apiKey the API key authorized in the Shopify admin
#' @param password the Shopify API password to be used with the API key
#' @param sharedSecret an authorized shared secret to be used with the API key
#' @param quiet suppress output of API announcements
#' @return a ShopifyShop object
#' 
#' @usage
#' ShopifyShop$new(shopName, apiKey, password, sharedSecret, quiet = FALSE)
#' 
#' @examples
#' \dontrun{
#' # Before you can access the API, you must create a ShopifyShop object using your credentials
#' shop <- ShopifyShop$new("yourstore.myshopify.com","api_key","password","shared_secret")
#' 
#' # Get all collections
#' collections <- shop$getCollections()
#' 
#' # Get customers named Bob from the United States
#' bobs <- shop$getCustomers("Bob country:United States")
#' 
#' # Create a new product
#' product <- list(title="The R Inferno",
#'                 body="<b>The R Inferno</b><i>by Patrick Burns</i>",
#'                 vendor="Burns Statistics",
#'                 product_type="Paperback",
#'                 images=list(list(src="http://www.burns-stat.com/wp-content/
#'                                       uploads/2012/12/R_inferno_cover.jpg")))
#' newProduct <- shop$createProduct(product)
#' }
#' 
#' @format NULL
#' 
#' @section Public Functions: 
#' \describe{
#' \item{ApplicationCharge functions}{\itemize{
#'      \item \code{\link{createApplicationCharge}}
#'      \item \code{\link{getApplicationCharge}}
#'      \item \code{\link{getApplicationCharges}}
#'      \item \code{\link{activateApplicationCharge}}
#' }}
#' \item{Article functions}{\itemize{
#'      \item \code{\link{getArticles}}
#'      \item \code{\link{getArticlesCount}}
#'      \item \code{\link{getArticle}}
#'      \item \code{\link{createArticle}}
#'      \item \code{\link{modifyArticle}}
#'      \item \code{\link{getArticleAuthors}}
#'      \item \code{\link{getArticleTags}}
#'      \item \code{\link{deleteArticle}}
#' }}
#' \item{Asset functions}{\itemize{
#'      \item \code{\link{getAssets}}
#'      \item \code{\link{getAsset}}
#'      \item \code{\link{createAsset}}
#'      \item \code{\link{modifyAsset}}
#'      \item \code{\link{deleteAsset}}
#' }}
#' \item{Blog functions}{\itemize{
#'      \item \code{\link{getBlogs}}
#'      \item \code{\link{getBlogsCount}}
#'      \item \code{\link{getBlog}}
#'      \item \code{\link{createBlog}}
#'      \item \code{\link{modifyBlog}}
#'      \item \code{\link{deleteBlog}}
#' }}
#' \item{CarrierService functions}{\itemize{
#'      \item \code{\link{createCarrierService}}
#'      \item \code{\link{modifyCarrierService}}
#'      \item \code{\link{getCarrierServices}}
#'      \item \code{\link{getCarrierService}}
#'      \item \code{\link{deleteCarrierService}}
#' }}
#' \item{Checkout functions}{\itemize{
#'      \item \code{\link{getCheckoutsCount}}
#'      \item \code{\link{getCheckouts}}
#' }}
#' \item{Collect functions}{\itemize{
#'      \item \code{\link{createCollect}}
#'      \item \code{\link{deleteCollect}}
#'      \item \code{\link{getCollects}}
#'      \item \code{\link{getCollectsCount}}
#'      \item \code{\link{getCollect}}
#' }}
#' \item{Comment functions}{\itemize{
#'      \item \code{\link{getComments}}
#'      \item \code{\link{getCommentsCount}}
#'      \item \code{\link{getComment}}
#'      \item \code{\link{createComment}}
#'      \item \code{\link{modifyComment}}
#'      \item \code{\link{markCommentAsSpam}}
#'      \item \code{\link{markCommentAsNotSpam}}
#'      \item \code{\link{approveComment}}
#'      \item \code{\link{removeComment}}
#'      \item \code{\link{restoreComment}}
#' }}
#' \item{Country functions}{\itemize{
#'      \item \code{\link{getCountries}}
#'      \item \code{\link{getCountriesCount}}
#'      \item \code{\link{getCountry}}
#'      \item \code{\link{createCountry}}
#'      \item \code{\link{modifyCountry}}
#'      \item \code{\link{deleteCountry}}
#' }}
#' \item{CustomCollection functions}{\itemize{
#'      \item \code{\link{getCustomCollections}}
#'      \item \code{\link{getCustomCollectionsCount}}
#'      \item \code{\link{getCustomCollection}}
#'      \item \code{\link{createCustomCollection}}
#'      \item \code{\link{modifyCustomCollection}}
#'      \item \code{\link{deleteCustomCollection}}
#' }}
#' \item{Customer functions}{\itemize{
#'      \item \code{\link{getCustomers}}
#'      \item \code{\link{searchCustomers}}
#'      \item \code{\link{getCustomer}}
#'      \item \code{\link{createCustomer}}
#'      \item \code{\link{modifyCustomer}}
#'      \item \code{\link{deleteCustomer}}
#'      \item \code{\link{getCustomersCount}}
#'      \item \code{\link{getCustomerOrders}}
#' }}
#' \item{CustomerGroup & CustomerSavedSearch functions}{\itemize{
#'      \item \code{\link{getCustomerGroups}}
#'      \item \code{\link{getCustomerGroupsCount}}
#'      \item \code{\link{getCustomerGroup}}
#'      \item \code{\link{getCustomerGroupCustomers}}
#'      \item \code{\link{createCustomerGroup}}
#'      \item \code{\link{modifyCustomerGroup}}
#'      \item \code{\link{deleteCustomerGroup}}
#' }}
#' \item{Event functions}{\itemize{
#'      \item \code{\link{getEvents}}
#'      \item \code{\link{getEvent}}
#'      \item \code{\link{getEventsCount}}
#' }}
#' \item{Fulfillment functions}{\itemize{
#'      \item \code{\link{getFulfillments}}
#'      \item \code{\link{getFulfillmentsCount}}
#'      \item \code{\link{getFulfillment}}
#'      \item \code{\link{createFulfillment}}
#'      \item \code{\link{modifyFulfillment}}
#'      \item \code{\link{completeFulfillment}}
#'      \item \code{\link{cancelFulfillment}}
#' }}
#' \item{FulfillmentService functions}{\itemize{
#'      \item \code{\link{getFulfillmentServices}}
#'      \item \code{\link{createFulfillmentService}}
#'      \item \code{\link{getFulfillmentService}}
#'      \item \code{\link{modifyFulfillmentService}}
#'      \item \code{\link{deleteFulfillmentService}}
#' }}
#' \item{Location functions}{\itemize{
#'      \item \code{\link{getLocations}}
#'      \item \code{\link{getLocation}}
#' }}
#' \item{Metafield functions}{\itemize{
#'      \item \code{\link{getMetafields}}
#'      \item \code{\link{getMetafieldsCount}}
#'      \item \code{\link{getMetafield}}
#'      \item \code{\link{createMetafield}}
#'      \item \code{\link{modifyMetafield}}
#'      \item \code{\link{deleteMetafield}}
#' }}
#' \item{Order functions}{\itemize{
#'      \item \code{\link{getOrders}}
#'      \item \code{\link{getOrder}}
#'      \item \code{\link{getOrdersCount}}
#'      \item \code{\link{closeOrder}}
#'      \item \code{\link{openOrder}}
#'      \item \code{\link{cancelOrder}}
#'      \item \code{\link{createOrder}}
#'      \item \code{\link{modifyOrder}}
#'      \item \code{\link{deleteOrder}}
#' }}
#' \item{Order Risks functions}{\itemize{
#'      \item \code{\link{createOrderRisk}}
#'      \item \code{\link{getOrderRisks}}
#'      \item \code{\link{getOrderRisk}}
#'      \item \code{\link{modifyOrderRisk}}
#'      \item \code{\link{deleteOrderRisk}}
#' }}
#' \item{Page functions}{\itemize{
#'      \item \code{\link{getPages}}
#'      \item \code{\link{getPagesCount}}
#'      \item \code{\link{getPage}}
#'      \item \code{\link{createPage}}
#'      \item \code{\link{modifyPage}}
#'      \item \code{\link{deletePage}}
#' }}
#' \item{Product functions}{\itemize{
#'      \item \code{\link{getProducts}}
#'      \item \code{\link{getProductsCount}}
#'      \item \code{\link{getProduct}}
#'      \item \code{\link{createProduct}}
#'      \item \code{\link{modifyProduct}}
#'      \item \code{\link{deleteProduct}}
#' }}
#' \item{Product Image functions}{\itemize{
#'      \item \code{\link{getProductImages}}
#'      \item \code{\link{getProductImagesCount}}
#'      \item \code{\link{getProductImage}}
#'      \item \code{\link{createProductImage}}
#'      \item \code{\link{modifyProductImage}}
#'      \item \code{\link{deleteProductImage}}
#' }}
#' \item{Product Variant functions}{\itemize{
#'      \item \code{\link{getProductVariants}}
#'      \item \code{\link{getProductVariantsCount}}
#'      \item \code{\link{getProductVariant}}
#'      \item \code{\link{createProductVariant}}
#'      \item \code{\link{modifyProductVariant}}
#'      \item \code{\link{deleteProductVariant}}
#' }}
#' \item{Province functions}{\itemize{
#'      \item \code{\link{getProvinces}}
#'      \item \code{\link{getProvincesCount}}
#'      \item \code{\link{getProvince}}
#'      \item \code{\link{modifyProvince}}
#' }}
#' \item{RecurringApplicationCharge functions}{\itemize{
#'      \item \code{\link{createRecurringCharge}}
#'      \item \code{\link{getRecurringCharge}}
#'      \item \code{\link{getRecurringCharges}}
#'      \item \code{\link{activateRecurringCharge}}
#'      \item \code{\link{cancelRecurringCharge}}
#' }}
#' \item{Redirect functions}{\itemize{
#'      \item \code{\link{getRedirects}}
#'      \item \code{\link{getRedirectsCount}}
#'      \item \code{\link{getRedirect}}
#'      \item \code{\link{createRedirect}}
#'      \item \code{\link{modifyRedirect}}
#'      \item \code{\link{deleteRedirect}}
#' }}
#' \item{Refund functions}{\itemize{
#'      \item \code{\link{getRefund}}
#' }}
#' \item{ScriptTag functions}{\itemize{
#'      \item \code{\link{getScriptTags}}
#'      \item \code{\link{getScriptTagsCount}}
#'      \item \code{\link{getScriptTag}}
#'      \item \code{\link{createScriptTag}}
#'      \item \code{\link{modifyScriptTag}}
#'      \item \code{\link{deleteScriptTag}}
#' }}
#' \item{Shop functions}{\itemize{
#'      \item \code{\link{getShop}}
#' }}
#' \item{SmartCollection functions}{\itemize{
#'      \item \code{\link{getSmartCollections}}
#'      \item \code{\link{getSmartCollectionsCount}}
#'      \item \code{\link{getSmartCollection}}
#'      \item \code{\link{createSmartCollection}}
#'      \item \code{\link{modifySmartCollection}}
#'      \item \code{\link{orderSmartCollection}}
#'      \item \code{\link{deleteSmartCollection}}
#' }}
#' \item{Theme functions}{\itemize{
#'      \item \code{\link{getThemes}}
#'      \item \code{\link{getTheme}}
#'      \item \code{\link{createTheme}}
#'      \item \code{\link{modifyTheme}}
#'      \item \code{\link{deleteTheme}}
#' }}
#' \item{Transaction functions}{\itemize{
#'      \item \code{\link{getTransactions}}
#'      \item \code{\link{getTransactionsCount}}
#'      \item \code{\link{getTransaction}}
#'      \item \code{\link{createTransaction}}
#' }}
#' \item{Webhook functions}{\itemize{
#'      \item \code{\link{getWebhooks}}
#'      \item \code{\link{getWebhooksCount}}
#'      \item \code{\link{getWebhook}}
#'      \item \code{\link{createWebhook}}
#'      \item \code{\link{modifyWebhook}}
#'      \item \code{\link{deleteWebhook}}
#' }}
#' }
#' 
#' @include private.R Announcement.R ApplicationCharge.R Article.R Asset.R Blog.R CarrierService.R Checkout.R Collect.R Comment.R Country.R CustomCollection.R Customer.R CustomerGroup.R Event.R Fulfillment.R FulfillmentService.R Location.R MetaField.R Order.R OrderRisks.R Page.R Product.R ProductImage.R ProductVariant.R Province.R RecurringApplicationCharge.R Redirect.R Refund.R ScriptTag.R Shop.R SmartCollection.R Theme.R Transaction.R Webhook.R
#' @import R6
#' @export
ShopifyShop <- R6Class("ShopifyShop",
    public = list(
        # Public fields
        shopURL = NULL,
        apiKey = NULL,
        password = NULL,
        sharedSecret = NULL,
        shopInfo = NULL,
        
        # Constructor
        initialize = .initialize,
        
        # API Announcements
        showAnnouncements = showAnnouncements,
        
        # ApplicationCharge functions
        createApplicationCharge = createApplicationCharge,
        getApplicationCharge = getApplicationCharge,
        getApplicationCharges = getApplicationCharges,
        activateApplicationCharge = activateApplicationCharge,
        
        # Article functions
        getArticles = getArticles,
        getArticlesCount = getArticlesCount,
        getArticle = getArticle,
        createArticle = createArticle,
        modifyArticle = modifyArticle,
        getArticleAuthors = getArticleAuthors,
        getArticleTags = getArticleTags,
        deleteArticle = deleteArticle,
        
        # Asset functions
        getAssets = getAssets,
        getAsset = getAsset,
        createAsset = createAsset,
        modifyAsset = modifyAsset,
        deleteAsset = deleteAsset,
        
        
        # Blog functions
        getBlogs = getBlogs,
        getBlogsCount = getBlogsCount,
        getBlog = getBlog,
        createBlog = createBlog,
        modifyBlog = modifyBlog,
        delteBlog = deleteBlog,
        
        # CarrierService functions
        createCarrierService = createCarrierService,
        modifyCarrierService = modifyCarrierService,
        getCarrierServices = getCarrierServices,
        getCarrierService = getCarrierService,
        deleteCarrierService = deleteCarrierService,
        
        # Checkout functions
        getCheckoutsCount = getCheckoutsCount,
        getCheckouts = getCheckouts,
        
        # Collect functions
        createCollect = createCollect,
        deleteCollect = deleteCollect,
        getCollects = getCollects,
        getCollectsCount = getCollectsCount,
        getCollect = getCollect,
        
        # Comment functions
        getComments = getComments,
        getCommentsCount = getCommentsCount,
        getComment = getComment,
        createComment = createComment,
        modifyComment = modifyComment,
        markCommentAsSpam = markCommentAsSpam,
        markCommentAsNotSpam = markCommentAsNotSpam,
        approveComment = approveComment,
        removeComment = removeComment,
        restoreComment = restoreComment,
        
        # Country functions
        getCountries = getCountries,
        getCountriesCount = getCountriesCount,
        getCountry = getCountry,
        createCountry = createCountry,
        modifyCountry = modifyCountry,
        deleteCountry = deleteCountry,
        
        # CustomCollection functions
        getCustomCollections = getCustomCollections,
        getCustomCollectionsCount = getCustomCollectionsCount,
        getCustomCollection = getCustomCollections,
        createCustomCollection = createCustomCollection,
        modifyCustomCollection = modifyCustomCollection,
        deleteCustomCollection = deleteCustomCollection,
        
        # Customer functions
        getCustomers = getCustomers,
        searchCustomers = searchCustomers,
        getCustomer = getCustomers,
        createCustomer = createCustomer,
        modifyCustomer = modifyCustomer,
        deleteCustomer = deleteCustomer,
        getCustomersCount = getCustomersCount,
        getCustomerOrders = getCustomerOrders,
        
        # CustomerGroup / CustomerSavedSearch functions
        getCustomerGroups = getCustomerGroups,
        getCustomerGroupsCount = getCustomerGroupsCount,
        getCustomerGroup = getCustomerGroup,
        getCustomerGroupCustomers = getCustomerGroupCustomers,
        createCustomerGroup = createCustomerGroup,
        modifyCustomerGroup = modifyCustomerGroup,
        deleteCustomerGroup = deleteCustomerGroup,
        
        # Event functions
        getEvents = getEvents,
        getEvent = getEvent,
        getEventsCount = getEventsCount,
        
        # Fulfillment functions
        getFulfillments = getFulfillments,
        getFulfillmentsCount = getFulfillmentsCount,
        getFulfillment = getFulfillment,
        createFulfillment = createFulfillment,
        modifyFulfillment = modifyFulfillment,
        completeFulfillment = completeFulfillment,
        cancelFulfillment = cancelFulfillment,
        
        # FulfillmentService functions
        getFulfillmentServices = getFulfillmentServices,
        createFulfillmentService = createFulfillmentService,
        getFulfillmentService = getFulfillmentService,
        modifyFulfillmentService = modifyFulfillmentService,
        deleteFulfillmentService = deleteFulfillmentService,
        
        # Location functions
        getLocations = getLocations,
        getLocation = getLocation,
        
        # Metafield functions
        getMetafields = getMetafields,
        getMetafieldsCount = getMetafieldsCount,
        getMetafield = getMetafield,
        createMetafield = createMetafield,
        modifyMetafield = modifyMetafield,
        deleteMetafield = deleteMetafield,
        
        # Order functions
        getOrders = getOrders,
        getOrder = getOrder,
        getOrdersCount = getOrdersCount,
        closeOrder = closeOrder,
        openOrder = openOrder,
        cancelOrder = cancelOrder,
        createOrder = createOrder,
        modifyOrder = modifyOrder,
        deleteOrder = deleteOrder,
        
        # Order Risks functions
        createOrderRisk = createOrderRisk,
        getOrderRisks = getOrderRisks,
        getOrderRisk = getOrderRisk,
        modifyOrderRisk = modifyOrderRisk,
        deleteOrderRisk = deleteOrderRisk,
        
        # Page functions
        getPages = getPages,
        getPagesCount = getPagesCount,
        getPage = getPage,
        createPage = createPage,
        modifyPage = modifyPage,
        deletePage = deletePage,
        
        # Product functions
        getProducts = getProducts,
        getProductsCount = getProductsCount,
        getProduct = getProduct,
        createProduct = createProduct,
        modifyProduct = modifyProduct,
        deleteProduct = deleteProduct,
        
        # Product Image functions
        getProductImages = getProductImages,
        getProductImagesCount = getProductImagesCount,
        getProductImage = getProductImage,
        createProductImage = createProductImage,
        modifyProductImage = modifyProductImage,
        deleteProductImage = deleteProductImage,
        
        # Product Variant functions
        getProductVariants = getProductVariants,
        getProductVariantsCount = getProductVariantsCount,
        getProductVariant = getProductVariant,
        createProductVariant = createProductVariant,
        modifyProductVariant = modifyProductVariant,
        deleteProductVariant = deleteProductVariant,
        
        # Province functions
        getProvinces = getProvinces,
        getProvincesCount = getProvincesCount,
        getProvince = getProvince,
        modifyProvince = modifyProvince,
        
        # RecurringApplicationCharge functions
        createRecurringCharge = createRecurringCharge,
        getRecurringCharge = getRecurringCharge,
        getRecurringCharges = getRecurringCharges,
        activateRecurringCharge = activateRecurringCharge,
        cancelRecurringCharge = cancelRecurringCharge,
        
        # Redirect functions
        getRedirects = getRedirects,
        getRedirectsCount = getRedirectsCount,
        getRedirect = getRedirect,
        createRedirect = createRedirect,
        modifyRedirect = modifyRedirect,
        deleteRedirect = deleteRedirect,
        
        # Refund functions
        getRefund = getRefund,
        
        # ScriptTag functions
        getScriptTags = getScriptTags,
        getScriptTagsCount = getScriptTagsCount,
        getScriptTag = getScriptTag,
        createScriptTag = createScriptTag,
        modifyScriptTag = modifyScriptTag,
        deleteScriptTag = deleteScriptTag,
        
        # Shop functions
        getShop = getShop,
        
        # SmartCollection functions
        getSmartCollections = getSmartCollections,
        getSmartCollectionsCount = getSmartCollectionsCount,
        getSmartCollection = getSmartCollection,
        createSmartCollection = createSmartCollection,
        modifySmartCollection = modifySmartCollection,
        orderSmartCollection = orderSmartCollection,
        deleteSmartCollection = deleteSmartCollection,
        
        # Theme functions
        getThemes = getThemes,
        getTheme = getTheme,
        createTheme = createTheme,
        modifyTheme = modifyTheme,
        deleteTheme = deleteTheme,
        
        # Transaction functions
        getTransactions = getTransactions,
        getTransactionsCount = getTransactionsCount,
        getTransaction = getTransaction,
        createTransaction = createTransaction,
        
        # Webhook functions
        getWebhooks = getWebhooks,
        getWebhooksCount = getWebhooksCount,
        getWebhook = getWebhook,
        createWebhook = createWebhook,
        modifyWebhook = modifyWebhook,
        deleteWebhook = deleteWebhook
    ),
    
    private = list(
        # private fields
        .curlHandle = NULL,
        .responseHeaders = NULL,
        .responseBody = NULL,
        
        # private methods
        .params = .params,
        .url = .url,
        .baseUrl = .baseUrl,
        .wrap = .wrap,
        .request = .request,
        .fetchAll = .fetchAll,
        
        .getResponseHeaders = .getResponseHeaders,
        .updateResponseHeaders = .updateResponseHeaders,
        .clearResponseHeaders = .clearResponseHeaders,
        .parseResponseHeader = .parseResponseHeader,
        .getHeaderStatus = .getHeaderStatus,
        
        .getResponseBody = .getResponseBody,
        .updateResponseBody = .updateResponseBody,
        .clearResponseBody = .clearResponseBody,
        .parseResponseBody = .parseResponseBody,
        
        .parseShopifyTimestamp = .parseShopifyTimestamp
    )
)

#' @export
print.ShopifyShop <- function(x, ...) {
    cat("--",x$shopInfo$name,"Shopify API Client --\n")
    cat("Site Domain: ", x$shopInfo$domain, "\n")
    cat("Shopify Domain: ", x$shopInfo$myshopify_domain, "\n")
    cat("API Key: ", x$apiKey, "\n")
}