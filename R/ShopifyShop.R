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

########### ShopifyShop class definition ########### 
#' ShopifyShop class
#' 
#' The \code{ShopifyShop} class fully encapsulates the Shopify API. It is an \code{\link{R6}} class, and
#' as such is initialized via the \sQuote{new} function (see the example section for details). 
#' 
#' In order to access the Shopify Admin API, users will need a set of authorized API access credentials.
#' Tthese so-called \sQuote{private app} credentials can be created in the Shopify store
#' admin section. More information about how to do this can be found 
#' \href{http://docs.shopify.com/api/tutorials/creating-a-private-app}{here}. Once the credentials are
#' created, they remain valid and can be used in subsequent R sessions.
#' 
#' At the moment, the \code{ShopifyShop} class does not support OAuth authentication. It is possible that  
#' this may be implemented in the future. Note that users who possess a valid \sQuote{permanent access token} 
#' from a previous OAuth Authentication (see \href{http://docs.shopify.com/api/tutorials/oauth}{here}) may 
#' use it as the \code{password} field of the ShopifyShop class as the private app password is essentially 
#' analagous to the permanent token granted through successful OAuth authentication.
#' 
#' @param shopURL the URL of your shop, as in shopname.myshopify.com
#' @param password a Shopify API private app password or permanent access token (see Details)
#' @param storeFrontToken a Storefront API access token
#' @param quiet suppress output of API announcements
#' 
#' @usage NULL
#' @section ShopifyShop Class Generator Usage:
#' 
#' \describe{
#' \item{\code{ShopifyShop$new(shopURL, password, quiet = FALSE)}}{
#' if successful, will return a new \code{ShopifyShop} object.
#' }}
#' 
#' @section Public Fields:
#' \describe{
#' \item{\code{shopInfo}}{
#' information about the shop as returned by \code{\link{getShop}}
#' }}
#' 
#' @format NULL
#' 
#' @section Public Functions: 
#' \describe{
#' \item{\bold{ApplicationCharge} functions}{\itemize{
#'      \item \code{\link{createApplicationCharge}}
#'      \item \code{\link{getApplicationCharge}}
#'      \item \code{\link{getApplicationCharges}}
#'      \item \code{\link{activateApplicationCharge}}
#' }}
#' \item{\bold{Article} functions}{\itemize{
#'      \item \code{\link{getArticles}}
#'      \item \code{\link{getArticlesCount}}
#'      \item \code{\link{getArticle}}
#'      \item \code{\link{createArticle}}
#'      \item \code{\link{modifyArticle}}
#'      \item \code{\link{getArticleAuthors}}
#'      \item \code{\link{getArticleTags}}
#'      \item \code{\link{deleteArticle}}
#' }}
#' \item{\bold{Asset} functions}{\itemize{
#'      \item \code{\link{getAssets}}
#'      \item \code{\link{getAsset}}
#'      \item \code{\link{createAsset}}
#'      \item \code{\link{modifyAsset}}
#'      \item \code{\link{deleteAsset}}
#' }}
#' \item{\bold{Blog} functions}{\itemize{
#'      \item \code{\link{getBlogs}}
#'      \item \code{\link{getBlogsCount}}
#'      \item \code{\link{getBlog}}
#'      \item \code{\link{createBlog}}
#'      \item \code{\link{modifyBlog}}
#'      \item \code{\link{deleteBlog}}
#' }}
#' \item{\bold{CarrierService} functions}{\itemize{
#'      \item \code{\link{createCarrierService}}
#'      \item \code{\link{modifyCarrierService}}
#'      \item \code{\link{getCarrierServices}}
#'      \item \code{\link{getCarrierService}}
#'      \item \code{\link{deleteCarrierService}}
#' }}
#' \item{\bold{Checkout} functions}{\itemize{
#'      \item \code{\link{getCheckoutsCount}}
#'      \item \code{\link{getCheckouts}}
#' }}
#' \item{\bold{Collect} functions}{\itemize{
#'      \item \code{\link{createCollect}}
#'      \item \code{\link{deleteCollect}}
#'      \item \code{\link{getCollects}}
#'      \item \code{\link{getCollectsCount}}
#'      \item \code{\link{getCollect}}
#' }}
#' \item{\bold{Comment} functions}{\itemize{
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
#' \item{\bold{Country} functions}{\itemize{
#'      \item \code{\link{getCountries}}
#'      \item \code{\link{getCountriesCount}}
#'      \item \code{\link{getCountry}}
#'      \item \code{\link{createCountry}}
#'      \item \code{\link{modifyCountry}}
#'      \item \code{\link{deleteCountry}}
#' }}
#' \item{\bold{CustomCollection} functions}{\itemize{
#'      \item \code{\link{getCustomCollections}}
#'      \item \code{\link{getCustomCollectionsCount}}
#'      \item \code{\link{getCustomCollection}}
#'      \item \code{\link{createCustomCollection}}
#'      \item \code{\link{modifyCustomCollection}}
#'      \item \code{\link{deleteCustomCollection}}
#' }}
#' \item{\bold{Customer} functions}{\itemize{
#'      \item \code{\link{getCustomers}}
#'      \item \code{\link{searchCustomers}}
#'      \item \code{\link{getCustomer}}
#'      \item \code{\link{createCustomer}}
#'      \item \code{\link{modifyCustomer}}
#'      \item \code{\link{deleteCustomer}}
#'      \item \code{\link{getCustomersCount}}
#'      \item \code{\link{getCustomerOrders}}
#' }}
#' \item{\bold{CustomerSavedSearch} functions}{\itemize{
#'      \item \code{\link{getCustomerSavedSearches}}
#'      \item \code{\link{getCustomerSavedSearchesCount}}
#'      \item \code{\link{getCustomerSavedSearch}}
#'      \item \code{\link{getCustomerSavedSearchResults}}
#'      \item \code{\link{createCustomerSavedSearch}}
#'      \item \code{\link{modifyCustomerSavedSearch}}
#'      \item \code{\link{deleteCustomerSavedSearch}}
#' }}
#' \item{\bold{DiscountCode} functions}{\itemize{
#'      \item \code{\link{createDiscountCode}}
#'      \item \code{\link{modifyDiscountCode}}
#'      \item \code{\link{getDiscountCodes}}
#'      \item \code{\link{getDiscountCode}}
#'      \item \code{\link{deleteDiscountCode}}
#'      \item \code{\link{deleteDiscountCode}}
#'      \item \code{\link{createDiscountCodesCreationJob}}
#'      \item \code{\link{getDiscountCodesCreationJob}}
#'      \item \code{\link{getDiscountCodesFromCreationJob}}
#' }}
#' \item{\bold{DraftOrder} functions}{\itemize{
#'      \item \code{\link{createDraftOrder}}
#'      \item \code{\link{modifyDraftOrder}}
#'      \item \code{\link{getDraftOrders}}
#'      \item \code{\link{getDraftOrder}}
#'      \item \code{\link{getDraftOrdersCount}}
#'      \item \code{\link{sendDraftOrderInvoice}}
#'      \item \code{\link{deleteDraftOrder}}
#'      \item \code{\link{completeDraftOrder}}
#' }}
#' \item{\bold{Event} functions}{\itemize{
#'      \item \code{\link{getEvents}}
#'      \item \code{\link{getEvent}}
#'      \item \code{\link{getEventsCount}}
#' }}
#' \item{\bold{Fulfillment} functions}{\itemize{
#'      \item \code{\link{getFulfillments}}
#'      \item \code{\link{getFulfillmentsCount}}
#'      \item \code{\link{getFulfillment}}
#'      \item \code{\link{createFulfillment}}
#'      \item \code{\link{modifyFulfillment}}
#'      \item \code{\link{completeFulfillment}}
#'      \item \code{\link{cancelFulfillment}}
#' }}
#' \item{\bold{FulfillmentEvent} functions}{\itemize{
#'      \item \code{\link{getFulfillmentEvents}}
#'      \item \code{\link{getFulfillmentEvent}}
#'      \item \code{\link{createFulfillmentEvent}}
#'      \item \code{\link{deleteFulfillmentEvent}}
#' }}
#' \item{\bold{FulfillmentService} functions}{\itemize{
#'      \item \code{\link{getFulfillmentServices}}
#'      \item \code{\link{createFulfillmentService}}
#'      \item \code{\link{getFulfillmentService}}
#'      \item \code{\link{modifyFulfillmentService}}
#'      \item \code{\link{deleteFulfillmentService}}
#' }}
#' \item{\bold{GiftCard} functions}{\itemize{
#'      \item \code{\link{getGiftCards}}
#'      \item \code{\link{getGiftCard}}
#'      \item \code{\link{getGiftCardsCount}}
#'      \item \code{\link{createGiftCard}}
#'      \item \code{\link{modifyGiftCard}}
#'      \item \code{\link{disableGiftCard}}
#'      \item \code{\link{searchGiftCards}}
#' }}
#' \item{\bold{Location} functions}{\itemize{
#'      \item \code{\link{getLocations}}
#'      \item \code{\link{getLocation}}
#' }}
#' \item{\bold{MarketingEvent} functions}{\itemize{
#'      \item \code{\link{getMarketingEvents}}
#'      \item \code{\link{getMarketingEventsCount}}
#'      \item \code{\link{getMarketingEvent}}
#'      \item \code{\link{createMarketingEvent}}
#'      \item \code{\link{updateMarketingEvent}}
#'      \item \code{\link{deleteMarketingEvent}}
#'      \item \code{\link{createMarketingEventEngagements}}
#' }}
#' \item{\bold{Metafield} functions}{\itemize{
#'      \item \code{\link{getMetafields}}
#'      \item \code{\link{getMetafieldsCount}}
#'      \item \code{\link{getMetafield}}
#'      \item \code{\link{createMetafield}}
#'      \item \code{\link{modifyMetafield}}
#'      \item \code{\link{deleteMetafield}}
#' }}
#' \item{\bold{Order} functions}{\itemize{
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
#' \item{\bold{Order Risks} functions}{\itemize{
#'      \item \code{\link{createOrderRisk}}
#'      \item \code{\link{getOrderRisks}}
#'      \item \code{\link{getOrderRisk}}
#'      \item \code{\link{modifyOrderRisk}}
#'      \item \code{\link{deleteOrderRisk}}
#' }}
#' \item{\bold{Page} functions}{\itemize{
#'      \item \code{\link{getPages}}
#'      \item \code{\link{getPagesCount}}
#'      \item \code{\link{getPage}}
#'      \item \code{\link{createPage}}
#'      \item \code{\link{modifyPage}}
#'      \item \code{\link{deletePage}}
#' }}
#' \item{\bold{PriceRule} functions}{\itemize{
#'      \item \code{\link{getPriceRules}}
#'      \item \code{\link{getPriceRulesCount}}
#'      \item \code{\link{getPriceRule}}
#'      \item \code{\link{createPriceRule}}
#'      \item \code{\link{modifyPriceRule}}
#'      \item \code{\link{deletePriceRule}}
#' }}
#' \item{\bold{Policy} functions}{\itemize{
#'      \item \code{\link{getPolicies}}
#' }}
#' \item{\bold{Product} functions}{\itemize{
#'      \item \code{\link{getProducts}}
#'      \item \code{\link{getProductsCount}}
#'      \item \code{\link{getProduct}}
#'      \item \code{\link{createProduct}}
#'      \item \code{\link{modifyProduct}}
#'      \item \code{\link{deleteProduct}}
#' }}
#' \item{\bold{Product Image} functions}{\itemize{
#'      \item \code{\link{getProductImages}}
#'      \item \code{\link{getProductImagesCount}}
#'      \item \code{\link{getProductImage}}
#'      \item \code{\link{createProductImage}}
#'      \item \code{\link{modifyProductImage}}
#'      \item \code{\link{deleteProductImage}}
#' }}
#' \item{\bold{ProductListing} functions}{\itemize{
#'      \item \code{\link{getProductListings}}
#'      \item \code{\link{getProductListingProducts}}
#'      \item \code{\link{getProductListingsCount}}
#'      \item \code{\link{getProductListing}}
#'      \item \code{\link{createProductListing}}
#'      \item \code{\link{deleteProductListing}}
#' }}
#' \item{\bold{Product Variant} functions}{\itemize{
#'      \item \code{\link{getProductVariants}}
#'      \item \code{\link{getProductVariantsCount}}
#'      \item \code{\link{getProductVariant}}
#'      \item \code{\link{createProductVariant}}
#'      \item \code{\link{modifyProductVariant}}
#'      \item \code{\link{deleteProductVariant}}
#' }}
#' \item{\bold{Province} functions}{\itemize{
#'      \item \code{\link{getProvinces}}
#'      \item \code{\link{getProvincesCount}}
#'      \item \code{\link{getProvince}}
#'      \item \code{\link{modifyProvince}}
#' }}
#' \item{\bold{RecurringApplicationCharge} functions}{\itemize{
#'      \item \code{\link{createRecurringCharge}}
#'      \item \code{\link{getRecurringCharge}}
#'      \item \code{\link{getRecurringCharges}}
#'      \item \code{\link{activateRecurringCharge}}
#'      \item \code{\link{cancelRecurringCharge}}
#' }}
#' \item{\bold{Redirect} functions}{\itemize{
#'      \item \code{\link{getRedirects}}
#'      \item \code{\link{getRedirectsCount}}
#'      \item \code{\link{getRedirect}}
#'      \item \code{\link{createRedirect}}
#'      \item \code{\link{modifyRedirect}}
#'      \item \code{\link{deleteRedirect}}
#' }}
#' \item{\bold{Refund} functions}{\itemize{
#'      \item \code{\link{getRefund}}
#' }}
#' \item{\bold{Report} functions}{\itemize{
#'      \item \code{\link{getReports}}
#'      \item \code{\link{getReport}}
#'      \item \code{\link{createReport}}
#'      \item \code{\link{modifyReport}}
#'      \item \code{\link{deleteReport}}
#' }}
#' \item{\bold{ResourceFeedback} functions}{\itemize{
#'      \item \code{\link{createResourceFeedback}}
#'      \item \code{\link{getResourceFeedbacks}}
#' }}
#' \item{\bold{ScriptTag} functions}{\itemize{
#'      \item \code{\link{getScriptTags}}
#'      \item \code{\link{getScriptTagsCount}}
#'      \item \code{\link{getScriptTag}}
#'      \item \code{\link{createScriptTag}}
#'      \item \code{\link{modifyScriptTag}}
#'      \item \code{\link{deleteScriptTag}}
#' }}
#' \item{\bold{ShippingZone} functions}{\itemize{
#'      \item \code{\link{getShippingZones}}
#' }}
#' \item{\bold{Shop} functions}{\itemize{
#'      \item \code{\link{getShop}}
#' }}
#' \item{\bold{SmartCollection} functions}{\itemize{
#'      \item \code{\link{getSmartCollections}}
#'      \item \code{\link{getSmartCollectionsCount}}
#'      \item \code{\link{getSmartCollection}}
#'      \item \code{\link{createSmartCollection}}
#'      \item \code{\link{modifySmartCollection}}
#'      \item \code{\link{orderSmartCollection}}
#'      \item \code{\link{deleteSmartCollection}}
#' }}
#' \item{\bold{Theme} functions}{\itemize{
#'      \item \code{\link{getThemes}}
#'      \item \code{\link{getTheme}}
#'      \item \code{\link{createTheme}}
#'      \item \code{\link{modifyTheme}}
#'      \item \code{\link{deleteTheme}}
#' }}
#' \item{\bold{Transaction} functions}{\itemize{
#'      \item \code{\link{getTransactions}}
#'      \item \code{\link{getTransactionsCount}}
#'      \item \code{\link{getTransaction}}
#'      \item \code{\link{createTransaction}}
#' }}
#' \item{\bold{UsageCharge} functions}{\itemize{
#'      \item \code{\link{createUsageCharge}}
#'      \item \code{\link{getUsageCharge}}
#'      \item \code{\link{getUsageCharges}}
#' }}
#' \item{\bold{User} functions}{\itemize{
#'      \item \code{\link{getUsers}}
#'      \item \code{\link{getUser}}
#'      \item \code{\link{getCurrentUser}}
#' }}
#' \item{\bold{Webhook} functions}{\itemize{
#'      \item \code{\link{getWebhooks}}
#'      \item \code{\link{getWebhooksCount}}
#'      \item \code{\link{getWebhook}}
#'      \item \code{\link{createWebhook}}
#'      \item \code{\link{modifyWebhook}}
#'      \item \code{\link{deleteWebhook}}
#' }}
#' }
#' 
#' @examples
#' \dontrun{
#' # Before you can access the API, you must create a ShopifyShop object using your credentials
#' shop <- ShopifyShop$new("yourstore.myshopify.com","private_app_password")
#' 
#' # Get all smart collections
#' collections <- shop$getSmartCollections()
#' 
#' # Search for customers named Bob from the United States
#' bobs <- shop$searchCustomers("Bob country:United States")
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
#' @include private.R AbandonedCheckout.R AccessScope.R Announcement.R ApplicationCharge.R
#' @include ApplicationCredit.R Article.R Asset.R Blog.R CarrierService.R Checkout.R 
#' @include Collect.R CollectionListing.R Comment.R Country.R CustomCollection.R 
#' @include Customer.R CustomerAddress.R CustomerSavedSearch.R DraftOrder.R Event.R Fulfillment.R
#' @include FulfillmentEvent.R FulfillmentService.R GiftCard.R InventoryItem.R InventoryLevel.R Location.R 
#' @include MarketingEvent.R MetaField.R Order.R OrderRisks.R Page.R Policy.R PriceRule.R Product.R ProductImage.R 
#' @include ProductListing.R ProductVariant.R Province.R RecurringApplicationCharge.R Redirect.R Refund.R 
#' @include Report.R ResourceFeedback.R ScriptTag.R ShippingZone.R Shop.R SmartCollection.R Theme.R Transaction.R 
#' @include UsageCharge.R User.R Webhook.R 
#' @import R6
#' @export
ShopifyShop <- R6Class("ShopifyShop",
    portable = TRUE,
    public = list(
        # Public fields
        shopURL = NULL,
        password = NULL,
        storefrontToken = NULL,
        shopInfo = NULL,
        
        # Constructor
        initialize = .initialize,
        
        # print method
        print = print.ShopifyShop,
        
        # API Announcements
        showAnnouncements = showAnnouncements,
        
        # AbandonedCheckout functions
        getAbandonedCheckouts = getAbandonedCheckouts,
        getAbandonedCheckoutsCount = getAbandonedCheckoutsCount,
        
        # AccessScope functions
        getAccessScopes = getAccessScopes,
        
        # ApplicationCharge functions
        createApplicationCharge = createApplicationCharge,
        getApplicationCharge = getApplicationCharge,
        getApplicationCharges = getApplicationCharges,
        activateApplicationCharge = activateApplicationCharge,
        
        # ApplicationCredit functions
        createApplicationCredit = createApplicationCredit,
        getApplicationCredit = getApplicationCredit,
        getApplicationCredits = getApplicationCredits,
        
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
        deleteBlog = deleteBlog,
        
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
        getCustomCollection = getCustomCollection,
        createCustomCollection = createCustomCollection,
        modifyCustomCollection = modifyCustomCollection,
        deleteCustomCollection = deleteCustomCollection,
        
        # Customer functions
        getCustomers = getCustomers,
        searchCustomers = searchCustomers,
        getCustomer = getCustomer,
        createCustomer = createCustomer,
        modifyCustomer = modifyCustomer,
        deleteCustomer = deleteCustomer,
        getCustomersCount = getCustomersCount,
        getCustomerOrders = getCustomerOrders,
        
        # CustomerGroup / CustomerSavedSearch functions
        getCustomerSavedSearches = getCustomerSavedSearches,
        getCustomerSavedSearchesCount = getCustomerSavedSearchesCount,
        getCustomerSavedSearch = getCustomerSavedSearch,
        getCustomerSavedSearchResults = getCustomerSavedSearchResults,
        createCustomerSavedSearch = createCustomerSavedSearch,
        modifyCustomerSavedSearch = modifyCustomerSavedSearch,
        deleteCustomerSavedSearch = deleteCustomerSavedSearch,
        
        # DiscountCode functions
        createDiscountCode = createDiscountCode,
        modifyDiscountCode = modifyDiscountCode,
        getDiscountCodes = getDiscountCodes,
        getDiscountCode = getDiscountCode,
        getDiscountCodeLocation = getDiscountCodeLocation,
        deleteDiscountCode = deleteDiscountCode,
        createDiscountCodesCreationJob = createDiscountCodesCreationJob,
        getDiscountCodesCreationJob = getDiscountCodesCreationJob,
        getDiscountCodesFromCreationJob = getDiscountCodesFromCreationJob,
        
        # DraftOrder functions
        createDraftOrder = createDraftOrder,
        modifyDraftOrder = modifyDraftOrder,
        getDraftOrders = getDraftOrders,
        getDraftOrder = getDraftOrder,
        getDraftOrdersCount = getDraftOrdersCount,
        sendDraftOrderInvoice = sendDraftOrderInvoice,
        deleteDraftOrder = deleteDraftOrder,
        completeDraftOrder = completeDraftOrder,
        
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
        
        # FulfillmentEvent functions
        getFulfillmentEvents = getFulfillmentEvents,
        getFulfillmentEvent = getFulfillmentEvent,
        createFulfillmentEvent = createFulfillmentEvent,
        deleteFulfillmentEvent = deleteFulfillmentEvent,
        
        # FulfillmentService functions
        getFulfillmentServices = getFulfillmentServices,
        createFulfillmentService = createFulfillmentService,
        getFulfillmentService = getFulfillmentService,
        modifyFulfillmentService = modifyFulfillmentService,
        deleteFulfillmentService = deleteFulfillmentService,
        
        # GiftCard functions
        getGiftCards = getGiftCards,
        getGiftCard = getGiftCard,
        getGiftCardsCount = getGiftCardsCount,
        createGiftCard = createGiftCard,
        modifyGiftCard = modifyGiftCard,
        disableGiftCard = disableGiftCard,
        searchGiftCards = searchGiftCards,
        
        # GraphQL functions
        graphQlQuery = graphQlQuery,
        
        # InventoryItem functions
        getInventoryItems = getInventoryItems,
        getInventoryItem = getInventoryItem,
        modifyInventoryItem = modifyInventoryItem,
        
        # InventoryLevel functions
        getInventoryLevels = getInventoryLevels,
        modifyInventoryLevel = modifyInventoryLevel,
        deleteInventoryLevel = deleteInventoryLevel,
        connectInventoryItem = connectInventoryItem,
        setInventoryLevel = setInventoryLevel,
        
        # Location functions
        getLocations = getLocations,
        getLocation = getLocation,
        
        # MarketingEvent functions
        getMarketingEvents = getMarketingEvents,
        getMarketingEventsCount = getMarketingEventsCount,
        getMarketingEvent = getMarketingEvent,
        createMarketingEvent = createMarketingEvent,
        updateMarketingEvent = updateMarketingEvent,
        deleteMarketingEvent = deleteMarketingEvent,
        createMarketingEventEngagements = createMarketingEventEngagements,
        
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
        
        # Policy functions
        getPolicies = getPolicies,
        
        # PriceRule functions
        getPriceRules = getPriceRules,
        getPriceRulesCount = getPriceRulesCount,
        getPriceRule = getPriceRule,
        createPriceRule = createPriceRule,
        modifyPriceRule = modifyPriceRule,
        deletePriceRule = deletePriceRule,
        
        # Product functions
        getProducts = getProducts,
        getProductsCount = getProductsCount,
        getProduct = getProduct,
        createProduct = createProduct,
        modifyProduct = modifyProduct,
        deleteProduct = deleteProduct,
        
        # ProductImage functions
        getProductImages = getProductImages,
        getProductImagesCount = getProductImagesCount,
        getProductImage = getProductImage,
        createProductImage = createProductImage,
        modifyProductImage = modifyProductImage,
        deleteProductImage = deleteProductImage,
        
        # ProductListing functions
        getProductListings = getProductListings,
        getProductListingProducts = getProductListingProducts,
        getProductListingsCount = getProductListingsCount,
        getProductListing = getProductListing,
        createProductListing = createProductListing,
        deleteProductListing = deleteProductListing,
        
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
        
        # Report functions
        getReports = getReports,
        getReport = getReport,
        createReport = createReport,
        modifyReport = modifyReport,
        deleteReport = deleteReport,
        
        # ResourceFeedback functions
        createResourceFeedback = createResourceFeedback,
        getResourceFeedbacks = getResourceFeedbacks,
        
        # ScriptTag functions
        getScriptTags = getScriptTags,
        getScriptTagsCount = getScriptTagsCount,
        getScriptTag = getScriptTag,
        createScriptTag = createScriptTag,
        modifyScriptTag = modifyScriptTag,
        deleteScriptTag = deleteScriptTag,
        
        # ShippingZone functions
        getShippingZones = getShippingZones,
        
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
        
        # UsageCharge functions
        createUsageCharge = createUsageCharge,
        getUsageCharge = getUsageCharge,
        getUsageCharges = getUsageCharges,
        
        # User functions
        getUsers = getUsers,
        getUser = getUser,
        getCurrentUser = getCurrentUser,
        
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
        .lastReqTime = NULL,
        .rateLimitUsed = 0,
        .rateLimitTotal = 40,
        .costLimitUsed = 0,
        .costLimitTotal = 1000,
        .costLimitRestoreRate = 50,
        .apiVersion = "2019-04",
        
        # private methods
        .params = .params,
        .url = .url,
        .baseUrl = .baseUrl,
        .graphQlUrl = .graphQlUrl,
        .graphQlRequest = .graphQlRequest,
        .wrap = .wrap,
        .encode = .encode,
        .fetchAll = .fetchAll,
        .request = .request,
        .createHandle = .createHandle,
        .parseResponseBody = .parseResponseBody,
        .updateRateLimit = .updateRateLimit,
        .rateLimitOk = .rateLimitOk,
        .updateCostLimit = .updateCostLimit,
        .costLimitOk = .costLimitOk,
        .parseShopifyTimestamp = .parseShopifyTimestamp,
        .encodeImageFile =.encodeImageFile
    )
)

# list of supposedly 'global' names to appease R CMD check
.__global__ <- c("self","private")
