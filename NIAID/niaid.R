niaid <- function( x1 ){

#message("Downloading HTML")
# url <- "http://www.niaid.nih.gov/topics/biodefenserelated/biodefense/pages/cata.aspx"
# x1 <- readLines(url)

 ## parse HTML using subsets between n1 and n2 to avoid script tags that may cause errors

  message("Parsing Category A")
  n1 <- grep("<h4>Category A Priority", x1)
  n2 <- grep("<p>Category B pathogens", x1)
  y <- x1[n1:n2]
  y <- gsub("</?em>", "", y)
 
  doc <- htmlParse(y)
  a1 <- niaid2df(doc)

  message("Parsing Category B")
  n1 <- grep("<h4>Category B Priority", x1)
  n2 <- grep("<p>Category C pathogens", x1)
  y <- x1[n1:n2]
  y <- gsub("</?em>", "", y)
  doc <- htmlParse(y)
  a2 <- niaid2df(doc)
  
  message("Parsing Category C")
  n1 <- grep("<h4>Category C Priority", x1)
  n2 <- grep("<li>Coccidioides", x1) + 1
  y <- x1[n1:n2]
  y <- gsub("</?em>", "", y)
  doc <- htmlParse(y)
  a3 <- niaid2df(doc)

  message("Parsing Additional Emerging Pathogens")
  n1 <- grep("<h3>Additional Emerging Infectious", x1)
  n2 <- grep("AIDS is excluded", x1) -1
  y <- x1[n1:n2]
  y <- gsub("</?em>", "", y)
  # don't split Babesia, atypical and Streptococcus, Group A
  y <- gsub(",", ";", y)
  doc <- htmlParse(y)
  a4 <- niaid2df(doc)
  a4[,1] <- gsub(";", ",", a4[,1])

  z <- rbind( cbind(a1, category="Category A Priority Pathogens"),
        cbind(a2, category="Category B Priority Pathogens"),
        cbind(a3, category="Category C Priority Pathogens"),
        cbind(a4, category="Additional Emerging Infectious Diseases/Pathogens") )
  z <- cbind(n = 1:nrow(z), z)

}


niaid2df <- function( doc ){

   # get nodes  - use node()[1] due to nested tags
   #<li>Viral hemorrhagic fevers <ul type=\"circle\"><li>Arenaviruses <ul type=\"square\"><li>Junin, Machupo, Guanarito, Chapare,.. </li></ul></li>
   ## but will miss Q fever (so remove <em> tags) 
    #<li><em>Coxiella burnetii</em> (Q fever)</li>

   x <- xpathSApply(doc, "//li/node()[1]", xmlValue)
   # some trailing spaces
   x <-  gsub(" +$", "", x)

   # count ancestors for conditional tests in loop
   n <- xpathSApply(doc, "//li/node()[1]", function(y) length(xmlAncestors(y) ))

   n2 <-length( x )
   ## add extra number since checking n[i+1] below
   n <- c(n, n[length(n)])
   path <- vector("list")

   cat <- NULL
   for(i in 1: n2){
      if(  n[i] <  n[i+1] ){
         cat <- c(cat, x[i])
      }else{
         # split
         y <-  strsplit(x[i], ", |,? and ")[[1]]
         cat1 <- paste(cat, collapse="; ")

         for(j in 1:length(y)){
            z <- y[j] 
            note <- ""
            if(grepl(" (", z, fixed=TRUE) ){
               note <- gsub(".*? \\((.+)\\)", "\\1", z )
               z <- gsub(" \\(.+\\)", "", z)
            }
             # Fix for Enterococcus faecium and faecalis
             if(z=="faecalis") z <- "Enterococcus faecalis"
             if(grepl("^measles", note)) note <- gsub(") (", ", ", note, fixed=TRUE)

            path[[z]] <- data.frame(pathogen=z, note, group = cat1, stringsAsFactors=FALSE )
         }
         # remove last header
         if( n[i] >  n[i+1]){
               cat <- cat[-length(cat)]
             # fix for Cat B ,Food is nested twice, Mosquito once
              if(n[i] - n[i+1] == 4) cat <- cat[-length(cat)]
         }
      }
   }
   y <- do.call("rbind", path)
   rownames(y) <- NULL
   y
}
