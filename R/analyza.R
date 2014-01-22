df <- read.csv(file="vyskavaha.csv", header=F, sep="|", quote = "")

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

df.cs <- df[df$stat=="Czechoslovakia",]
df.cz <- df[df$stat=="Czech Republic",]

write.table(df.cs, file="sportovciCeskoslovensko.csv", sep="|", quote=F)
write.table(df.cz, file="sportovciCesko.csv", sep="|", quote=F)