scraper <- function() {
  
  library('RCurl')
  library('XML')
  library('stringr')
  
  #vytvořit seznam adres se jmény sportovců
  
  puladresa <- paste("http://www.sports-reference.com/olympics/athletes/", letters, sep="")
  adresa <- vector()
  
  for(i in 1:length(puladresa)) {
    adresa <- append(adresa, paste(paste(puladresa[i], letters, sep=""), "/", sep=""))
  }
  
  rm(puladresa); rm(i)
  
  #vytvořit seznam adres s údaji sportovců
  
  jmena <- vector()
  for(i in 1:length(adresa)) {
    
    web <- getURL(adresa[i])
    web <- readLines(tc <- textConnection(web)); close(tc)
    if (web[1] == "Status: 301 Moved Permanently") next
    radekstart <- grep("margin_top small_text", web)
    radekpocet <- grep("Athlete.*</h2>", web)
    pocet <- sub("<h2 style=\"\">", "", web[radekpocet])
    pocet <- sub(" Athlete.*", "", pocet)
    pocet <- as.numeric(pocet)
    
    for(j in 1:pocet) {
      jmeno <- sub('.*="', '', web[radekstart+j])
      jmeno <- sub('\">.*', '', jmeno)  
      jmena <- append(jmena, paste("http://www.sports-reference.com", jmeno, sep=""))
    }
    
    print(paste(adresa[i], ": ", pocet, " sportovců.", sep=""))
    
  }
  
  rm(i); rm(j); rm(adresa); rm(jmeno); rm(pocet); rm(radekpocet); rm(radekstart); rm(tc); rm(web)
  
  write.csv(jmena, "adresy.csv")  
  
  ####################################################################
  #pro každého sportovce zjistit detaily a zapsat je do výškaváha.csv
  
  jmena <- read.csv(file="adresy.csv", header=F)
  jmena <- as.vector(jmena[,2])
  
  soubor <- file('vyskavaha.csv', "a")
  
  #writeLines("Jméno|Přezdívka|Pohlaví|Výška|Váha|Narození|Úmrtí|Klub|Stát|Sport|Hry1|Událost1|Tým1|Pořadí1|Medaile1|Detail1", soubor) 
  
  for(j in 111354:length(jmena)) {
    
    web <- getURL(jmena[j])
    web <- readLines(tc <- textConnection(web)); close(tc)
    
    index <- grep("Full name:", web)
    jmeno <- sub(".*</span> ", '', web[index])
    
    index <- grep("Nickname", web)
    prezdivka <- sub(".*</span> ", '', web[index])
    
    index <- grep("Gender:", web)
    pohlavi <- sub(".*</span> ", '', web[index])
    
    index <- grep("Height:", web)
    vyska <- sub(".*</span> ", '', web[index])
    
    index <- grep("Weight:", web)
    vaha <- sub(".*</span> ", '', web[index])    
    
    index <- grep("Born:", web)
    narozeni <- sub(".*data-birth=.", '', web[index])
    narozeni <- sub(".><a href=.*", '', narozeni)
    
    index <- grep("Died:", web)
    umrti <- sub(".*data-death=.", '', web[index])
    umrti <- sub("\">.*", '', umrti)
    
    index <- grep("Affiliations:", web)
    klub <- sub(".*</span> ", '', web[index])
    
    index <- grep("Country:</span>", web)
    stat <- sub(".*title=\"", "", web[index])
    stat <- sub("\".*", '', stat)
    
    index <- grep("Sport:</span>", web)
    sport <- sub(".*\">", '', web[index]) 
    sport <- sub("</a>", '', sport)
    
    writeLines(paste(jmeno, prezdivka, pohlavi, vyska, vaha, narozeni, umrti, klub, stat, sport, sep='|'), soubor, sep="|")
    
    #výsledky
    
    indexvysl <- grep(">Results</h2>", web)+22
    pocetvysl <- grep("table_container", web)
    if (length(pocetvysl)>1) {pocetvysl <- round(((pocetvysl[2] - pocetvysl[1])-25)/12)} else {pocetvysl <- 1}
    
    for(i in 1:pocetvysl) {
      
      hry <- web[indexvysl+12*(i-1)]
      hry <- sub(".*\">", '', hry)
      hry <- sub("</a>.*", "", hry)
      
      udalost <- web[indexvysl+4+12*(i-1)]
      udalost <- sub(".*\">", '', udalost)
      udalost <- sub("</a>.*", "", udalost)
      
      tym <- web[indexvysl+5+12*(i-1)]
      tym <- sub(".*\" >", '', tym)
      tym <- sub("</td>", "", tym)
      
      poradi <- web[indexvysl+7+12*(i-1)]
      poradi <- sub(".*\">", '', poradi)
      poradi <- sub("</td>", "", poradi)
      
      medaile <- web[indexvysl+8+12*(i-1)]
      medaile <- sub(".*<strong>", '', medaile)
      medaile <- sub("</strong>.*", "", medaile)
      
      detail <- web[indexvysl+9+12*(i-1)]
      detail <- sub(".*\" >", '', detail)
      detail <- sub("</td>", "", detail)
      
      writeLines(paste(hry, udalost, tym, poradi, medaile, detail, sep='|'), soubor, sep="|")
      
    }
  
    writeLines("", soubor)
    print(paste(j, " - ", round(j/1267.97, 2), " % - ", jmeno, ".", sep=""))
    
  }
  
  closeAllConnections()
   
 }