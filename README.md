# naptanr

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![CRAN
status](https://www.r-pkg.org/badges/version/naptanr)](https://CRAN.R-project.org/package=naptanr)
[![R-CMD-check](https://github.com/department-for-transport-public/naptanr/workflows/R-CMD-check/badge.svg)](https://github.com/department-for-transport-public/naptanr/actions)
<!-- badges: end -->

The goal of naptanr is to allow easy interface between the National Public Transport Access Nodes (NaPTAN) API and R. The NaPTAN dataset provides the location and type of every location you can join or leave public transport in England, Scotland and Wales. Further details and documentation on the NaPTAN API can be found [here](https://www.api.gov.uk/dft/national-public-transport-access-nodes-naptan-api/#national-public-transport-access-nodes-naptan-api).

## Installation

You can install the development version of naptanr from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("department-for-transport-public/naptanr")
```

## Usage

naptanr has several functions designed to make it easy for you to interrogate the NaPTAN API and receive the results as an R dataframe object.

### Returning Naptan results from ATCO codes

The `call_naptan()` function allows you to request data for one or more ATCO area codes. 

Calling this function with no arguments returns a full data frame of all results currently stored in Naptan. 

You can also specify the area you would like to see results for by using the `atco` argument in this function. You can give a single three-digit ATCO code as a string, or multiple ATCO codes as a vector of strings, e.g. 

```{r example, eval=FALSE}
library(naptanr)

## Single ATCO code
call_naptanr(atco = "050")

## Multiple ATCO codes
call_naptanr(atco = c("050", "290"))
```

If you provide one or more invalid ATCO codes, the function will return an error and let you know which ATCO codes are incorrect.

### Returning NaPTAN results from region name

Functions are also available to help you if you don't know the ATCO code of the region(s) you're interested in. The `lookup_atco_codes()` function returns a lookup table of area names and ATCO Area Codes. Calling this function without arguments returns a full list of all available ATCO area codes.

If you'd like to filter this list down, the function offers several arguments to do this. You can use the `area_name` argument to specify the full or partial name of the area you're interested in, for example:

```{r atco_lookup, eval=FALSE}
library(naptanr)

## Returns area code for Cornwall only
lookup_atco_codes(area_name = "cornwall")

## Returns area code for all areas containing the partial string "west"
lookup_atco_codes(area_name = "west")

```

This search operates via regular expression and is not case sensitive.

You can also return the area codes for a single country using the `country` argument. Specify "ENG", "SCO" or "WAL" to return values for England, Scotland or Wales respectively.

```{r country_lookup, eval=FALSE}
library(naptanr)

## Returns area codes for all areas in Wales 
lookup_atco_codes(country = "WAL")

```

You can also use the same type of lookup to return NaPTAN data directly using the `call_naptan_region()` function. Passing a full or partial area name to the `region_string` argument returns results for all areas which match this lookup.

```{r region_call, eval=FALSE}
library(naptanr)

## Returns results for all areas containing the string "yorkshire"  
call_naptan_region(region_string = "yorkshire")

```
