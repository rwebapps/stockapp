FROM opencpu/base

RUN \
  add-apt-repository -y ppa:marutter/c2d4u && \
  apt-get update && \
  apt-get install -y r-cran-ggplot2

RUN R -e 'devtools::install_github("rwebapps/stockapp")'
