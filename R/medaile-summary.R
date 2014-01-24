require(dplyr)

d  <- read.csv("../data/medailiste.csv")

head(d)

# wrapper for dplyr

d_df  <- tbl_df(d)

filter(d_df, stat=="CZE")

staty  <- group_by(d_df, stat)


write.csv(arrange(summarise(staty, count=n()), desc(count)), "../data/staty-medaile.csv")


# dplyr demo
     
vignette("introduction", package = "dplyr")
dim(hflights)
head(hflights)

hflights_df  <- tbl_df(hflights)

filter(hflights_df, Month == 1, DayofMonth == 1)