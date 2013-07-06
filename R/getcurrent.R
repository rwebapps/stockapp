#' Get current value
#' 
#' Returns a row with the latest price for a given stock.
#' 
#' @param ticker stock ticker symbol. E.g. "GOOG".
#' @export
getcurrent <- function(ticker="GOOG"){
    url <- paste('http://download.finance.yahoo.com/d/quotes.csv?s=',ticker,'&f=sl1d1t1n&e=.csv',sep="");
    mydata <- read.csv(url,header=FALSE);
    names(mydata) <- c("Symbol","Value","Date","Time","Name");
    return(mydata);
}