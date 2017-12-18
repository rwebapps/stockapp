#' Google data
#' 
#' Download historical prices for a given stock from Google
#' 
#' @param ticker stock ticker symbol. E.g. "GOOG".
#' @param from start date. Either string or date object.
#' @param to end date. Either string or date object.
#' @return dataframe with historical prices
#' @export
googledata <- function(ticker, from = NULL, to = NULL){
  
  args <- list(
    q = ticker,
    output = "csv"
  )
  
  if(length(from))
    args$startdate = as.character(as.Date(from))
  if(length(to))
    args$enddate <- as.character(as.Date(to))
  
  myurl <- paste0("https://finance.google.com/finance/historical?",
    paste(names(args), args, sep="=", collapse="&"))
  
  tmp <- tempfile()
  on.exit(unlink(tmp))
  curl::curl_download(myurl, tmp)
  mydata <- read.csv(tmp, stringsAsFactors = FALSE, fileEncoding = "UTF-8-BOM")
  
  # Seems that google returns string like "22-Sep-16" at least on my machine
  mydata$Date <- as.Date(strptime(mydata$Date, "%d-%b-%y"))
  
  return(mydata);
}
