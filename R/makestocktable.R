#stocktable <- makestocktable();

makestocktable <- function(max=1000){
	mylist <- read.csv("http://finviz.com/export.ashx?v=111&&o=ticker", stringsAsFactors=FALSE);
	mylist <- mylist[head(order(mylist$Market.Cap, decreasing=TRUE), max),]
	mylist[c("Ticker", "Company", "Sector", "Industry", "Country")];
}
