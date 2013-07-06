\name{yahoodata}
\alias{yahoodata}
\title{Yahoo data}
\usage{
  yahoodata(ticker, from, to)
}
\arguments{
  \item{ticker}{stock ticker symbol. E.g. "GOOG".}

  \item{from}{start date. Either string or date object.}

  \item{to}{end date. Either string or date object.}
}
\value{
  dataframe with historical prices
}
\description{
  Download historical prices for a given stock from Yahoo
  Finance.
}

