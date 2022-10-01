setwd("Flask")
library(lme4)
library(ggeffects)
P1<-read.csv("data_P1_final.csv")
P2<-read.csv("data_P2_final.csv")

P1<-P1[!P1$Target=="Hello World",]
P1<-P1[!P1$Target=="New Game",]

P2<-P2[!P2$Target=="Hello World",]
P2<-P2[!P2$Target=="New Game",]

get_sum_differences <- function(data) {
  new_data<-c()
  prev_val <-0 
  for(val in data) {
    if(prev_val != 0){
      dif <- val-prev_val
      new_data<-append(new_data,abs(dif))
    } else{
      new_data<-append(new_data,0)
    }
    prev_val<-val
  }
  return(new_data)
}


get_differences <- function(data) {
  game <-data$Game[1]
  axis<-c()
  newaxis<-c()
  for(i in 1:nrow(data)){
    if(game == data$Game[i]){
      axis<-append(axis,data$Z[i])
      game <-data$Game[i]
    } else {
      newaxis<-append(newaxis,get_sum_differences(axis))
      axis<-c()
      game <-data$Game[i]
      axis<-append(axis,data$Z[i])
    }
  }
  newaxis<-append(newaxis,get_sum_differences(axis))
  return(newaxis)
}

get_differences2 <- function(data) {
  game <-data$Game[1]
  axis<-c()
  newaxis<-c()
  for(i in 1:nrow(data)){
    if(game == data$Game[i]){
      axis<-append(axis,data$X[i])
      game <-data$Game[i]
    } else {
      newaxis<-append(newaxis,get_sum_differences(axis))
      axis<-c()
      game <-data$Game[i]
      axis<-append(axis,data$X[i])
    }
  }
  newaxis<-append(newaxis,get_sum_differences(axis))
  return(newaxis)
}




get_sum<- function(data) {
  game <-data$Game[1]
  axis<-c()
  newaxis<-c()
  games <-c()
  for(i in 1:nrow(data)){
    if(game == data$Game[i]){
      axis<-append(axis,data$Zdif[i])
      game <-data$Game[i]
    } else {
      newaxis<-append(newaxis,sum(axis))
      axis<-c()
      games<-append(games,game)
      game <-data$Game[i]
      axis<-append(axis,data$Zdif[i])
     
    }
  }
  newaxis<-append(newaxis,sum(axis))
  games<-append(games,game)
  return(data.frame(newaxis,games))
}

get_sum2<- function(data) {
  game <-data$Game[1]
  axis<-c()
  newaxis<-c()
  games <-c()
  for(i in 1:nrow(data)){
    if(game == data$Game[i]){
      axis<-append(axis,data$Xdif[i])
      game <-data$Game[i]
    } else {
      newaxis<-append(newaxis,sum(axis))
      axis<-c()
      games<-append(games,game)
      game <-data$Game[i]
      axis<-append(axis,data$Xdif[i])
      
    }
  }
  newaxis<-append(newaxis,sum(axis))
  games<-append(games,game)
  return(data.frame(newaxis,games))
}

P1$Zdif <-get_differences(P1)

P2$Zdif <-get_differences(P2)

P1$Xdif <-get_differences2(P1)

P2$Xdif <-get_differences2(P2)


P1_z<-get_sum(P1)
P1_x<-get_sum2(P1)

P1_sd<-read.csv("data_P1_SD.csv")
P1_sd<-P1_sd[!P1_sd$Target=="Hello World",]
P1_sd$Zdif<-P1_z$newaxis
P1_sd$Xdif<-P1_x$newaxis

#checks
P1$Z[3]-P1$Z[2]
P1$Zdif[3]

P1$X[2]-P1$X[1]
P1$Xdif[2]

sum(P1$Zdif[P1$Pair==1&P1$Game==1]) == P1_sd$Zdif[1]
sum(P1$Zdif[P1$Pair==25 &P1$Game==43]) == P1_sd$Zdif[1402]

sum(P1$Xdif[P1$Pair==1&P1$Game==1]) == P1_sd$Xdif[1]
sum(P1$Xdif[P1$Pair==25 &P1$Game==43]) == P1_sd$Xdif[1402]

P2_z<-get_sum(P2)
P2_x<-get_sum2(P2)

P2_sd<-read.csv("data_P2_SD.csv")
P2_sd<-P2_sd[!P2_sd$Target=="Hello World",]
P2_sd$Zdif<-P2_z$newaxis
P2_sd$Xdif<-P2_x$newaxis
#checks
P2$Z[3]-P2$Z[2]
P2$Zdif[3]

P2$X[2]-P2$X[1]
P2$Xdif[2]

sum(P2$Zdif[P2$Pair==1&P2$Game==1]) == P2_sd$Zdif[1]
sum(P2$Zdif[P2$Pair==25 &P2$Game==43]) == P2_sd$Zdif[1402]

sum(P2$Xdif[P2$Pair==1&P2$Game==1]) == P2_sd$Xdif[1]
sum(P2$Xdif[P2$Pair==25 &P2$Game==43]) == P2_sd$Xdif[1402]

P1_sd$Xratio<-P1_sd$Xdif/P1_sd$Zdif
P1_sd$Zratio<-P1_sd$Zdif/P1_sd$Xdif

P2_sd$Xratio<-P2_sd$Xdif/P2_sd$Zdif
P2_sd$Zratio<-P2_sd$Zdif/P2_sd$Xdif

write.csv(P1_sd,"Data_Ratio1.csv", row.names = FALSE)
write.csv(P2_sd,"Data_Ratio2.csv", row.names = FALSE)




