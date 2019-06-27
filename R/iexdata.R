#' IEX data
#' 
#' Download historical prices for a given stock from \url{https://iextrading.com}
#' 
#' @param ticker stock ticker symbol. E.g. "GOOG".
#' @param from start date. Either string or date object.
#' @param to end date. Either string or date object.
#' @return dataframe with historical prices
#' @export
iexdata <- function(ticker, from = NULL, to = NULL){
  endpoint <- sprintf('/stock/%s/chart/5y', ticker)
  mydata <- iex_get(endpoint)
  if (!length(mydata) || !nrow(mydata)) 
    stop("Failed to get data for: ", ticker)
  mydata$date <- as.Date(strptime(mydata$date, '%Y-%m-%d'))
  
  # Filter by date
  if(length(from))
    mydata <- mydata[mydata$date > as.Date(from),]
  if(length(to))
    mydata <- mydata[mydata$date < as.Date(to),]
  
  return(mydata);
}

iex_get <- function(endpoint){
  tk <- rawToChar(jsonlite::base64_dec("cGtfNmU0NTJjNjRiNTNiNGNiOGEwYmY3ZDMyZjM4MTc3NTA="))
  urlz <- paste0('https://cloud.iexapis.com/v1', endpoint, "?token=", tk)
  jsonlite::parse_json(base::url(urlz), simplifyVector = TRUE)
}
