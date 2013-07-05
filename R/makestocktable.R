makestocktable <- function(max=1000){
	mylist <- read.csv("http://finviz.com/export.ashx?v=111&&o=ticker", stringsAsFactors=FALSE);
	mylist <- mylist[head(order(mylist$Market.Cap, decreasing=TRUE), max),]
	mylist[c("Ticker", "Company", "Sector", "Industry", "Country")];
}

#stocktable <- makestocktable();

liststocks <- function(group=c("Industry", "Sector", "Country", "Name")){
	group <- match.arg(group);
  stocktable$Name <- substring(stocktable$Company, 1, 1)
  stocklist <- split(stocktable, stocktable[[group]]);
  outlist <- list();
  for(i in seq_along(stocklist)){
    outlist[[i]] <- list(
      text = names(stocklist[i]),
      children = makeleafs(stocklist[[i]])
    );    
  }
	list(
    text = ".",
    children = outlist
  )
}