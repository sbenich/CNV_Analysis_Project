# Install package from CRAN only if not installed, and load the library
library(testthat)
library(devtools)

#setwd("/Users/sidneybenich/Documents/cnv_analysis_project_package/CNVGeneReport")

# Source the gene report file
source("./R/Gene_report.R")

test_that("Top_n Rows are filtered",{
  #input_path <- "/Users/sidneybenich/Documents/CNV Analysis Project/Test/test_top_n"
  n = 3
  test_amp_table <- gene_report_amplification(input_path, n)
  amp_table_nrow = nrow(test_amp_table)

  test_del_table <- gene_report_deletion(input_path, n)
  del_table_nrow = nrow(test_del_table)

  expect_equal(nrow(test_amp_table), n)
  expect_equal(nrow(test_del_table), n)
})

test_that("Top_n Rows is greater than 1",{
  #input_path <- "/Users/sidneybenich/Documents/CNV Analysis Project/Test/test_top_n"
  n = 0
  expect_error(gene_report_amplification(input_path, n))
  expect_error(gene_report_deletion(input_path, n))
})

test_that("Top_n Rows is an integer",{
  #input_path <- "/Users/sidneybenich/Documents/CNV Analysis Project/Test/test_top_n"
  n = "one"
  expect_error(gene_report_amplification(input_path, n))
  expect_error(gene_report_deletion(input_path, n))
})

test_that("Top_n higher than amp/del Table Output",{
  #input_path <- "/Users/sidneybenich/Documents/CNV Analysis Project/Test/test_top_n"
  n = 1000000
  expect_warning(gene_report_amplification(input_path, n))
  expect_warning(gene_report_deletion(input_path, n))
})

test_that("Test for tsv file",{
  #input_path <- "/Users/sidneybenich/Documents/CNV Analysis Project/Test/test_tsv"
  n = 5
  expect_error(gene_report_amplification(input_path, n))
  expect_error(gene_report_deletion(input_path, n))
})

test_that("Test for missing gene_name rows",{
  #input_path <- "/Users/sidneybenich/Documents/CNV Analysis Project/Test/test_missing_gene"
  n = 2
  expect_error(gene_report_amplification(input_path, n))
  expect_error(gene_report_deletion(input_path, n))
})

test_that("get_x confirm that input is data.frame",{
  patient_file = "dummy_variable"
  expect_error(get_amplification(patient_file))
  expect_error(get_deletion(patient_file))
})
