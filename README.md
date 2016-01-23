
Lists of human pathogens from the literature and web including details and R code for scraping tables, tab-delimited files and mappings to the NCBI taxonomy database. 

The [NCBI taxonomy lookup page](http://www.ncbi.nlm.nih.gov/Taxonomy/TaxIdentifier/tax_identifier.cgi) was used to find non-matching names, for example, the [FDA pathogen list](FDA/FDA.tsv) includes three FDA pathogen names that are saved in a [lookup file](FDA/FDAtoNCBI.tsv) with the valid NCBI taxonomy name.

The [XML](https://cran.r-project.org/web/packages/XML/index.html) package is required for scraping web pages.

