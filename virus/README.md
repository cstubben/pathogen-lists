###Viruses

[1] ViralZone
 
A [table](http://viralzone.expasy.org/all_by_species/678.html) from the Swiss Institute of Bioinformatics Resource Portal with 129 human viral pathogens. A replacement character at the start of the [file](http://education.expasy.org/Table_human_viruses.txt) will cause errors when loading into R.

[2] [Virus-Host DB](http://www.genome.jp/virushostdb)

A [table](http://www.genome.jp/virushostdb/view/?host_lineage=Homo%20sapiens) with 346 human viruses.

```R
url <- "http://www.genome.jp/virushostdb/view/?download=1"
x <- read.delim(url, stringsAsFactors=FALSE)
y <- subset(x, virus.tax.id %in% x$virus.tax.id[x$host.name=="Homo sapiens"], c(1:3,6) )
library(dplyr)
vhdb <- group_by(y, virus.name, virus.tax.id, virus.lineage)  %>% summarize( N = n(), host = paste(sort(host.name), collapse="; ")  )
names(vhdb)[1:3] <- c("name", "taxid", "lineage")
vhdb$lineage <- gsub("^Viruses; ", "", vhdb$lineage)
table(gsub("([^;]+);.*", "\\1", vhdb$lineage))

                 Deltavirus dsDNA viruses, no RNA stage               dsRNA viruses  Retro-transcribing viruses 
                          1                         103                           9                          10 
              ssDNA viruses               ssRNA viruses        unclassified viruses 
                         59                         161                           3 
```
