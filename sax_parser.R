library(XML)

xmlDoc <- xmlParse("test_1000_linjer.xml")
fileName <- "test_1000_linjer.xml"
biler <- xpathSApply(xmlDoc, "//ns:KoeretoejArtNavn", xmlValue) #WOW!
biler <- NULL



# ---------------------------------

#a file to read with xmlEventParse
xmlDoc <- "ESStatistikListeModtag.xml"
items <- NULL
time_start <- Sys.time()

#function to use with xmlEventParse
row.sax = function() {
  
  #SAX function for antal biler og type
  Statistik = function(node){
    children <- xmlChildren(node)
    children[which(names(children) == "text")] <- NULL
    items <<- rbind(items, sapply(children,xmlValue))
  }
  
  KoeretoejAnvendelseNavn = function(node){
    children <- xmlChildren(node)
    children[which(names(children) == "text")] <- NULL
    items <<- rbind(items, sapply(children,xmlValue))
  }
  
  branches <- list(Statistik = Statistik)
  return(branches)
}

#call the xmlEventParse
xmlEventParse(xmlDoc, handlers = list(), branches = row.sax(),
              saxVersion = 2, trim = FALSE)

#processing the result as data.frame
items <- as.data.frame(items, stringsAsFactors = T)

row.names(items) <- 1:nrow(items)

time_end <- Sys.time()
time_elapsed <- time_end - time_start

items <- lapply(items, as.character)
items <- lapply(items, factor)
