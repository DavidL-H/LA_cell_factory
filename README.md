# LA_cell_factory
Chapter II of the Ph.D. - Metabolic engineering of Escherichia coli for high-level production of free lipoic acid


## Screening of ~3000 small-scale free lipoic acid production cultivations
In this section of the chapter we describe the engineered free lipoic acid cell factories used in small-scale screening to identify the _E. coli_ strain
### LA_screening_DataBase.csv
A .csv "database" of screening data. This data is show in Chapter II, Figure 4
Each of the 2924 rows represents one well/cultivation and has the following associated columns:

>colnames(LA_screening_DataBase)
1] "X"                 "Date"              "Position"          "Plate"            
 [5] "Strain"            "Rep"               "IPTG_uM"           "aTet_nM"          
 [9] "Antibiotic"        "Media"             "Sealed"            "Induction_time"   
[13] "BA_2430"           "BA_7290"           "BA_810"            "bg_strain"        
[17] "IPTG_mM"           "Background_strain" "Plasmid_1"         "Plasmid_2"        
[21] "Rha_mM"            "BA_1250"           "BA_21870"          "max_titer"     

Many rows (wells) do not report any LA titers, not because no lipoic was produced but because the bioassay response was not within the linear range of quantification at the assayed dilutions.

### DB_CSV.R
An R-script for gathering and plotting the screening data-base data

### strainlist.csv
An overview of the strains used for screening in the "La_screening_Databbase.csv". Indicating plasmids and background strains used.
