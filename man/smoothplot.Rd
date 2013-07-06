\name{smoothplot}
\alias{smoothplot}
\title{Smooth Plot}
\usage{
  smoothplot(ticker = "GOOG", from = "2013-01-01",
    to = Sys.time())
}
\arguments{
  \item{ticker}{stock ticker symbol. E.g. "GOOG".}

  \item{from}{start date. Either string or date object.}

  \item{to}{end date. Either string or date object.}
}
\value{
  ggplot object.
}
\description{
  Creates a smooth plot of stock data.
}

