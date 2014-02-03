df <- read.csv(file="../data/vyskavaha.csv", header=T, sep="|", quote = "")

# vyčistit a pojmenovat datové typy

colnames(df) <- c("jmeno", "prezdivka", "pohlavi", "vyska", "vaha", "narozeni", "umrti", "klub", "stat", "sport", 
            "hry1", "udalost1", "tym1", "poradi1", "medaile1", "detail1",
            "hry2", "udalost2", "tym2", "poradi2", "medaile2", "detail2",
            "hry3", "udalost3", "tym3", "poradi3", "medaile3", "detail3",
            "hry4", "udalost4", "tym4", "poradi4", "medaile4", "detail4",
            "hry5", "udalost5", "tym5", "poradi5", "medaile5", "detail5",
            "hry6", "udalost6", "tym6", "poradi6", "medaile6", "detail6",
            "hry7", "udalost7", "tym7", "poradi7", "medaile7", "detail7",
            "hry8", "udalost8", "tym8", "poradi8", "medaile8", "detail8",
            "hry9", "udalost9", "tym9", "poradi9", "medaile9", "detail9",
            "hry10", "udalost10", "tym10", "poradi10", "medaile10", "detail10",
            "hry11", "udalost11", "tym11", "poradi11", "medaile11", "detail11",
            "hry12", "udalost12", "tym12", "poradi12", "medaile12", "detail12",
            "hry13", "udalost13", "tym13", "poradi13", "medaile13", "detail13",
            "hry14", "udalost14", "tym14", "poradi14", "medaile14", "detail14",
            "hry15", "udalost15", "tym15", "poradi15", "medaile15", "detail15",
            "hry16", "udalost16", "tym16", "poradi16", "medaile16", "detail16",
            "hry17", "udalost17", "tym17", "poradi17", "medaile17", "detail17",
            "hry18", "udalost18", "tym18", "poradi18", "medaile18", "detail18",
            "hry19", "udalost19", "tym19", "poradi19", "medaile19", "detail19",
            "hry20", "udalost20", "tym20", "poradi20", "medaile20", "detail20",
            "hry21", "udalost21", "tym21", "poradi21", "medaile21", "detail21",
            "hry22", "udalost22", "tym22", "poradi22", "medaile22", "detail22",
            "hry23", "udalost23", "tym23", "poradi23", "medaile23", "detail23",
            "hry24", "udalost24", "tym24", "poradi24") 

df <- df[-17069,]
df <- df[-111970,]
df <- df[-111968,]
df <- df[-68637,]
df <- df[-24529,]
df <- df[-42019,]
df <- df[-69805,]
df <- df[-72794,]
df <- df[-83990,]
df <- df[-49884,]
df <- df[-51601,]
df <- df[-74496,]
df <- df[-99459,]
df <- df[-71578,]
df <- df[-99323,]
df <- df[-107983,]
df <- df[-83459,]
df <- df[-112387,]
df <- df[-120936,]
df <- df[-124733,]
df <- df[-20039,]
df <- df[-85951,]
df <- df[-72790,]
df$vaha[125741] <- NA
df <- df[-61697,]
df <- df[-35446,]

for(i in 11:50) {df[95711,i] <- df[95711,i+10]}
df$hry1[95711] <- "1952 Summer"
for(i in 11:50) {df[31294,i] <- df[31294,i+10]}
df$hry1[31294] <- "1988 Summer"
for(i in 11:90) {df[121162,i] <- df[121162,i+10]}
df$hry1[121162] <- "1984 Winter"
for(i in 11:50) {df[125001,i] <- df[125001,i+10]}
df$hry1[125001] <- "1932 Summer"
for(i in 11:50) {df[82327,i] <- df[82327,i+10]}
df$hry1[82327] <- "1964 Summer"
for(i in 11:60) {df[17454,i] <- df[17454,i+10]}
df$hry1[17454] <- "1928 Summer"
for(i in 11:90) {df[108919,i] <- df[108919,i+10]}
df$hry1[108919] <- "1988 Summer"
for(i in 11:50) {df[106212,i] <- df[106212,i+10]}
df$hry1[106212] <- "1948 Summer"

df.zaloha <- df

df$narozeni <- as.Date(df$narozeni)
df$umrti <- as.Date(df$umrti)

df$narozeni <- sub(".*</span> ", "", df$narozeni)
df$narozeni <- sub(" in.*", "", df$narozeni)
df$narozeni <- sub("\"", "", df$narozeni)

df$umrti <- sub("<br>.*", "", df$umrti)
df$umrti <- sub("\"", "", df$umrti)

df$vyska <- sub(".*\" .", "", df$vyska)
df$vyska <- sub(" cm.*", "", df$vyska)

df$vaha <- sub(".*lbs .", "", df$vaha)
df$vaha <- sub(" kg.", "", df$vaha)
df$vaha <- sub(" kg", "", df$vaha)

df$jmeno <- as.character(df$jmeno)
df$prezdivka <- as.character(df$prezdivka)
df$klub <- as.character(df$klub)
df$stat <- as.character(df$stat)
df$sport <- as.character(df$sport)
df$vyska <- as.numeric(as.character((df$vyska)))
df$vaha <- as.numeric(as.character((df$vaha)))
df$pohlavi <- sub("Male", "T", df$pohlavi)
df$pohlavi <- sub("Female", "F", df$pohlavi)
df$pohlavi <- as.logical(df$pohlavi)
df$stat <- sub("<br><span class=", "", df$stat)
df$sport <- sub("Sport:</span> ", "", df$sport)
for(i in 1:24) {df[,5+6*i] <- sub("1956 Equestrian", "1956 Summer", df[,5+6*i])}

df.zaloha <- df

for(i in 1:24) {
  
  df[,152+i] <- df[,5+6*i]
  colnames(df)[152+i] <- paste("datum", i, sep="")
  df[,152+i] <- sub("1896 Summer", "1896-04-06", df[,152+i])
  df[,152+i] <- sub("1900 Summer", "1900-05-14", df[,152+i])
  df[,152+i] <- sub("1904 Summer", "1904-07-01", df[,152+i])
  df[,152+i] <- sub("1906 Summer", "1906-04-22", df[,152+i])
  df[,152+i] <- sub("1908 Summer", "1908-04-27", df[,152+i])
  df[,152+i] <- sub("1912 Summer", "1912-05-05", df[,152+i])
  df[,152+i] <- sub("1920 Summer", "1920-04-20", df[,152+i])
  df[,152+i] <- sub("1924 Summer", "1924-05-04", df[,152+i])
  df[,152+i] <- sub("1928 Summer", "1928-05-17", df[,152+i])
  df[,152+i] <- sub("1932 Summer", "1932-07-30", df[,152+i])
  df[,152+i] <- sub("1936 Summer", "1936-08-01", df[,152+i])
  df[,152+i] <- sub("1948 Summer", "1948-07-29", df[,152+i])
  df[,152+i] <- sub("1952 Summer", "1952-07-19", df[,152+i])
  df[,152+i] <- sub("1956 Summer", "1956-11-22", df[,152+i])
  df[,152+i] <- sub("1960 Summer", "1960-08-25", df[,152+i])
  df[,152+i] <- sub("1964 Summer", "1964-10-10", df[,152+i])
  df[,152+i] <- sub("1968 Summer", "1968-10-12", df[,152+i])
  df[,152+i] <- sub("1972 Summer", "1972-08-26", df[,152+i])
  df[,152+i] <- sub("1976 Summer", "1976-07-17", df[,152+i])
  df[,152+i] <- sub("1980 Summer", "1980-07-19", df[,152+i])
  df[,152+i] <- sub("1984 Summer", "1984-07-28", df[,152+i])
  df[,152+i] <- sub("1988 Summer", "1988-09-17", df[,152+i])
  df[,152+i] <- sub("1992 Summer", "1992-07-25", df[,152+i])
  df[,152+i] <- sub("1996 Summer", "1996-07-19", df[,152+i])
  df[,152+i] <- sub("2000 Summer", "2000-09-15", df[,152+i])
  df[,152+i] <- sub("2004 Summer", "2004-08-13", df[,152+i])
  df[,152+i] <- sub("2008 Summer", "2008-08-08", df[,152+i])
  df[,152+i] <- sub("2012 Summer", "2012-07-27", df[,152+i])  
  df[,152+i] <- sub("1924 Winter", "1924-01-25", df[,152+i])
  df[,152+i] <- sub("1928 Winter", "1928-02-11", df[,152+i])
  df[,152+i] <- sub("1932 Winter", "1932-02-04", df[,152+i])
  df[,152+i] <- sub("1936 Winter", "1936-02-06", df[,152+i])
  df[,152+i] <- sub("1948 Winter", "1948-01-30", df[,152+i])
  df[,152+i] <- sub("1952 Winter", "1952-02-14", df[,152+i])
  df[,152+i] <- sub("1956 Winter", "1956-01-26", df[,152+i])
  df[,152+i] <- sub("1960 Winter", "1960-02-18", df[,152+i])
  df[,152+i] <- sub("1964 Winter", "1964-01-29", df[,152+i])
  df[,152+i] <- sub("1968 Winter", "1968-02-06", df[,152+i])
  df[,152+i] <- sub("1972 Winter", "1972-02-03", df[,152+i])
  df[,152+i] <- sub("1976 Winter", "1976-02-04", df[,152+i])
  df[,152+i] <- sub("1980 Winter", "1980-02-12", df[,152+i])
  df[,152+i] <- sub("1984 Winter", "1984-02-07", df[,152+i])
  df[,152+i] <- sub("1988 Winter", "1988-02-13", df[,152+i])
  df[,152+i] <- sub("1992 Winter", "1992-02-08", df[,152+i])
  df[,152+i] <- sub("1994 Winter", "1994-02-12", df[,152+i])
  df[,152+i] <- sub("1998 Winter", "1998-02-07", df[,152+i])
  df[,152+i] <- sub("2002 Winter", "2002-02-08", df[,152+i])
  df[,152+i] <- sub("2006 Winter", "2006-02-10", df[,152+i])
  df[,152+i] <- sub("2010 Winter", "2010-02-12", df[,152+i])
  df[,152+i] <- as.Date(df[,152+i], format="%Y-%m-%d")
  print(paste("To byla moje ",i, ". olympiáda.", sep=""))
}

for(i in 1:24) {
  
  df[,176+i] <- round(as.numeric(df[,152+i] - df$narozeni)/365.25, 2)
  colnames(df)[176+i] <- paste("vek", i, sep="")
  print(paste("Jó, na své ",i, ". olympiádě, to jsem byl ještě mladej vocas.", sep=""))
  
}

df.zimni <- data.frame()
for(i in 1:24) {
  df.ted <- df[grep("Winter", df[,5+6*i], fixed=T),]
  df.zimni <- rbind(df.zimni, df.ted)
}
df.zimni <- unique(df.zimni)

df.letni <- data.frame()
for(i in 1:24) {
  df.ted <- df[grep("Summer", df[,5+6*i], fixed=T),]
  df.letni <- rbind(df.letni, df.ted)
}
df.letni <- unique(df.letni)

rm(df.ted)

df.zaloha <- df

write.table(df, file="vyskavahafinal.csv", sep="|", quote=F)

# skoky pro Adama

df.skoky <- df[df$sport == "Ski Jumping",] 
write.csv(df.skoky, file="skokani.csv")

###########
# analýza #
###########

# extrémy (jen pro zimní hry)

df.muzi <- df.zimni[df.zimni$pohlavi,]
df.zeny <- df.zimni[!df.zimni$pohlavi,]

nejmensi.muz <- df.muzi[df.muzi$vyska == min(df.muzi$vyska, na.rm=T),]
nejmensi.muz <- nejmensi.muz[complete.cases(nejmensi.muz$jmeno),]
nejmensi.zena <- df.zeny[df.zeny$vyska == min(df.zeny$vyska, na.rm=T),]
nejmensi.zena <- nejmensi.zena[complete.cases(nejmensi.zena$jmeno),]
nejvyssi.muz <- df.muzi[df.muzi$vyska == max(df.muzi$vyska, na.rm=T),]
nejvyssi.muz <- nejvyssi.muz[complete.cases(nejvyssi.muz$jmeno),]
nejvyssi.zena <- df.zeny[df.zeny$vyska == max(df.zeny$vyska, na.rm=T),]
nejvyssi.zena <- nejvyssi.zena[complete.cases(nejvyssi.zena$jmeno),]
nejlehci.muz <- df.muzi[df.muzi$vaha == min(df.muzi$vaha, na.rm=T),]
nejlehci.muz <- nejlehci.muz[complete.cases(nejlehci.muz$jmeno),]
nejlehci.zena <- df.zeny[df.zeny$vaha == min(df.zeny$vaha, na.rm=T),]
nejlehci.zena <- nejlehci.zena[complete.cases(nejlehci.zena$jmeno),]
nejtezsi.muz <- df.muzi[df.muzi$vaha == max(df.muzi$vaha, na.rm=T),]
nejtezsi.muz <- nejtezsi.muz[complete.cases(nejtezsi.muz$jmeno),]
nejtezsi.zena <- df.zeny[df.zeny$vaha == max(df.zeny$vaha, na.rm=T),]
nejtezsi.zena <- nejtezsi.zena[complete.cases(nejtezsi.zena$jmeno),]
nejmladsi.muz <- df.muzi[df.muzi$vek1 == min(df.muzi$vek1, na.rm=T),]
nejmladsi.muz <- nejmladsi.muz[complete.cases(nejmladsi.muz$jmeno),]
nejmladsi.zena <- df.zeny[df.zeny$vek1 == min(df.zeny$vek1, na.rm=T),]
nejmladsi.zena <- nejmladsi.zena[complete.cases(nejmladsi.zena$jmeno),]

nejstarsi.muz <- df.muzi[1,]  
nejvyssi.vek <- df.muzi[1,177]
for (i in 1:24) {
  df.muzi <- df.muzi[df.muzi[10+6*i] != "hors concours",] 
  nejstarsi.muz.ted <- df.muzi[df.muzi[,176+i] == max(df.muzi[,176+i], na.rm=T),]
  nejstarsi.muz.ted <- nejstarsi.muz.ted[complete.cases(nejstarsi.muz.ted$jmeno),]
  if (unique(nejstarsi.muz.ted[176+i]) > unique(nejvyssi.vek)) {
    nejstarsi.muz <- nejstarsi.muz.ted
    nejvyssi.vek <- nejstarsi.muz.ted[176+i]
  }
  print(paste("Jó, na své ",i, ". olympiádě, to jsem už byl skoro na umření.", sep=""))
}  
nejstarsi.zena <- df.zeny[1,]  
nejvyssi.vek <- df.zeny[1,177]
for (i in 1:24) {
  nejstarsi.zena.ted <- df.zeny[df.zeny[,176+i] == max(df.zeny[,176+i], na.rm=T),]
  nejstarsi.zena.ted <- nejstarsi.zena.ted[complete.cases(nejstarsi.zena.ted$jmeno),]
  if (unique(nejstarsi.zena.ted[176+i]) > unique(nejvyssi.vek)) {
    nejstarsi.zena <- nejstarsi.zena.ted
    nejvyssi.vek <- nejstarsi.zena.ted[176+i]
  }
  print(paste("Jó, na své ",i, ". olympiádě, to jsem už byla skoro na umření.", sep=""))
}
rm(nejlehci.muz); rm(nejlehci.zena); rm(nejtezsi.muz); rm(nejtezsi.zena); rm(nejmensi.muz); rm(nejmensi.zena); rm(nejvyssi.muz); rm(nejvyssi.zena); rm(nejstarsi.muz); rm(nejmladsi.muz); rm(nejstarsi.zena); rm(nejmladsi.zena); rm(nejstarsi.muz.ted); rm(nejstarsi.zena.ted); rm(nejvyssi.vek); rm(i); rm(df.muzi); rm(df.zeny)


# samostatné soubory pro Česko/Československo

df.cs <- df[df$stat=="Czechoslovakia",]
df.cz <- df[df$stat=="Czech Republic",]

write.table(df.cs, file="sportovciCeskoslovensko.csv", sep="|", quote=F)
write.table(df.cz, file="sportovciCesko.csv", sep="|", quote=F)