
cdc_nnd <- function(x1) {
   x2 <- gsub( "–", "-", x1)
   doc <- htmlParse(x2)
   # diseases within <span> and <a> tags
   x <- xpathSApply(doc, "//div[@id='list-of-notifiable-diseases']//li/span|//div[@id='list-of-notifiable-diseases']//li/a", xmlValue)
   n <- xpathSApply(doc, "//div[@id='list-of-notifiable-diseases']//li/span|//div[@id='list-of-notifiable-diseases']//li/a", xmlName)=="a"
   y <- data.frame( cbind(disease= x, group=ifelse(n, x, "")) , stringsAsFactors=FALSE)
   ## repeat <a> tag along <span> diseases
   for(i in seq_along(y[,2] ) )  if( y[i,2]=="") y[i,2] <- y[i-1, 2]
   #delete all <a> before <span> 
   n2<- which(diff(n)== -1)
   y <- y[-n2, ]
   y$group[y$group==y$disease] <- ""
   y
}

