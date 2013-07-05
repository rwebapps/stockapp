smoothplot <- function(ticker, from, to=Sys.time()){
  mydata <- yahoodata(ticker, from, to);
  print(qplot(Date, Close, data = mydata, geom = c("line", "smooth"), main = ticker));  
}
