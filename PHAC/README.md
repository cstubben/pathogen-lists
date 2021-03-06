###Public Health Agency of Canada (PHAC)

[1] A [list](http://www.phac-aspc.gc.ca/lab-bio/res/psds-ftss/index-eng.php) with 188 pathogens and links to Pathogen Safety Data Sheets.  The list requires the R script [psds_list.R](psds_list.R) to get pathogen names and data sheet links.


```R
url <- "http://www.phac-aspc.gc.ca/lab-bio/res/psds-ftss/index-eng.php"
x1 <- readLines(url)
phac <- psds_list(x1)
write.table(phac, file = "PHAC/PHAC.tsv", sep="\t", quote=FALSE, row.names=FALSE)
```

The Pathogen Safety Data Sheets include over 30 different fields and are available as an app in the [Android](https://play.google.com/store/apps/details?id=ca.gc.hcsc.psds), [Amazon](http://www.amazon.ca/dp/B00VTTA7Q8), [Apple](https://itunes.apple.com/ca/app/pathogen-safety-data-sheets/id977376698?mt=8l), and [Window](https://www.microsoft.com/en-us/store/apps/psds-ftss/9nblggh3g62f) stores. If needed, you can scrape the data sheets in R below.

```R
x1 <- readLines( phac$url[phac$pathogen=="Yersinia pestis"] )
doc <- htmlParse(x1, encoding="UTF-8")
y2 <- xpathSApply(doc, "//p/strong/..|//h3", xmlValue)
y2 <- gsub("\n", " ", y2)

# format output
y3 <- strwrap(y2, width=80, exdent=4)
cat(y3, sep="\n")

SECTION I - INFECTIOUS AGENT
NAME: Yersinia pestis
SYNONYM OR CROSS REFERENCE: Plague, Peste, Bubonic plague
CHARACTERISTICS: Gram negative rod-ovoid 0.5-0.8 µm in width and 1-3 µm in
    length, bipolar staining (safety pin appearance), facultative
    intracellular, non-motile
SECTION II - HEALTH HAZARD
PATHOGENICITY: Zoonotic disease; bubonic plague with lymphadenitis in nodes
    receiving drainage from site of flea bite, occuring in lymph nodes and
    inguinal areas, fever, 50% case fatality if untreated; may progress to
    septicemic plague with dissemination by blood to meninges; secondary
    ...
```

[2]  [Garner MJ, Carson C, Lingohr EJ, et al. 2015](http://journals.plos.org/plosone/article?id=10.1371/journal.pone.0125155). *An Assessment of Antimicrobial Resistant Disease Threats in Canada*. PLoS One 10:e0125155

A list of 32 antimicrobial resistance pathogens and total risk scores from Table 2 and Table S1 published by researchers from PHAC.

