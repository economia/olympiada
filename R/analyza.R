df <- read.csv(file="../data/vyskavaha.csv", header=F, sep="|", quote = "")

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

df <- df[-1,]
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

# pojmenovat datové typy

str(df)
df$narozeni <- as.Date(df$narozeni)
df$umrti <- as.Date(df$umrti)
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
df$hry1 <- sub("1956 Equestrian", "1956 Summer", df$hry1)

levels(factor(df$hry1))
df[df$hry1 == "John Benevides Souza (Sousa-)",]
df[106212,]


# samostatné soubory pro Česko/Československo

df.cs <- df[df$stat=="Czechoslovakia",]
df.cz <- df[df$stat=="Czech Republic",]

write.table(df.cs, file="sportovciCeskoslovensko.csv", sep="|", quote=F)
write.table(df.cz, file="sportovciCesko.csv", sep="|", quote=F)