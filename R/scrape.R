require(devtools)
require(rJava)
require(seleniumJars)
require(relenium)
require(XML)

#inicializuj proměnné pro zápis dat
rok <- character()
sport <- character()
disciplina <- character()
medaile <- character()
jmena <- character()
stat <- character()
vysledek <- character()


#medaile
hodnoty  <- c("zlato", "stříbro", "bronz")

#roky konání zimních olympijských her
roky  <- c("2010", "2006", "2002", "1998", "1994", "1992", "1988", "1984", "1980", "1976", "1972", "1968", "1964", "1960", "1956", "1952", "1948", "1936", "1932", "1928", "1924")
firefox <- firefoxClass$new()

for (i in roky) {
  url  <- paste("http://www.olympic.org/content/results-and-medalists/eventresultpagegeneral/?athletename=&country=&sport2=&games2=", i, "%2F2&event2=&mengender=true&womengender=true&mixedgender=true&goldmedal=true&silvermedal=true&bronzemedal=true&worldrecord=true&olympicrecord=true&teamclassification=true&individualclassification=true&winter=true&summer=true", sep="")  
  firefox$get(url)  
  
  #zavři anketu
  closeElement  <- firefox$findElementById("PopinClose")
  closeElement$click()
  
  #přejdi na další stránku s výsledky
  
  repeat {
    dalsiElement  <- firefox$findElementByLinkText(">")
    if (is.null(dalsiElement)) {break}
      # extrahuj data
      radkyElement  <- firefox$findElementsByClassName("rowresults")
      for (j in 1:length(radkyElement)) {
        currentSport  <- radkyElement[[j]]$findElementByClassName("sport")$getText()
        currentDisciplina  <- radkyElement[[j]]$findElementByClassName("event")$getText()
        for (k in 1:length(radkyElement[[j]]$findElementsByClassName("name"))) {
          rok  <- append(rok, i)
          sport  <- append(sport, currentSport)
          disciplina  <- append(disciplina, currentDisciplina)
          medaile  <- append(medaile, hodnoty[k])
          jmena <- append(jmena, radkyElement[[j]]$findElementsByClassName("name")[[k]]$getText())
          stat  <- append(stat, radkyElement[[j]]$findElementsByClassName("country")[[k]]$getText())
          vysledek  <- append(vysledek, radkyElement[[j]]$findElementsByClassName("time")[[k]]$getText())
        }  
      }
    print(i)    
    dalsiURL  <- dalsiElement$getAttribute("href")
    firefox$get(dalsiURL)
  }
}


firefox$close()



