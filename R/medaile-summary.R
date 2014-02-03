<<<<<<< HEAD
require(dplyr)

d  <- read.csv("../data/medailiste.csv")

head(d)

# medaile podle statu

d_df  <- tbl_df(d)
staty  <- group_by(d_df, stat)
medaile  <- group_by(d_df, stat, medaile)

write.csv(arrange(summarise(staty,
                            count=n()), desc(count)), "../data/staty-medaile.csv")

write.csv(summarise(medaile, celkem=n()), "../data/staty-medaile-detail.csv")

medaile.podrobne  <- summarise(medaile, celkem=n())

medaile.podrobne  <- ungroup(medaile.podrobne)

medaile.podrobne

filter(d_df, stat=="")

# dplyr demo
     
vignette("introduction", package = "dplyr")
dim(hflights)
head(hflights)

hflights_df  <- tbl_df(hflights)

=======
require(dplyr)

d  <- read.csv("../data/medailiste.csv")

head(d)

# medaile podle statu

d_df  <- tbl_df(d)
staty  <- group_by(d_df, stat)
medaile  <- group_by(d_df, stat, medaile)
roky  <- group_by(d_df, rok)
jednotlivci  <- group_by(d_df, jmena)



write.csv(arrange(summarise(staty,
                            count=n()), desc(count)), "../data/staty-medaile.csv")

write.csv(summarise(medaile, celkem=n()), "../data/staty-medaile-detail.csv")

write.csv(summarise(roky, celkem=n()), "../data/roky-medaile.csv")

write.csv(head(arrange(summarise(jednotlivci, count=n()),desc(count)),100), "../data/jednotlivci-medaile.csv")


# dplyr demo
     
vignette("introduction", package = "dplyr")
dim(hflights)
head(hflights)

hflights_df  <- tbl_df(hflights)

>>>>>>> mapa korupce
filter(hflights_df, Month == 1, DayofMonth == 1)