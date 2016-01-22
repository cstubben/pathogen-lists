#NIAID Priority Pathogens

A [list](http://www.niaid.nih.gov/topics/biodefenserelated/biodefense/pages/cata.aspx) from the National Institute of Allergy and Infectious Diseases with 106 Category A, B, and C Priority Pathogens and Additional Emerging Infectious Diseases.

This nested list requires an R script [niaid.R](niaid.R) to convert to a five column table with the number in list, pathogen name, disease or other note, group, and category.


```R
url <- "http://www.niaid.nih.gov/topics/biodefenserelated/biodefense/pages/cata.aspx"
x <- readLines(url)
source("niaid.R")
y <- niaid(x)
write.table(y, file = "NIAID/NIAID.tsv", sep="\t", quote=FALSE, row.names=FALSE)
# paste names into NCBI lookup page
cat(y$pathogen, sep="\n")
```

Currently we do not have a lookup for `drug-resistant TB` or `Diarrheagenic E.coli` or `Siberian subtype`, which may be a subspecies of Tick-borne encephalitis virus not in NCBI. 
