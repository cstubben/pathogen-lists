#FDA Foodborne Illnesses

A [table](http://www.fda.gov/food/resourcesforyou/consumers/ucm103263.htm) from the U.S. Food and Drug Administration with 16 foodborne disease-causing organisms that frequently cause illness in the United States.


```R
url <- "http://www.fda.gov/food/resourcesforyou/consumers/ucm103263.htm"
x <- readLines(url)
# fix breaks
x <- gsub("<br />", " ", x, fixed=TRUE)
fda <- readHTMLTable(x, which=1, stringsAsFactors=FALSE)
write.table(fda, file = "FDA/FDA.tsv", sep="\t", quote=FALSE, row.names=FALSE)
# paste names into NCBI lookup
cat(fda$Org, sep="\n")
```

Currently we do not have a lookup for `E. coli (Escherichia coli) producing toxin`


