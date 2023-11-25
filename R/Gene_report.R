library(tidyverse)
library(readxl)
library(dplyr)
library(tidyr)

# R file which analyzes deletion and amplification statistics and
# Generates gene report


amplification_total <- data.frame()
deletion_total <- data.frame()
cohort_deletion_list <- data.frame()
cohort_amplification_list <- data.frame()

#' Returns binded data.frame of all amplified genes in a given CNV file.
#' @param patient_file A data.frame containing single patient data from CNV file.
#' @return The total data.frame of all amplified genes for given patient
get_amplification <- function(patient_file){
  for(row in 1:nrow(patient_file)){
#   for(row in 1:100){
    if (!is.data.frame(patient_file)){
      stop("input patient_file is not a data.frame; please check your inputs.")
    }

    if (is.na(patient_file[row,]$copy_number)){
      next # If copy_number undefined, skip iteration
    }

    gene_name <- patient_file[row,]$gene_name
    chromosome <- patient_file[row,]$chromosome
    start <- patient_file[row,]$start
    end <- patient_file[row,]$end
    copy_number <- patient_file[row,]$copy_number

    if(patient_file[row,]$copy_number > 2){
      amplification <- data.frame(gene_name,
                             chromosome,
                             start,
                             end,
                             copy_number
      )
      amplification_total <- rbind(amplification_total, amplification)
    }
   }
  return(amplification_total)
}

#' Returns binded data.frame of all deleted genes in a given CNV file.
#' @param patient_file A data.frame containing single patient data from CNV file.
#' @return The total data.frame of all deleted genes for given patient
get_deletion <- function(patient_file){
  for(row in 1:nrow(patient_file)){
#   for(row in 1:100){
     if (!is.data.frame(patient_file)){
       stop("input patient_file is not a data.frame; please check your inputs.")
     }

    if (is.na(patient_file[row,]$copy_number)){
      next # If copy_number undefined, skip iteration
    }

     gene_name <- patient_file[row,]$gene_name
     chromosome <- patient_file[row,]$chromosome
     start <- patient_file[row,]$start
     end <- patient_file[row,]$end
     copy_number <- patient_file[row,]$copy_number


     if(patient_file[row,]$copy_number < 2){
       deletion <-      data.frame(gene_name,
                                   chromosome,
                                   start,
                                   end,
                                   copy_number
       )
      deletion_total <- rbind(deletion_total, deletion)
    }
   }
  return(deletion_total)
}

#' Generates a gene deletion report using a list of CNV files located in cnv_base_path.
#' @param cnv_base_path A path to all relevant CNV files for analysis.
#' @param num_genes_top Integer which specifies # of highest-frequency genes to return.
#' @return Frequency table of deleted genes, with num_genes_top rows
gene_report_deletion<-function(cnv_base_path, num_genes_top){
  if (!(is.numeric(num_genes_top) && num_genes_top >= 1)){
    stop("num_genes_top must be a number >= 1.")
  }

  #remove the path line below later when making this a universal package
  #cnv_base_path <- "/Users/sidneybenich/Documents/ASU BMI Grad School/Fall '23/BMI 540/CNV_Files"
  file_list <- list.files(cnv_base_path, include.dirs = TRUE)

  for(file in file_list){
    cnvfile_abs_path <- file.path(cnv_base_path, file)

    if(!grepl("\\.tsv$", file)){ # File must have .tsv extension
      stop("File does not have .tsv extension.")
    }

    dataset <- read.csv(cnvfile_abs_path, sep="\t", na.strings=c("","NA"))

    print(paste("Running deletion analysis for this file: ", cnvfile_abs_path))

    if(sum(is.na(dataset$gene_name)) >= 1){
      stop("There are NA values for gene_name in above file. Please check input data.")
    }

    patient_deletion_list <-get_deletion(dataset)
    cohort_deletion_list <- rbind(cohort_deletion_list, patient_deletion_list)
  }

  del_table<-cohort_deletion_list %>%
    count(gene_name, sort=TRUE) %>%
    slice_head(n=num_genes_top)

  print(sprintf("Returning top %s deletion genes after analyzing %s files: ", num_genes_top, length(file_list)))
  if(nrow(del_table) < num_genes_top){
    warning("Warning: Number of rows in deletion frequency table less than num_genes_top. Returning all rows.")
  }

  return(del_table)
}

#' Generates a gene amplification report using a list of CNV files located in cnv_base_path.
#' @param cnv_base_path A path to all relevant CNV files for analysis.
#' @param num_genes_top Integer which specifies # of highest-frequency genes to return.
#' @return Frequency table of amplified genes, with num_genes_top rows
gene_report_amplification<-function(cnv_base_path, num_genes_top){
  if (!(is.numeric(num_genes_top) && num_genes_top >= 1)){
    stop("num_genes_top must be a number >= 1.")
  }

  #remove the path line below later when making this a universal package
  #cnv_base_path <- "/Users/sidneybenich/Documents/ASU BMI Grad School/Fall '23/BMI 540/CNV_Files"
  file_list <- list.files(cnv_base_path, include.dirs = TRUE)

  for(file in file_list){
    cnvfile_abs_path <- file.path(cnv_base_path, file)

    if(!grepl("\\.tsv$", file)){ # File must have .tsv extension
      stop("File does not have .tsv extension.")
    }

    dataset <- read.csv(cnvfile_abs_path, sep="\t", na.strings=c("","NA"))

    print(paste("Running amplification analysis for this file: ", cnvfile_abs_path))

    if(sum(is.na(dataset$gene_name)) >= 1){
      stop("There are NA values for gene_name in above file. Please check input data.")
    }

    patient_amplification_list <- get_amplification(dataset)
    cohort_amplification_list <-rbind(cohort_amplification_list, patient_amplification_list)

  }

  amp_table<-cohort_amplification_list %>%
    count(gene_name, sort=TRUE) %>%
    slice_head(n=num_genes_top)

  print(sprintf("Returning top %s deletion genes after analyzing %s files: ", num_genes_top, length(file_list)))

  if(nrow(amp_table) < num_genes_top){
    warning("Warning: Number of rows in amplification frequency table less than num_genes_top. Returning all rows.")
  }

  return(amp_table)
}

#input_path <- "/Users/sidneybenich/Documents/CNV Analysis Project/Data"

#start.time <- Sys.time()
#output_amp<-gene_report_amplification(input_path, 100)
#end.time <- Sys.time()
#time.taken <- round(end.time - start.time,2)
#print(paste("Time taken for amplification run is: ", time.taken))
#view(output_amp)

#start.time <- Sys.time()
#output_amp<-gene_report_deletion(input_path, 100)
#end.time <- Sys.time()
#time.taken <- round(end.time - start.time,2)
#print(paste("Time taken for deletion run is: ", time.taken))
#view(output_del)

