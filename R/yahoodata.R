yahoodata <- function(ticker, from, to){
  from <- as.Date(from);
  to <- as.Date(to);
  
  args <- list(
    s = ticker,
    a = as.numeric(format(from, "%m"))-1,
    b = as.numeric(format(from, "%d")),
    c = as.numeric(format(from, "%Y")),
    d = as.numeric(format(to, "%m"))-1,
    e = as.numeric(format(to, "%d")),
    f = as.numeric(format(to, "%Y")),
    ignore = ".csv"
  );
  
  myurl <- paste("http://ichart.finance.yahoo.com/table.csv?", 
    paste(names(args), args, sep="=", collapse="&"), sep="");
    
  mydata <- tryCatch(read.csv(myurl), error=function(e){
  	stop("Failed to download data from Yahoo. Could be invalid stock.")
  });
  
  mydata$Date <- as.Date(mydata$Date);
  
  return(mydata);
}
