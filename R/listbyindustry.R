#' @export
listbyindustry <- function(){
  return(menudata)
}
 
# We take some old db data (stocktable) and filter out stocks that still exist
update_menudata <- function(){
  exists <- TTR::stockSymbols()$Symbol
  stockdata <- subset(stocktable, Ticker %in% exists)
  newtable <- with(stockdata, data.frame(id=paste0("symbol_", Ticker), text=paste(Ticker, "-", Company), leaf=TRUE, Industry=Industry, Sector=Sector));
  mydata <- splitIntoTree(newtable, "Sector");
  mydata$children <- lapply(mydata$children, splitIntoTree, f="Industry", out=c("id", "text", "leaf"));
  menudata <- invisible(list("text"=".", children=mydata))
  save(menudata, file = 'data/menudata.rda')
}

splitIntoTree <- function(x, f, out){
  stopifnot(!missing(f))
  mydata <- split(x, x[f], drop=TRUE);
  if(!missing(out)){
    mydata <- lapply(mydata, "[", out)
  }
  structure(list(names(mydata), unname(mydata)), class="data.frame", names=c("text", "children"), row.names=as.character(seq_along(mydata)));
}
