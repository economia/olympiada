scraper <- function() {
  
  library('RCurl')
  library('XML')
  library('stringr')
  
  # vytvořit seznam adres se jmény sportovců
  
  list <- htmlParse("athleteslist.html")
  list <- xpathSApply(list, "//*[@id=\"show-more-container\"]/li[.]")
  list <- sapply(list, xmlAttrs)[2,]
  list <- paste("http://www.sochi2014.com/en/athlete-", list, sep="")

  # postahovat údaje sportovců
  
  soubor <- file("../data/atletisochi.csv", "a")

  writeLines("Jméno|Disciplína|Stát|Pohlaví|Datum narození|Věk|Výška|Váha|Místo narození|Místo pobytu|Přezdívka|Trenér|Ruka|Zranění|Předchozí|Povolání|Klub|Pozice|Vzor|Jazyky|Hobbies|Ambice|Důvody|Motto", soubor)  
  
  for(i in 1:length(list)) {
    web <- getURL(list[i])
    atlet <- htmlParse(web)
    a.jmeno <- xpathSApply(atlet, "//*[@id=\"content\"]/div/div[1]/aside[1]/div/div/h2", xmlValue)
    a.fotka <- readLines(tc <- textConnection(web)); close(tc)
    a.index <- grep("img itemprop=", a.fotka)
    a.fotka <- sub(".*src=\"", "", a.fotka[a.index])
    a.fotka <- sub("\" alt.*", "", a.fotka)
    download.file(a.fotka, paste("../data/atletifotky/", a.jmeno, ".jpg", sep=""), quiet=T)   
    a.disciplina <- xpathSApply(atlet, "//*[@id=\"content\"]/div/div[1]/aside[1]/div/div/div[2]/a/text()", xmlValue)
    a.stat <- sub(".", "", xpathSApply(atlet, "//*[@id=\"content\"]/div/div[1]/aside[1]/div/div/div[1]/ul[1]/li[2]/text()", xmlValue))
    a.pohlavi <- sub(".", "", xpathSApply(atlet, "//*[@id=\"content\"]/div/div[1]/aside[1]/div/div/div[1]/ul[1]/li[1]/text()", xmlValue))
    a.narozeni <- sub(".", "", xpathSApply(atlet, "//*[@id=\"content\"]/div/div[1]/aside[1]/div/div/div[1]/ul[2]/li[1]/text()", xmlValue))
    a.vek <- sub(".", "", xpathSApply(atlet, "//*[@id=\"content\"]/div/div[1]/aside[1]/div/div/div[1]/ul[2]/li[2]/text()", xmlValue))
    a.vyska <- sub(".", "", xpathSApply(atlet, "//*[@id=\"content\"]/div/div[1]/aside[1]/div/div/div[1]/ul[3]/li[1]/text()", xmlValue))
    a.vyska <- sub(".m.*", "", a.vyska)
    a.vaha <- sub(".", "", xpathSApply(atlet, "//*[@id=\"content\"]/div/div[1]/aside[1]/div/div/div[1]/ul[3]/li[2]/text()", xmlValue))
    a.vaha <- sub(".kg.*", "", a.vaha)
    a.mistonarozeni <- sub(".", "", xpathSApply(atlet, "//*[@id=\"content\"]/div/div[1]/aside[1]/div/div/div[1]/ul[4]/li[1]/text()", xmlValue))
    a.mistokdezije <- sub(".", "", xpathSApply(atlet, "//*[@id=\"content\"]/div/div[1]/aside[1]/div/div/div[1]/ul[4]/li[2]/text()", xmlValue))
    a.zlato <- as.numeric(xpathApply(atlet, "//*[@id=\"content\"]/div/div[1]/aside[1]/div/div/ul/li[1]/span", xmlValue)[1])
    a.stribro <- as.numeric(xpathApply(atlet, "//*[@id=\"content\"]/div/div[1]/aside[1]/div/div/ul/li[2]/span", xmlValue)[1])
    a.bronz <- as.numeric(xpathApply(atlet, "//*[@id=\"content\"]/div/div[1]/aside[1]/div/div/ul/li[3]/span", xmlValue)[1])
    a.detail <- paste(as.character(xpathApply(atlet, "//*[@id=\"content\"]/div/div[1]/aside[1]/div[2]/div[2]/ul[1]", xmlValue)), as.character(xpathApply(atlet, "//*[@id=\"content\"]/div/div[1]/aside[1]/div[2]/div[2]/ul[2]", xmlValue)))
    if (length(a.detail) == 0) a.detail <- "" 
    if (grepl("Nickname:", a.detail)) {
      a.prezdivka <- sub(".*Nickname:", "Nickname:", a.detail)
      a.prezdivka <- sub("Nickname:.", "", a.prezdivka)
      a.prezdivka <- sub("\n.*", "", a.prezdivka)
      a.prezdivka <- sub("\\(.*", "", a.prezdivka)
    } else a.prezdivka <- ""
    if (grepl("Coach:", a.detail)) {
      a.trener <- sub(".*Coach:", "Coach:", a.detail)
      a.trener <- sub("Coach:.", "", a.trener)
      a.trener <- sub("\n.*", "", a.trener)
      a.trener <- sub("\\(.*", "", a.trener)
    } else a.trener <- ""
    if (grepl("Hand:", a.detail)) {
      a.ruka <- sub(".*Hand:", "Hand:", a.detail)
      a.ruka <- sub("Hand:.", "", a.ruka)
      a.ruka <- sub("\n.*", "", a.ruka)
      a.ruka <- sub("\\(.*", "", a.ruka)
    } else a.ruka <- ""
    if (grepl("Injuries:", a.detail)) {
      a.zraneni <- sub(".*Injuries:", "Injuries:", a.detail)
      a.zraneni <- sub("Injuries:.", "", a.zraneni)
      a.zraneni <- sub("\n.*", "", a.zraneni)
      a.zraneni <- sub("\\(.*", "", a.zraneni)
    } else a.zraneni <- ""
    if (grepl("Previous Olympics:", a.detail)) {
      a.olympiady <- sub(".*Previous Olympics:", "Previous Olympics:", a.detail)
      a.olympiady <- sub("Previous Olympics:.", "", a.olympiady)
      a.olympiady <- sub("\n.*", "", a.olympiady)
      a.olympiady <- sub("\\(.*", "", a.olympiady)
    } else a.olympiady <- ""
    if (grepl("Occupation:", a.detail)) {
      a.povolani <- sub(".*Occupation:", "Occupation:", a.detail)
      a.povolani <- sub("Occupation:.", "", a.povolani)
      a.povolani <- sub("\n.*", "", a.povolani)
      a.povolani <- sub("\\(.*", "", a.povolani)
    } else a.povolani <- ""
    if (grepl("Club Name:", a.detail)) {
      a.klub <- sub(".*Club Name:", "Club Name:", a.detail)
      a.klub <- sub("Club Name:.", "", a.klub)
      a.klub <- sub("\n.*", "", a.klub)
      a.klub <- sub("\\(.*", "", a.klub)
    } else a.klub <- ""
    if (grepl("Position Style:", a.detail)) {
      a.pozice <- sub(".*Position Style:", "Position Style:", a.detail)
      a.pozice <- sub("Position Style:.", "", a.pozice)
      a.pozice <- sub("\n.*", "", a.pozice)
      a.pozice <- sub("\\(.*", "", a.pozice)
    } else a.pozice <- ""
    if (grepl("Hero", a.detail)) {
      a.vzor <- sub(".*Hero", "Hero", a.detail)
      a.vzor <- sub("Hero", "", a.vzor)
      a.vzor <- sub("\n.*", "", a.vzor)
      a.vzor <- sub("\\(.*", "", a.vzor)
    } else a.vzor <- ""
    if (grepl("Languages Spoken:", a.detail)) {
      a.jazyky <- sub(".*Languages Spoken:", "Languages Spoken:", a.detail)
      a.jazyky <- sub("Languages Spoken:.", "", a.jazyky)
      a.jazyky <- sub("\n.*", "", a.jazyky)
      a.jazyky <- sub("\\(.*", "", a.jazyky)
    } else a.jazyky <- ""
    if (grepl("Hobbies:", a.detail)) {
      a.hobbies <- sub(".*Hobbies:", "Hobbies:", a.detail)
      a.hobbies <- sub("Hobbies:.", "", a.hobbies)
      a.hobbies <- sub("\n.*", "", a.hobbies)
      a.hobbies <- sub("\\(.*", "", a.hobbies)
    } else a.hobbies <- ""
    if (grepl("Ambitions", a.detail)) {
      a.cile <- sub(".*Ambitions", "Ambitions", a.detail)
      a.cile <- sub("Ambitions", "", a.cile)
      a.cile <- sub("\n.*", "", a.cile)
      a.cile <- sub("\\(.*", "", a.cile)
    } else a.cile <- ""
    if (grepl("Reason for taking up this sport", a.detail)) {
      a.duvody <- sub(".*Reason for taking up this sport", "Reason for taking up this sport", a.detail)
      a.duvody <- sub("Reason for taking up this sport", "", a.duvody)
      a.duvody <- sub("\n.*", "", a.duvody)
      a.duvody <- sub("\\(.*", "", a.duvody)
    } else a.duvody <- ""
    if (grepl("Sporting philosophy / motto", a.detail)) {
      a.motto <- sub(".*Sporting philosophy / motto", "Sporting philosophy / motto", a.detail)
      a.motto <- sub("Sporting philosophy / motto", "", a.motto)
      a.motto <- sub("\n.*", "", a.motto)
      a.motto <- sub("\\(.*", "", a.motto)
    } else a.motto <- ""
    
    print(paste(i, " - ", round(i/length(list)*100, 2), " % - ", a.jmeno, ".", sep=""))
    
    writeLines(paste(a.jmeno, a.disciplina, a.stat, a.pohlavi, a.narozeni, a.vek, a.vyska, a.vaha, a.mistonarozeni, a.mistokdezije, a.prezdivka, a.trener, a.ruka, a.zraneni, a.olympiady, a.povolani, a.klub, a.pozice, a.vzor, a.jazyky, a.hobbies, a.cile, a.duvody, a.motto, sep="|"), soubor)
    
  }
    
  closeAllConnections()  
      
}
