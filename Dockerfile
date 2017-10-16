FROM opencpu/base

RUN \
  add-apt-repository -y ppa:marutter/c2d4u && \
  apt-get update && \
  apt-get install -y r-cran-ggplot2

RUN R -e 'devtools::install_github("rwebapps/stockapp")'

RUN \
  echo 'Redirect /index.html /ocpu/library/stocks/www' > /etc/apache2/sites-enabled/app.conf
