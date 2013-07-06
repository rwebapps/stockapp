highlowplot <- function(ticker = "GOOG", from = "2013-01-01", to=Sys.time()){
  mydata <- yahoodata(ticker, from, to);
  mydata$up <- mydata$Open < mydata$Close;
  ggplot(data=mydata, aes(Date, Close, ymin=Low, ymax=High, color=up)) + geom_linerange() + theme(legend.position="none");
}
