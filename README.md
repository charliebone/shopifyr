# shopifyr

[![Build Status](https://travis-ci.org/charliebone/shopifyr.png)](https://travis-ci.org/charliebone/shopifyr)
[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/shopifyr)](https://cran.r-project.org/package=shopifyr)

**shopifyr** aims to provide an easy-to-use interface to the [Shopify Admin API](https://help.shopify.com/en/api/reference) within R. 

## Getting Started

To get started, install the latest version of **shopifyr** from CRAN:

```R
install.packages("shopifyr")
```

Alternatively, you may install the latest development version of the **shopfiyr** package with the following code (requires the [`remotes`](https://github.com/r-lib/remotes) package):

```R
remotes:::install_github("charliebone/shopifyr")
```

Please note that the **shopifyr** package depends on the [`curl`](https://github.com/jeroen/curl), [`jsonlite`](https://github.com/jeroen/jsonlite) and [`R6`](https://github.com/wch/R6) packages. They will need to be installed in order to install **shopifyr**.

In addition, you may query the [Shopify GraphQL Admin API](https://help.shopify.com/en/api/graphql-admin-api) using this package.

After installation is complete, read the notes below. In order to take full advantage of this package, it is highly recommended that you become familiar with the features of the [Shopify Admin API](https://help.shopify.com/en/api/getting-started). 

## Using the ShopifyShop Class
The workhorse of the **shopifyr** package is the **ShopifyShop** class. It is written using the [R6 class implementation](https://github.com/wch/R6), which is a lightweight implementation of R's reference class. 

The **ShopifyShop** class encapsulates all the API functionality into a single object, allowing simple and expressive access to the Shopify API. To get started, you first must create a **ShopifyShop** object:

```R
library(shopifyr)
shopUrl <- "shopname.myshopify.com"
password <- "your_private_app_password"
shop <- ShopifyShop$new(shopUrl, password)

# view shop information
shop$shopInfo       # displays cached shop information
shop$getShop()      # fetches current shop information from server
```

All the data sent to and from Shopify is structured as a list in R. The **ShopifyShop** member functions will encode that list data as JSON prior to sending it to the Shopify server. 

For example, it's fairly straightforward to create a new product for your store:

```R
product <- list(title="The R Inferno",
                body_html="<b>The R Inferno</b> <i>by Patrick Burns</i>",
                vendor="Burns Statistics",
                product_type="Paperback",
                images=list(list(src="http://www.burns-stat.com/wp-content/
                                      uploads/2012/12/R_inferno_cover.jpg")))
newProduct <- shop$createProduct(product)
```

Each JSON object or array is structured as a list. Note how the images element of the product in the code snippet above is a list (array) containing one or more lists (objects representing each image).  

The returned object `newProduct` is the response from Shopify after the successful product addition. It will contain additional fields beyond those in the `product` object sent to Shopify, including the Shopify-assigned product _id_. 

Given the product _id_, adding a metafield to the new product is relatively straightforward:

```R
metafield <- list(namespace="books",
                  key="author",
                  value="Patrick Burns",
                  value_type="string")
newMetafield <- shop$createMetafield("products", resourceId=newProduct$id, metafield=metafield)
```

Once again, the returned `newMetafield` object will have additional fields populated by Shopify.

You can also add the new product to an existing collection:

```R
# get all custom collections and find the collection named "Books"
collections <- shop$getCustomCollections()
books <- Find(function(x) { x$title == "Books" }, collections)

# create a new Collect linking the new product with the desired collection
newCollect <- shop$createCollect(list(product_id=newProduct$id, collection_id=books$id))
```

In addition to manipulating products and collections, the Shopify API provides a multitude of other functionality. Here is an example of how to search for customers named Bob from the United States:

```R
bobs <- shop$searchCustomers("Bob country:United States")
```

To execute a query on the [Shopify GraphQL Admin API](https://help.shopify.com/en/api/graphql-admin-api) as described here. For example, to query for all books with 'Inferno' in the title, you could do the following:

```R
query <- '
{
  products(first:5, query:"title=Inferno"){
    edges{
      node{
        id
      }
    }
  }
}'

infernoBooks <- shop$graphQlQuery(query)
```

For a complete list of functions and their corresponding documentation, see the `?ShopifyShop` help page. You may get to a function's documentation directly just by invoking the help with that function's name, e.g. `?searchCustomers`.

## Obtaining API credentials
The **ShopifyShop** class requires an authorized access token or private application password to access the Shopify API. The easiest way to obtain this is to create and authorize a private app for your Shopify store. You can find instructions for this process on [Shopify's website](https://help.shopify.com/en/api/getting-started/authentication/private-authentication). 

**shopifyr** currently does not implement OAuth authentication, however you may use a permanent access token obtained via an OAuth authentication as the password when initializing a **ShopifyShop** object.