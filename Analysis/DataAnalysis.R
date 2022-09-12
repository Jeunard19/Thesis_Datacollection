setwd("Flask")
library(reshape2)
library(ggplot2)
P1<-read.csv("data_P1_TpR.csv")

P2<-read.csv("data_P2_TpR.csv")

head(P1)
head(P2)

P1_normal <- P1[P1$Condtion=="normal",]
P1_modified<- P1[P1$Condtion=="modified",]

P2_normal <- P2[P2$Condtion=="normal",]
P2_modified<- P2[P2$Condtion=="modified",]


normal<-P1_normal$Time
modified<-P1_modified$Time

ggplot(data=P1, aes(x=Game, y=Time, color=Condtion)) +
  geom_point(position=position_dodge(width=0.3))+geom_smooth(method = "loess", se = TRUE)


ggplot(data=P1_normal, aes(x=Game, y=Time, color=Condtion)) +
  geom_point(position=position_dodge(width=0.3))

ggplot(data=P1_modified, aes(x=Game, y=Time, color=Condtion)) +
  geom_point(position=position_dodge(width=0.3))




# SD
P1_sd<-read.csv("data_P1_SD.csv")

P2_sd<-read.csv("data_P2_SD.csv")

head(P1_sd)
head(P2_sd)

P_sd = rbind(P1_sd, P2_sd)
P_sd = P_sd[P_sd$Role == "director",]
ggplot(data=P_sd, aes(x=Game, y=X, color=Condtion)) +
  geom_point(position=position_dodge(width=0.3))+geom_smooth(method = "loess", se = TRUE)

ggplot(data=P_sd, aes(x=Game, y=Y, color=Condtion)) +
  geom_point(position=position_dodge(width=0.3))+geom_smooth(method = "loess", se = TRUE)


ggplot(data=P_sd, aes(x=Game, y=Z, color=Condtion)) +
  geom_point(position=position_dodge(width=0.3))+geom_smooth(method = "loess", se = TRUE)



ggplot(data=P2_sd, aes(x=Game, y=Succes, color=Condtion)) +
  geom_point(position=position_dodge(width=0.3))

P2_sd_norm = P_sd[P_sd$Condtion == "normal",]
P2_sd_nmod = P_sd[P_sd$Condtion == "modified",]

P2_sd_norm$Succes <- as.factor(P2_sd_norm$Succes )
P2_sd_nmod$Succes <- as.factor(P2_sd_nmod$Succes )



cdplot(Succes ~ Game, data=P2_sd_nmod)
  cdplot(Succes ~ Game, data=P2_sd_norm)

library(beeswarm)
Game <- P2_sd_nmod$Game 
Succes <- P2_sd_nmod$Succes
beeswarm(Game~ Succes,
         pch = 19)



