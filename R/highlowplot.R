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
  mydata <- googledata(ticker, from, to);
  mydata$up <- mydata$Open < mydata$Close;
  ggplot(data=mydata, aes(Date, Close, ymin=Low, ymax=High, color=up)) + geom_linerange() + theme(legend.position="none");
}
