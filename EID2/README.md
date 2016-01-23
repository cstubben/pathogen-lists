###Enhanced Infectious Disease Database (EID2)

Data Citations 1 and 2 from the [EID2](www.zoonosis.ac.uk/ EID2/) paper

[Wardeh M, Risley C, McIntyre MK, et al. 2015](http://www.nature.com/articles/sdata201549). *Database of host-pathogen and related species interactions, and their global distribution*.  Scientific Data 2:150049

[1] The [SpeciesInteractions_EID2.csv](http://dx.doi.org/10.6084/m9.figshare.1381853) file on FigShare contains 22,515 interactions between cargo and carriers (pathogen and hosts).  This R code will group by Cargo and save a [table](EID_pathogens.tsv) with 1631 human pathogens.

```R
x <- read.csv("SpeciesInteractions_EID2.csv", stringsAsFactors=FALSE)
library(plyr)
y <- ddply(x, c("Cargo" ,"Cargo.classification"), summarise,
               N    = length(Carrier),
               Carriers = paste(Carrier, collapse="; ") )
z <- subset( y, grepl("homo sapiens", Carriers))
table(z$Cargo.classification)

  Arthropod    Bacteria       Fungi Green algae    Helminth    Protozoa       Virus 
         19         878         311           1         148          70         204 

write.table(z, file = "EID2/EID_pathogens.tsv", sep="\t", quote=FALSE, row.names=FALSE)

```

[2] The [LocationInteractions_EID2.csv](http://dx.doi.org/10.6084/m9.figshare.1381854) file on FigShare contains 157,148 links between species and regions.  This R code will group by country and save a [table](EID_countries.tsv) with locations for 1199 human pathogens (so 432 human pathogens above are missing locations). 

```R
x1 <- read.csv("LocationInteractions_EID2.csv", stringsAsFactors=FALSE)
## get unique countries and ignore regions
y1 <- unique(x1[, 1:3])
y1 <- subset(y1, Species %in% z$Cargo)
z1 <- ddply(y1, c("Species" ,"Species.classification"), summarise,
               N    = length(Country),
               Countries = paste(Country, collapse="; ") )

write.table(z1, file = "EID2/EID_countries.tsv", sep="\t", quote=FALSE, row.names=FALSE)
```
