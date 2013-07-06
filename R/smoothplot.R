#' Smooth Plot
#' 
#' Creates a smooth plot of stock data.
#' 
#' @param ticker stock ticker symbol. E.g. "GOOG".
#' @param from start date. Either string or date object.
#' @param to end date. Either string or date object.
#' @return ggplot object.
#' @export
smoothplot <- function(ticker = "GOOG", from = "2013-01-01", to=Sys.time()){
  mydata <- yahoodata(ticker, from, to);
  qplot(Date, Close, data = mydata, geom = c("line", "smooth"));  
}
