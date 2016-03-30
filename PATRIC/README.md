###PATRIC

A table with 202 human pathogen bacterial species from [PATRIC](https://www.patricbrc.org/portal/portal/patric/GenomeList?cType=taxon&cId=2)  downloaded on March 30, 2016.

```R
# manually download table - really?
x <- read.delim("Patric.txt", stringsAsFactors=FALSE, check.names=FALSE)
y <- subset(x, grepl("Homo|Human", `Host Name`, ignore=TRUE), -69)   # drop "" column or dplyr will fail
y$species <- gsub("([^ ]+ [^ ]*).*", "\\1", y$`Genome Name`)
y$Disease <- gsub("\\]|\\[", "", y$Disease)
pat <- group_by(y, species)  %>% summarize( genomes = n(), disease = paste(sort(unique(Disease)), collapse="; ")  )
```
