setwd("Flask")
library(lme4)
library(ggeffects)
P1<-read.csv("data_P1_selec.csv")
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
GAME<- P2_sd$Game
sdz<-P2_sd$Z
sdx<-P2_sd$X
sdy<-P2_sd$Y

TIME2 <- round(P2_sd$Time/1000)


TIME2[as.numeric(TIME2) < 10] ="under 10sec"
TIME2[as.numeric(TIME2) < 20] ="under 20sec"
TIME2[as.numeric(TIME2) < 30] ="under 30sec"
TIME2[as.numeric(TIME2) < 40] ="under 40sec"
TIME2[as.numeric(TIME2) < 50] ="under 50sec"
TIME2[as.numeric(TIME2) < 60] ="under 60sec"
TIME2[as.numeric(TIME2) > 59] ="over 60sec"

TIME2<-as.factor(TIME2)
model9 = glmer( success ~ IsIntroducer+TIME + (IsIntroducer+TIME|PAIR) + (IsIntroducer+TIME|TARGET),family = binomial(link = "logit"),control = glmerControl(optimizer ='optimx', optCtrl=list(method='nlminb')))
model8 = glmer( success ~ IsIntroducer + (IsIntroducer|PAIR) + (IsIntroducer|TARGET),family = binomial(link = "logit"),control = glmerControl(optimizer ='optimx', optCtrl=list(method='nlminb')))
model8 = glmer( success ~ IsIntroducer+condition + (IsIntroducer+condition|PAIR) + (IsIntroducer+condition|TARGET),family = binomial(link = "logit"))


model7 = glmer( success ~ GAME*TIME + (GAME*TIME|PAIR) + (GAME*TIME|TARGET),family = binomial(link = "logit"),control = glmerControl(optimizer ='optimx', optCtrl=list(method='nlminb')))
model6 = glmer( success ~ GAME+TIME + (GAME+TIME|PAIR) + (GAME+TIME|TARGET),family = binomial(link = "logit"))
model5 = glmer( success ~ GAME + (GAME|PAIR) + (GAME|TARGET),family = binomial(link = "logit"))
model4 = glmer( success ~ condition * TIME + (condition*TIME|PAIR) + (condition *TIME| TARGET), control = glmerControl(optimizer ='optimx', optCtrl=list(method='nlminb')), family = binomial(link = "logit"))
model3 = glmer( success ~ condition + TIME + (condition+TIME|PAIR) + (condition +TIME| TARGET), control = glmerControl(optimizer ='optimx', optCtrl=list(method='nlminb')),  family = binomial(link = "logit"))
model2B = glmer( success ~ condition + (condition|PAIR) + (condition|TARGET), family = binomial(link = "logit"), control = glmerControl(optimizer ='optimx', optCtrl=list(method='nlminb')))
model2 = glmer( success ~ TIME + (TIME|PAIR) + (TIME|TARGET),family = binomial(link = "logit"), control = glmerControl(optimizer ='optimx', optCtrl=list(method='nlminb')))
model1 = glmer( success ~ 1  + (1|PAIR) + (1| TARGET),family = binomial(link = "logit"), control = glmerControl(optimizer ='optimx', optCtrl=list(method='nlminb')))
AIC(model1,model2,model2B,model3,model4,model5,model6,model7,model8,model9)


model1graph = ggpredict(model2,c("TIME [all]"))
plot(model1graph)
model2graph = ggpredict(model9,c("TIME","IsIntroducer"))
plot(model2graph)
model3graph = ggpredict(model9,c("IsIntroducer","TIME"))
plot(model3graph)

P2_sd$Time <- P2$Time
P1_sd$Time <- P1$Time
P <- rbind(P2_sd,P1_sd)

#P <- P[P$Condtion=="modified",]
P <- P[P$Role=="director",]

D<-paste0(P$Target, P$Introducer)

ggplot(data=P, aes(x=D, y=Z, color=Introducer)) +
  geom_point(position=position_dodge(width=0.3))


success <- as.numeric(P$Success)
condition<-as.factor(P$Condtion)
TIME <-round(P$Time/1000)
PAIR <- as.factor(P$Pair)
TARGET<- as.factor(P$Target)
IsIntroducer <-as.factor(P$Introducer)
IsSuccIntroducer <- as.factor(P$Succ_Introducer)
PARTICIPANT <- as.factor(P$Participant)
sdz<-P$Z
sdx<-P$X
sdy<-P$Y
Game <- P$Game
Win <-as.factor(P$Success)


lmodel =  lmer (sdz ~   IsIntroducer + (IsIntroducer|PAIR) + (1 | PARTICIPANT) + (IsIntroducer|TARGET))
lmodel2B =  lmer (sdz ~   condition + (condition|PAIR) + (1 | PARTICIPANT) + (condition|TARGET))
lmodel2C =  lmer (sdx ~   condition + (condition|PAIR) + (1 | PARTICIPANT) + (condition|TARGET))

lmodel3 =  lmer (sdz ~   condition+IsIntroducer + (condition+IsIntroducer|PAIR) + (1 | PARTICIPANT) + (condition+IsIntroducer|TARGET))
lmodel4 =  lmer (sdz ~   condition*IsIntroducer + (condition*IsIntroducer|PAIR) + (1 | PARTICIPANT) + (condition*IsIntroducer|TARGET))
lmodel5 =  lmer (sdz ~   Win + (Win|PAIR) + (1 | PARTICIPANT) + (Win|TARGET))
lmodel6 =  lmer (sdz ~   Win+IsIntroducer + (Win+IsIntroducer|PAIR) + (1 | PARTICIPANT) + (Win+IsIntroducer|TARGET))
lmodel7 =  lmer (sdz ~   Win*IsIntroducer + (Win*IsIntroducer|PAIR) + (1 | PARTICIPANT) + (Win*IsIntroducer|TARGET))
lmodel8 =  lmer (sdz ~   1+ (1|PAIR) + (1|TARGET))
lmodel9 =  lmer (sdz ~   IsSuccIntroducer + (IsSuccIntroducer|PAIR) + (1 | PARTICIPANT) + (IsSuccIntroducer|TARGET))
lmodel10 =  lmer (sdz ~   IsSuccIntroducer+IsIntroducer + (IsSuccIntroducer+IsIntroducer|PAIR) + (1 | PARTICIPANT) + (IsSuccIntroducer+IsIntroducer|TARGET))
lmodel11 =  lmer (sdz ~   Win*IsIntroducer+condition + (Win*IsIntroducer+condition|PAIR) + (1 | PARTICIPANT) + (Win*IsIntroducer+condition|TARGET))
lmodel12 =  lmer (sdz ~   sdx*condition + (sdx*condition|PAIR) + (1 | PARTICIPANT) + (sdx*condition|TARGET))
lmodel13 =  lmer (sdz ~   sdx+condition + (sdx+condition|PAIR) + (1 | PARTICIPANT) + (sdx+condition|TARGET))
lmodel14 =  lmer (sdz ~   Win*IsIntroducer+sdx*condition + (Win*IsIntroducer+sdx*condition|PAIR) + (1 | PARTICIPANT) + (Win*IsIntroducer+sdx*condition|TARGET))


summary(lmodel13)

model3graph = ggpredict(lmodel2C,c("condition"))
plot(model3graph)




model1graph = ggpredict(lmodel7,c("IsIntroducer","Win"))
plot(model1graph)
model2graph = ggpredict(lmodel11,c("IsIntroducer","Win","condition"))
plot(model2graph)

AIC(lmodel,lmodel2,lmodel3,lmodel4,lmodel5,lmodel6,lmodel7,
    lmodel8,lmodel9,lmodel10,lmodel11,lmodel12,lmodel13,lmodel14)

