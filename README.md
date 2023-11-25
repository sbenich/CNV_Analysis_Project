# CNV_Analysis_Project
## Description
CNV Analysis Project created for BMI 540 course. This is an R package designed to analyze Copy Number Variantion files and return a report of genes that were amplified or deleted.
## Cloning the Repository
1. To clone the repository to your local system, use this command in your terminal: 
  `git clone https://github.com/sbenich/CNV_Analysis_Project.git`
## Installation
1. Install R and RStudio. They can be downloaded at this [link](https://posit.co/download/rstudio-desktop/).
2. Using `install.packages`, install R packages `tidyverse` , `dplyr`, `tidyr` and `devtools`.
3. Call `library("devtools")`.
4. Then `install_github("sbenich/CNV_Analysis_Project")`.
5. Call `library("CNVGeneReport")`.
## How to Use 
### Functions `get_amplification` and `get_deletion`
1. If you would like to evaluate a single CNV file for a list of amplified genes or deleted gene
