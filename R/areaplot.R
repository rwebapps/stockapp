#' Areaplot
#' 
#' Creates an area plot of stock data.
#' 
#' @param ticker stock ticker symbol. E.g. "GOOG". 
#' @param from start date. Either string or date object.
#' @param to end date. Either string or date object.
#' @return ggplot object.
#' @export
areaplot <- function(ticker = "GOOG", from = "2013-01-01", to=Sys.time()){
  mydata <- yahoodata(ticker, from, to);
  mydata$lowpoint <- min(mydata$Close);
  ggplot(data = mydata, ymin=lowpoint, aes(Date, ymin=lowpoint, ymax=Close)) + geom_ribbon(color="black", fill="goldenrod3", alpha=0.5) + ylim(range(mydata$Close));  
}
