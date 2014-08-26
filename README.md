# shopifyr

[![Build Status](https://travis-ci.org/charliebone/shopifyr.png)](https://travis-ci.org/charliebone/shopifyr)

shopifyr aims to provide an easy-to-use interface to the [Shopify API](http://api.shopify.com/) within R. 

## Getting Started

You can install the shopfiyr package with the following code (requires the `devtools` package):

```R
devtools:::install_github("charliebone/shopifyr")
```

Please note that the **shopifyr** package depends on the [`RCurl`](http://cran.r-project.org/web/packages/RCurl/), [`RJSONIO`](http://cran.r-project.org/web/packages/RJSONIO/) and [`R6`](https://github.com/wch/R6) packages, and they will need to be installed in order to install **shopifyr**.

After installation is complete, read the notes below. In order to take full advantage of this package, it is highly recommended that you become familiar with the features of the [Shopify API](http://api.shopify.com/). 

## The ShopifyShop Class
The workhorse of the **shopifyr** package is the **ShopifyShop** class. It is written using the relatively new [R6 class implementation](https://github.com/wch/R6), which is a lightweight implementation of R's reference class. 

The **ShopifyShop** class is a simple way to encapsulate all the API functionality into a single object, allowing simple and expressive access to the Shopify API. To get started, you first must create a **Shopifyshop** object:

```R
library(shopifyr)
shopURL <- "shopname.myshopify.com"
password <- "your_private_app_password"
shop <- ShopifyShop$new(shopURL, password)

# view shop information
shop$shopInfo       # displays previously-fetched shop information
shop$getShop()      # fetches current shop information from server
```

All the data sent to and from Shopify is structured as a list in R. The **ShopifyShop** member functions will encode that list data as JSON prior to sending it to the Shopify server. Thus, it's fairly simple to create a new product in your store:

```R
product <- list(title="The R Inferno",
                body="<b>The R Inferno</b><i>by Patrick Burns</i>",
                vendor="Burns Statistics",
                product_type="Paperback",
                images=list(list(src="http://www.burns-stat.com/wp-content/
                                      uploads/2012/12/R_inferno_cover.jpg")))
newProduct <- shop$createProduct(product)
```

Adding a metafield to the new product is relatively straightforward:

```R
metafield <- list(namespace="books",
                  key="author",
                  value="Patrick Burns")
newMetafield <- shop$createMetafield("products", resourceId=newProduct$id, metafield=metafield)
```

You can also add the new product to an existing collection:
    
```R
# get all custom collections and find the collection named "Books"
collections <- shop$getCustomCollections()
books <- Find(function(x) { x$title == "Books" }, collections)

# create a new Collect linking the new product with the desired collection
newCollect <- shop$createCollect(list(product_id=newProduct$id, collection_id=books$id))

```

Here is an example of how to search for customers named Bob from the United States:

```R
bobs <- shop$searchCustomers("Bob country:United States")
```

For a complete list of functions and their corresponding documentation, see the `?ShopifyShop` help page. You may get to a function's documentation directly just by invoking the help with that function's name, e.g. `?searchCustomers`.

## Obtaining API credentials
The **ShopifyShop** class requires an authorized access token or private application password to access the Shopify API. The easiest way to obtain this is to create and authorize a private app for your Shopify store. You can find instructions for this process on [Shopify's website](http://docs.shopify.com/api/tutorials/creating-a-private-app). 

**shopifyr** currently does not implement OAuth authentication, however you may use a permanent access token obtained via an OAuth authentication as the password when initializing a **ShopifyShop** object.