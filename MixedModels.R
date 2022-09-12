setwd("Flask")
library(lme4)
P1<-read.csv("data_P1_TpR.csv")
P2<-read.csv("data_P2_TpR.csv")

P1_sd<-read.csv("data_P1_SD.csv")

P2_sd<-read.csv("data_P2_SD.csv")
P2_sd$Time <- P2$Time

success <- as.numeric(P2_sd$Success)
condition<-as.factor(P2_sd$Condtion)
TIME <-round(P2_sd$Time/1000)
PAIR <- as.factor(P2_sd$Pair)
TARGET<- as.factor(P2_sd$Target)
IsIntroducer <-as.factor(P2_sd$Introducer)
sdz<-P2_sd$Z

TIME2 <- round(P2_sd$Time/1000)


TIME2[as.numeric(TIME2) < 10] ="under 10sec"
TIME2[as.numeric(TIME2) < 20] ="under 20sec"
TIME2[as.numeric(TIME2) < 30] ="under 30sec"
TIME2[as.numeric(TIME2) < 40] ="under 40sec"
TIME2[as.numeric(TIME2) < 50] ="under 50sec"
TIME2[as.numeric(TIME2) < 60] ="under 60sec"
TIME2[as.numeric(TIME2) > 59] ="over 60sec"

TIME2<-as.factor(TIME2)

model4 = glmer( success ~ condition * TIME + (condition*TIME|PAIR) + (condition *TIME| TARGET), control = glmerControl(optimizer ='optimx', optCtrl=list(method='nlminb')), family = binomial())
model3 = glmer( success ~ condition + TIME + (condition+TIME|PAIR) + (condition +TIME| TARGET), control = glmerControl(optimizer ="Nelder_Mead"),  family = binomial())
model2B = glmer( success ~ condition + (condition|PAIR) + (condition|TARGET), family = binomial(), control = glmerControl(optimizer ="Nelder_Mead"))
model2 = glmer( success ~ TIME + (TIME|PAIR) + (TIME|TARGET),family = binomial(), control = glmerControl(optimizer ='optimx', optCtrl=list(method='nlminb')))
model1 = glmer( success ~ 1  + (1|PAIR) + (1| TARGET),family = binomial(), control = glmerControl(optimizer ='optimx', optCtrl=list(method='nlminb')))
AIC(model1,model2,model2B,model3,model4)

P <- rbind(P2_sd,P1_sd)
P <- P[P$Condtion=="modified",]
success <- as.numeric(P$Success)
condition<-as.factor(P$Condtion)
TIME <-round(P$Time/1000)
PAIR <- as.factor(P$Pair)
TARGET<- as.factor(P$Target)
IsIntroducer <-as.factor(P$Introducer)
PARTICIPANT <- as.factor(P$Participant)
sdz<-P$Z

lmodel2 =  lmer (sdz ~   IsIntroducer + (IsIntroducer|PAIR) + (1 | PARTICIPANT) + (IsIntroducer|TARGET)   )
lmodel =  lmer (sdz ~   1 + (1|PAIR) + (1 | PARTICIPANT) + (1|TARGET))

