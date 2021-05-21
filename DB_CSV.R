# Header ------------------------------------------------------------------
# This tables cleaned micro-titer plates production data in list form, for processing and plotting.
# The data is given in one .csv file, called Lipoic_acid_MTP_DB.csv

# Call packages, If it is your first time running this script, you will need to install them first
# If you are missing a package, install with >install.packages("package_name")

library(ggplot2)
library(RColorBrewer)
library(tidyr)
library(reshape2)
library(stringi)
library(readxl)
library(dplyr)
library(plyr)
library(Biobase)
library(plotly)

# Clear environment
rm(list = ls(all.names = TRUE))

# By default it chooses the path where this script is saved. Path can be specified if needed by removing "#" and adding Your_filepath_here.
dir_name <-dirname(rstudioapi::getSourceEditorContext()$path)
# dir_name <- "C:/Your_filepath_here"
setwd(dir_name)


# Read and tidy data ------------------------------------------------------
# NOT NECESSARY TO RUN IF YOU HAVE THE DATABASE.CSV FILE IN REPOSITORY

# This reads the BA and OD excel files, if the name contains either BA or OD
DB_files <- list.files(pattern = 'frame', recursive = TRUE, ignore.case = TRUE)
 
for ( file in DB_files ) {
  temp <- read.csv(file)
  assign(file, temp)
}
rm(temp)

# [1] "a" "b" "c" "d" "e"
dfs = sapply(.GlobalEnv, is.data.frame) 
DATABASE <- do.call(rbind.fill, mget(names(dfs)[dfs]))

#Remove empty column
colnames(DATABASE)
DATABASE<-DATABASE[,-1]

#Merge IPTG mM and IPTG uM:
DATABASE$IPTG_mM<-DATABASE$IPTG_mM*1000
for (n in 1:nrow(DATABASE)){
  if (is.na(DATABASE$IPTG_mM[n])==FALSE){
    DATABASE$IPTG_uM[n]<-DATABASE$IPTG_mM[n]
  }
}

#Take the max of the BA titer across different dilutions
colnames(DATABASE)[15]<-"bg_strain"
DATABASE$max_titer <- apply(select(DATABASE,contains("BA")), 1, max, na.rm = TRUE)

# Write the cleaned up data based to 
write.csv(DATABASE,file="LA_screening_DataBase.csv")
rm(list = ls(all.names = TRUE))
DATABASE<-read.csv("LA_screening_DataBase.csv")

# PLOT DATA
# PLot all the data that has an IPTG, aTet concentration and a Titer:
plot_ly(data=subset(DATABASE, DATABASE$Media!="FIT"),x= ~aTet_nM, y= ~IPTG_uM, z= ~max_titer, color = ~Strain, 
        type="scatter3d", 
        mode="markers",
        marker =list(size = 4),
        #color = 2, 
        opacity = 0.5)%>%
  layout(
    title = "Tet inducible Lipoamidase screening",
    scene = list(
      xaxis = list(type = "log"),
      yaxis = list(type = "log")
      #yaxis = list(title = "IPTG (mM)"),
      #zaxis = list(title = "Lipoic acid (mg/L)")
    ))

# PLot the data from the best performing strain, BS3804:
DB_BS3804<-subset(DATABASE, DATABASE$Strain=="BS3804")

BS3804_validation<-read.csv("C:/Users/David/Biosyntia/Administration - David Lennox-Hvenekilde/PhD stuff/Writing/02-Free lipoic acid producing cell factory/Data/Production data/BS3804 best strain validation/BS3804_validation_production.csv")
plot_ly(data=subset(DATABASE, DATABASE$Media!="FIT"),x= ~aTet_nM, y= ~IPTG_uM, z= ~max_titer, color = ~Strain, 
        type="scatter3d", 
        mode="markers",
        marker =list(size = 4),
        #color = 2, 
        opacity = 0.5)%>%
  layout(
    title = "Tet inducible Lipoamidase screening",
    scene = list(
      xaxis = list(type = "log"),
      yaxis = list(type = "log")
      #yaxis = list(title = "IPTG (mM)"),
      #zaxis = list(title = "Lipoic acid (mg/L)")
    ))