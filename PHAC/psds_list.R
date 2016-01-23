
psds_list <- function(x1){

   ##url <- "http://www.phac-aspc.gc.ca/lab-bio/res/psds-ftss/index-eng.php"
   ## x1 <- readLines(url)

   doc <- htmlParse(x1)
   ## <em> tags before or after <a>
   path <- xpathSApply(doc, "//li//a[@href]", xmlValue)
   # for ncbi lookups, drop spp. from genus?
   #  path <- gsub(" spp\\.$", "", path)

   url2 <- xpathSApply(doc, "//li//a[@href]", xmlGetAttr, "href")
   url2 <- paste0("http://www.phac-aspc.gc.ca", url2)
   n <- grep("Actinobacillus", path)
   y <- data.frame(pathogen = path, url = url2, stringsAsFactors=FALSE)
   y <- y[n:nrow(y),]
   y <- subset(y, !pathogen %in% c("see Enterococcus faecalis", "") )
   rownames(y) <- NULL
   y
}

