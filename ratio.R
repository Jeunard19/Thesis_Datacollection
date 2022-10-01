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
      print("hello")
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

differences <-get_differences(P1)
P1$Zdif <-get_differences(P1)

