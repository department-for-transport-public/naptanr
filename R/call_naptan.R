#' Call the NaPTAN API for all, or for specified ATCO codes. Returns a data frame of Naptan data.
#'  
#' @name call_naptan
#' @export
#' 
#' @param atco string or vector of strings. 
#' First three digits of ATCO area codes of interest. 
#' If provided, will return data for only these ATCO areas. Defaults to NULL.
#' 
#' To return a lookup of current valid ATCO codes, use the lookup_atco_codes() function.
#' 
#' @importFrom httr GET 
#' @importFrom httr content 
#' @importFrom httr http_status
#' @importFrom data.table fread
#' 
#' @return Returns a data frame of NaPTAN data containing transport access node information. 
#' See \href{https://www.gov.uk/government/publications/national-public-transport-access-node-schema}{NaPTAN data set guidance} for more information.
#' 
#' @examples 
#' 
#' \dontrun{
#' #Return data for all ATCO areas 
#' call_naptan()
#' 
#' #Return data for a single ATCO area
#' call_naptan(atco = "050")
#' 
#' #Return data for multiple atco codes
#' call_naptan(atco = c("050", "290")) 
#' 
#' }

call_naptan <- function(atco = NULL){
  
  ##Check that all given ATCO codes are valid
  if(!is.null(atco)){
    if(!all(atco %in% get_atco_codes())){
      stop(paste("The following ATCO area codes do not exist:",
    paste(atco[!atco %in% get_atco_codes()], collapse = " "),
    "To display all valid atco codes, run lookup_atco_codes()"))
    }
  }
  
  if(length(atco > 1)){
    atco <- paste(atco,
          collapse = "%2C")
  }
  
  ##Create url code which includes atco code if required
  if(!is.null(atco)){
     url <- paste0("https://naptan.api.dft.gov.uk/v1/access-nodes?dataFormat=csv",
               "&atcoAreaCodes=", 
               atco)
  }else{
    url <- "https://naptan.api.dft.gov.uk/v1/access-nodes?dataFormat=csv"
     }

  
  #Pull in data from url
  download <- httr::GET(url)
  
  ##Return err message if one or more atco codes are invalid
  if(http_status(download)$category != "Success"){
    stop("An atco area code provided does not exist. Please check your query.
    To display all valid atco codes, run lookup_atco_codes()")
  } 
  
  data <- data.table::fread(content(download, as = "text", encoding = "UTF-8"))
  
  return(data)
}


#' Call the Naptan API for a partial or full region name. Returns a data frame of Naptan data.
#'  
#' @name call_naptan_region
#' @export
#' 
#' @param region_string string of partial or complete region name. 
#' Function uses regex to search for provided string in the names of the regions in Naptan. 
#' 
#' To see a data frame of current valid atco codes and region names, use the lookup_atco_codes() function.
#' 
#' @return Returns a data frame of NaPTAN data containing transport access node information. 
#' See \href{https://www.gov.uk/government/publications/national-public-transport-access-node-schema/naptan-and-nptg-data-sets-and-schema-guides}{NaPTAN data set guidance} for more information.
#' 
#' @examples 
#' 
#' #Return data for west yorkshire only 
#' call_naptan_region("west yorkshire")
#' 
#' #Return data for all yorkshire regions
#' call_naptan_region("yorkshire")
#' 
#' 
call_naptan_region <- function(region_string){
  
  suppressWarnings({
  ##Create vectors of codes, and also codes plus region names
  codes <- lookup_atco_codes(region_string)$AtcoAreaCode
  
  code_message <- paste(lookup_atco_codes(region_string)$AtcoAreaCode,
                         lookup_atco_codes(region_string)$AreaName)
  })
  
  if(length(codes) == 0){
    stop(paste("No ATCO codes found for the specified region string:", region_string))
  } 
  
  message(paste("Returning data for area codes:", paste(code_message, collapse = ", ")))
  
  return(call_naptan(atco = codes))
  
}