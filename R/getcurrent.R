#' Get current value
#' 
#' Returns a row with the latest price for a given stock.
#' NOTE: see \url{http://www.networkerror.org/component/content/article/1-technical-wootness/44-googles-undocumented-finance-api.html}
#' for API details.
#' 
#' @param ticker stock ticker symbol. E.g. "GOOG".
#' @export
getcurrent <- function(ticker="GOOG"){
  endpoint <- sprintf('/stock/%s/quote', ticker)
  iex_get(endpoint)
}
