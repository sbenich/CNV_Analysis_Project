# Install package from CRAN only if not installed, and load the library
if (!require(testthat)) install.packages('testthat')
library(testthat)

# Import the gene report file