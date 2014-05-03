OpenCPU App: Stocks
-------------------

Simple OpenCPU Application. To install in R:

    library(devtools)
    install_github("opencpu", "jeroenooms")
    install_github("stocks", "opencpu")

    #load the app
    library(opencpu)
    opencpu$browse("library/stocks/www")

Use the same function locally:

    library(stocks)
    smoothplot()
    highlowplot()
    areaplot()

    ?smoothplot
    ?plotwrapper

For more information about OpenCPU apps, see [opencpu.js](https://github.com/jeroenooms/opencpu.js#readme)

