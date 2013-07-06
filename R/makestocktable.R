#' Generate stock table.
#' 
#' This function pulls some data from finviz.com and creates a table with stocks.
#' Because this can be a bit slow and the result rarely changes, a fixed table with stocks called 'stocktable' is shipped with the package.
#' 
#' Also the site returns a lot of stocks. By setting the 'max' parameter, only stocks with the highest market capital are returned.
#' 
#' @param max Max number of stocks to return 
#' @return dataframe 'stocktable'
#' @examples stocktable <- makestocktable(); 
#' @export
makestocktable <- function(max=1000){
	mylist <- read.csv("http://finviz.com/export.ashx?v=111&&o=ticker", stringsAsFactors=FALSE);
	mylist <- mylist[head(order(mylist$Market.Cap, decreasing=TRUE), max),]
	mylist[c("Ticker", "Company", "Sector", "Industry", "Country")];
}
