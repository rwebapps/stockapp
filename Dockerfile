FROM opencpu/base

RUN \
  add-apt-repository -y ppa:marutter/rrutter && \
  apt-get update && \
  apt-get install r-cran-ggplot2

RUN R -e 'devtools::install_github("rwebapps/stockapp")'
