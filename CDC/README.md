###Centers for Disease Control (CDC)

[1]  Biosafety in Microbiological and Biomedical Laboratories, 5th Edition (Dec 2009)

A PDF version of the [BMBL](http://www.cdc.gov/biosafety/publications/bmbl5) including the [table of contents](BMBL_toc.tsv) and [Table 6](BMBL_t6.tsv) with a List of 597 Arboviruses and Hemorrhagic Fever Viruses.  The agent summaries include detailed sections of Occupational Infections, Natural Modes of Infection,
Laboratory Safety and Containment Recommendations, and Special Issues including Vaccines, Treatment, Select Agent and Transfer of Agent

[2] [Nationally Notifiable Diseases](cdc_nnd.tsv)

A 2016 [list](http://wwwn.cdc.gov/nndss/conditions/notifiable/2016) with 110 Nationally Notifiable Disease conditions.
The list requires an R script [cdc_nnd.R](cdc_nnd.R) to convert to a two column table with disease and group.  A lookup table between the infectious diseases and pathogen names is needed.


```R
url <- "http://wwwn.cdc.gov/nndss/conditions/notifiable/2016"
x1 <- readLines(url)
cdc <- cdc_nnd(x1)
write.table(cdc, file = "CDC/CDC_nnd.tsv", sep="\t", quote=FALSE, row.names=FALSE)
```


[3] [Antibiotic-Resistant pathogens](cdc_ar.tsv)

A PDF [table](http://www.cdc.gov/drugresistance/threat-report-2013/pdf/ar-threats-2013-508.pdf) on pages 16-18 in CDC report on *Antibiotic resistance threats in the United States, 2013* captioned "Minimum Estimates of Morbidity and Mortality from Antibiotic-Resistant Infections"

This report also classifies the drug-resistant pathogens into Urgent, Serious, and Concerning threats

```
Urgent Threats
  Clostridium difficile
  Carbapenem-resistant Enterobacteriaceae (CRE)
  Drug-resistant Neisseria gonorrhoeae
Serious Threats
  Multidrug-resistant Acinetobacter
  Drug-resistant Campylobacter
  Fluconazole-resistant Candida (a fungus)
  Extended spectrum β-lactamase producing Enterobacteriaceae (ESBLs)
  Vancomycin-resistant Enterococcus (VRE)
  Multidrug-resistant Pseudomonas aeruginosa
  Drug-resistant Non-typhoidal Salmonella
  Drug-resistant Salmonella Typhi
  Drug-resistant Shigella
  Methicillin-resistant Staphylococcus aureus (MRSA)
  Drug-resistant Streptococcus pneumoniae
  Drug-resistant tuberculosis
Concerning Threats
  Vancomycin-resistant Staphylococcus aureus (VRSA)
  Erythromycin-resistant Group A Streptococcus
  Clindamycin-resistant Group B Streptococcus
```



