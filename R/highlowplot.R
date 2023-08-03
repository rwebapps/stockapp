#' High/Low Plot
#' 
#' Creates a high/low plot of stock data.
#' 
#' @param ticker stock ticker symbol. E.g. "GOOG". 
#' @param from start date. Either string or date object.
#' @param to end date. Either string or date object.
#' @return ggplot object.
#' @export
highlowplot <- function(ticker = "GOOG", from = "2013-01-01", to=Sys.time()){
  mydata <- yahoodata(ticker, from, to);
  mydata$up <- mydata$open < mydata$close;
  ggplot(data=mydata, aes(date, close, ymin=low, ymax=high, color=up)) + geom_linerange() + theme(legend.position="none");
}
