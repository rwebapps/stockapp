#' Get current value
#' 
#' Returns a row with the latest price for a given stock.
#' NOTE: see \url{http://www.networkerror.org/component/content/article/1-technical-wootness/44-googles-undocumented-finance-api.html}
#' for API details.
#' 
#' @param ticker stock ticker symbol. E.g. "GOOG".
#' @export
getcurrent <- function(ticker="GOOG"){
    url <- sprintf('http://finance.google.com/finance/getprices?q=%s&i=60&p=2d&f=c,o,h,l,v&df=cpct&auto=0&ei=Ef6XUYDfCqSTiAKEMg', ticker);
    lines <- readLines(url)
    namecol <- grepl("^COLUMNS=", lines)
    colnames <- strsplit(sub("COLUMNS=", "", lines[namecol]), ",", fixed = TRUE)[[1]]
    current <- as.list(as.numeric(strsplit(utils::tail(lines, 1), ",", fixed = TRUE)[[1]]))
    names(current) <- tools::toTitleCase(tolower(colnames))
    return(current)
}
