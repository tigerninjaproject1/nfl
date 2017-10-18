setwd("~/Documents/smu/Databases-7330-404/term paper/")

nflfile <- "./data/NFLPlaybyPlay2015.csv"

nfl <- read.csv(nflfile, stringsAsFactors = FALSE)

gained <- nfl$Yards.Gained
togo <- nfl$ydstogo

library(dplyr)

nfl2 <- nfl %>% 
  group_by(posteam)  %>%
  summarize(mean_yards = mean(Yards.Gained), 
            sd_yards=sd(Yards.Gained), 
            mean_penalties = mean(Penalty.Yards),
            sd_penalties = sd(Penalty.Yards),
            sumtd = sum(Touchdown)) 
nfl2 <- nfl2[2:dim(nfl2)[1],]

library(ggplot2)
p1 <- ggplot(data=nfl2, aes(x=mean_yards, size=sd_yards, color=mean_penalties, label=posteam, y=sumtd)) + 
  geom_point() +
  geom_label()
p1