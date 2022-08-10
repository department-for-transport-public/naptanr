#' Return a vector of all permitted ATCO region codes in NaPTAN
#'  
#' @name get_atco_codes

get_atco_codes <- function(){
 
  sprintf("%03d", adminAreas$AtcoAreaCode)
}


#' Return a lookup table of all permitted ATCO codes and area names for a specified area string and/or country
#'  
#' @name lookup_atco_codes
#' @export
#' @param area_name string of partial or complete area name. Default is blank, which returns a full lookup table.
#' @param country string of country code ("ENG", "SCO", "WAL" or "GB"). Default is blank, which returns a full lookup table.
#' 
#' @return A data frame containing two columns, "AreaName" a character column containing names of geographic regions 
#' and AtcoAreaCode, a character column containing corresponding ATCO codes for these areas.
#' 
#' @examples 
#' #Return all ATCO codes
#' lookup_atco_codes()
#' 
#' #Return Yorkshire ATCO codes
#' lookup_atco_codes(area_name = "yorkshire")
#' 
#' #Return ATCO codes in Scotland
#' lookup_atco_codes(country = "SCO")
#' 

lookup_atco_codes <- function(area_name = "", country = ""){
  
  #Error out on weirdy country codes
  if(country != "" & !country %in% c("ENG", "SCO", "WAL", "GB")){
    stop(paste(country, 
               "is not a valid country code. Please select from valid country codes (ENG, SCO, WAL or GB)"))
  }
  
  #Filter on country
  data <- adminAreas[grepl(country, adminAreas$Country, ignore.case = TRUE),]
  
  #Filter on area name
  data <- data[grepl(area_name, data$AreaName, ignore.case = TRUE), 
                     c("AreaName", "AtcoAreaCode")]
  
  data$AtcoAreaCode <- sprintf("%03d", data$AtcoAreaCode)
  
  ##Warn if no data
  if(nrow(data) < 1){
    warning(paste("No results found for search string", area_name))
  }
  return(data)
}

