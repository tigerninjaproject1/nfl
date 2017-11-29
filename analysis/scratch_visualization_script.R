words <- c("Bluemix Storage", "Data Size", "Database Server", "Database Version", "Database Location", "Cloud Hosting Service", "Processors", "Memory") 
numbers <- c("1GB", "14.3MB", "Compose for MongoDB-jj", "3.2.11", "US South", "IBM Bluemix", "1 x 2.0 GHz Cores", "1GB RAM")
specs <- data.frame("Bluemix Technical Specifications"= words, "Specifications"=numbers)

library(ggplot2)
alldata <- alldata[alldata$posteam != NA]
sp1 <- ggplot(data = alldata, aes(x=as.numeric(PosTeamScore), 
                                  y=posteam, 
                                  size = Yards))
sp1 + 
  geom_point() + 
  scale_size(range = c(-30, 10)) + 
  xlab("Score")


bygame <- alldata %>%
  group_by_at(vars(posteam, GameID)) %>%
  summarize(TDgameSum = sum(Touchdown),
            avgYdsPerGamePerTeam = mean(Yards$Gained),
            sdYdsPerGamePerTeam = sd(Yards$Gained))
head(bygame)

p1 <- ggplot(data = bygame, aes(TDgameSum, avgYdsPerGamePerTeam, size=sdYdsPerGamePerTeam))
p1 + geom_point() + scale_size(range = c(-5, 5))

bp1 <- ggplot(data = bygame, aes(posteam, x = posteam, y = avgYdsPerGamePerTeam))
bp1 + geom_boxplot()
