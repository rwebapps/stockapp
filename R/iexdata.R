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
  tk <- rawToChar(jsonlite::base64_dec("cGtfNmU0NTJjNjRiNTNiNGNiOGEwYmY3ZDMyZjM4MTc3NTA="))
  url <- sprintf('https://cloud.iexapis.com/v1/stock/%s/chart/5y?token=%s', ticker, tk)
  mydata <- jsonlite::fromJSON(url)
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
