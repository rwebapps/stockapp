#' Yahoo data
#' 
#' Download historical prices for a given stock from Yahoo Finance.
#' 
#' @param ticker stock ticker symbol. E.g. "GOOG".
#' @param from start date. Either string or date object.
#' @param to end date. Either string or date object.
#' @return dataframe with historical prices
#' @export
yahoodata <- function(ticker, from, to){
  env <- new.env()
  quantmod::getSymbols(ticker, from = from, to = to)
  df <- as.data.frame(get(ticker, env))
  names(df) <- sub(".*\\.", "", tolower(names(df)))
  df$date <- as.Date(row.names(df))
  row.names(df) <- NULL
  df
}
