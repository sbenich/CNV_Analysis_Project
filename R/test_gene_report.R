# Install package from CRAN only if not installed, and load the library
library(testthat)
library(devtools)

setwd("/Users/sidneybenich/Documents/cnv_analysis_project_package/CNVGeneReport")

# Source the gene report file
source("./R/Gene_report.R")

test_that("Top_n Rows are filtered",{
  input_path <- "/Users/sidneybenich/Documents/CNV Analysis Project/Test/test_top_n"
  n = 3
  test_amp_table <- gene_report_amplification(input_path, n)
  amp_table_nrow = nrow(test_amp_table)

  expect_equal(nrow(test_amp_table), n)
})

