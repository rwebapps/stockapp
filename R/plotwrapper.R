#' Plot Wrapper
#' 
#' This is a wrapper for the OpenCPU application. It is a single function that calls out to various plot types.
#' The function prints a plot to the graphics device and returns nothing.
#' 
#' @param type type of plot to create. One of "smoothplot", "highlowplot", "areaplot".
#' @param ticker stock ticker symbol. E.g. "GOOG".
#' @param from start date. Either string or date object.
#' @param to end date. Either string or date object.
#' @param current include the current price of this stock. TRUE/FALSE.
#' @import ggplot2
#' @export
plotwrapper <- function(type=c("smoothplot", "highlowplot", "areaplot"), ticker="GOOG", from="2013-01-01", to=Sys.time(), current=FALSE){
	type <- match.arg(type);
	myplot <- switch(type,
		smoothplot = smoothplot(ticker, from, to),
		highlowplot = highlowplot(ticker, from, to),
		areaplot = areaplot(ticker, from, to),
		stop("Unknown plot type:", type)
	);
	
	#remove axis label date
	myplot <- myplot + xlab("") + ylab(ticker);
	
	if(isTRUE(current)){
		current <- tryCatch(getcurrent(ticker), error = function(e){
		  utils::head(googledata(ticker), 1)
		})
		value <- current$Close
		myplot <- myplot + geom_hline(yintercept = value, colour = "red", linetype = 2, size = 0.8);	
		myplot <- myplot + geom_text(x = -Inf, y = value, label = paste("$", value), hjust = -1, vjust = -0.5, color="black");	
	}
	
	#make sure to print the plot
	print(myplot);
	
	#no need to return anything
	invisible();
}