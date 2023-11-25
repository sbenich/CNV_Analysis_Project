# CNV_Analysis_Project
## Description
CNV Analysis Project created for BMI 540 course. This is an R package designed to analyze Copy Number Variantion files and return a report of genes that were amplified or deleted.
## Cloning the Repository
1. To clone the repository to your local system, use this command in your terminal: 
  `git clone https://github.com/sbenich/CNV_Analysis_Project.git`
## Installation
### For Mac
1. Install R and RStudio. They can be downloaded at this [link](https://posit.co/download/rstudio-desktop/).
2. Using `install.packages`, install R packages `tidyverse` and `devtools`. *You may also need to install `Xcode` from the App Store.*
3. Call `library("devtools")`.
4. Make sure to set `basepath` to be the R directory of your cloned github repo. Additionally, use `setwd()` in the console to this same directory.
5. Then use command `load_all(".")`.
6. Call `library("CNVGeneReport")`.
### For Windows
1. Install R and RStudio. They can be downloaded at this [link](https://posit.co/download/rstudio-desktop/).
2. Using `install.packages`, install R packages `Rtools`, `tidyverse` , and `devtools`. *You need to install `Rtools` before you can install the other packages.*
3. Call `library("devtools")`.
4. Then `install_github("sbenich/CNV_Analysis_Project")`.
5. Call `library("CNVGeneReport")`.
## How to Use 
### Functions `get_amplification` and `get_deletion`
1. If you would like to evaluate a single CNV file for a list of amplified genes or deleted gene
