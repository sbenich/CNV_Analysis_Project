# Install package from CRAN only if not installed, and load the library
library(testthat)
library(devtools)

# IMPORTANT: set basepath to be R directory of github project, in both
# This script and in the console
# example: "/users/sbenich/CNV_Analysis_Project/R"
basepath = ""

if (basepath == ""){
  stop("basepath has not been defined. Please set basepath to be R directory of github project.")
}

# Source the gene report file
source(file.path(basepath, "Gene_report.R"))

test_that("Top_n Rows are filtered",{
  input_path <- file.path(basepath, "test_data/test_top_n")
  n = 3
  test_amp_table <- gene_report_amplification(input_path, n)
  amp_table_nrow = nrow(test_amp_table)

  test_del_table <- gene_report_deletion(input_path, n)
  del_table_nrow = nrow(test_del_table)

  expect_equal(nrow(test_amp_table), n)
  expect_equal(nrow(test_del_table), n)
})

test_that("Top_n Rows is greater than 1",{
  input_path <- file.path(basepath, "test_data/test_top_n")
  n = 0
  expect_error(gene_report_amplification(input_path, n))
  expect_error(gene_report_deletion(input_path, n))
})

test_that("Top_n Rows is an integer",{
  input_path <- file.path(basepath, "test_data/test_top_n")
  n = "one"
  expect_error(gene_report_amplification(input_path, n))
  expect_error(gene_report_deletion(input_path, n))
})

test_that("Top_n higher than amp/del Table Output",{
  input_path <- file.path(basepath, "test_data/test_top_n")
  n = 1000000
  expect_warning(gene_report_amplification(input_path, n))
  expect_warning(gene_report_deletion(input_path, n))
})

test_that("Test for tsv file",{
  input_path <- file.path(basepath, "test_data/test_tsv")
  n = 5
  expect_error(gene_report_amplification(input_path, n))
  expect_error(gene_report_deletion(input_path, n))
})

test_that("Test for missing gene_name rows",{
  input_path <- file.path(basepath, "test_data/test_missing_gene")
  n = 2
  expect_error(gene_report_amplification(input_path, n))
  expect_error(gene_report_deletion(input_path, n))
})

test_that("get_x confirm that input is data.frame",{
  patient_file = "dummy_variable"
  expect_error(get_amplification(patient_file))
  expect_error(get_deletion(patient_file))
})

test_that("Gene Reports are accurate",{
  input_path <- file.path(basepath, "test_data/test_accuracy")
  n = 5

  test_amp_table <- gene_report_amplification(input_path, n)
  test_del_table <- gene_report_deletion(input_path, n)

  print(test_amp_table)

  # Testing 5 files with below expected amplification and deletion values.
  # Also included copy_number of 2 for each gene. These should have no effect.
  expect_equal(test_amp_table[test_amp_table$gene_name == "OR4G11P",]$n, 2)
  expect_equal(test_amp_table[test_amp_table$gene_name == "AL627309.1",]$n, 2)
  expect_equal(test_amp_table[test_amp_table$gene_name == "AL627309.3",]$n, 2)
  expect_equal(test_amp_table[test_amp_table$gene_name == "CICP27",]$n, 2)
  expect_equal(test_amp_table[test_amp_table$gene_name == "OR4F5",]$n, 2)

  expect_equal(test_del_table[test_del_table$gene_name == "OR4G11P",]$n, 2)
  expect_equal(test_del_table[test_del_table$gene_name == "AL627309.1",]$n, 2)
  expect_equal(test_del_table[test_del_table$gene_name == "AL627309.3",]$n, 2)
  expect_equal(test_del_table[test_del_table$gene_name == "CICP27",]$n, 2)
  expect_equal(test_del_table[test_del_table$gene_name == "OR4F5",]$n, 1)
})
