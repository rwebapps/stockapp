update_stocktable <- function(){
  ticker_ok <- check_tickers(stocktable$Ticker)
  stocktable <- stocktable[ticker_ok,]
  save(stocktable, file = "data/stocktable.rda")
}

check_tickers <- function(tickers){
   vapply(tickers, function(symbol){
    out <- symbol_exists(symbol)
    cat(sprintf("%s: %s\n", symbol, ifelse(out, "OK", "DEAD")))
    Sys.sleep(1)
    gc()
    return(out)
  }, logical(1))
}

symbol_exists <- function(symbol){
  for(i in 1:2){
    try({
      googledata(symbol, "2015-01-01", as.character(Sys.Date()))
      return(TRUE)
    }, silent = TRUE)
  }
  return(FALSE)
}
