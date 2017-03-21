library(lattice)
oj <- read.csv("D:/KJ/MIT2016/SPRING2016/ABI/ASSIGNMENT1/ASSIGNMENT1_DOCUMENTS/oj.csv")
oj$store <- factor(oj$store)
oj[1:2,]

t1=tapply(oj$logmove,oj$brand,FUN=mean,na.rm=TRUE)
t1

t2=tapply(oj$logmove,INDEX=list(oj$brand,oj$week),FUN=mean,na.rm=TRUE)
t2

plot(t2[1,],type= "l",xlab="week",ylab="dominicks",ylim=c(7,12))
plot(t2[2,],type= "l",xlab="week",ylab="minute.maid",ylim=c(7,12))
plot(t2[3,],type= "l",xlab="week",ylab="tropicana",ylim=c(7,12))


logmove=c(t2[1,],t2[2,],t2[3,])
week1=c(40:160)
week=c(week1,week1,week1)
brand1=rep(1,121)
brand2=rep(2,121)

brand3=rep(3,121)
brand=c(brand1,brand2,brand3)
brand
xyplot(logmove~week|factor(brand),type= "l",layout=c(1,3),col="black")


boxplot(logmove~brand,data=oj)
histogram(~logmove|brand,data=oj,layout=c(1,3))
densityplot(~logmove|brand,data=oj,layout=c(1,3),plot.points=FALSE)
densityplot(~logmove,groups=brand,data=oj,plot.points=FALSE)


xyplot(logmove~week,data=oj,col="black")
xyplot(logmove~week|brand,data=oj,layout=c(1,3),col="black")
xyplot(logmove~price,data=oj,col="black")
xyplot(logmove~price|brand,data=oj,layout=c(1,3),col="black")


smoothScatter(oj$price,oj$logmove)

densityplot(~logmove,groups=feat, data=oj, plot.points=FALSE)
xyplot(logmove~price,groups=feat, data=oj)


oj1=oj[oj$store == 5,]
oj1
xyplot(logmove~week|brand,data=oj1,type="l",layout=c(1,3),col="black")
xyplot(logmove~price,data=oj1,col="black")
xyplot(logmove~price|brand,data=oj1,layout=c(1,3),col="black")



densityplot(~logmove|brand,groups=feat,data=oj1,plot.points=FALSE)
xyplot(logmove~price|brand,groups=feat,data=oj1)


t21=tapply(oj$INCOME,oj$store,FUN=mean,na.rm=TRUE)
t21
t21[t21==max(t21)]
t21[t21==min(t21)]
oj1=oj[oj$store == 62,]
oj1
oj2=oj[oj$store == 75,]
oj2
oj3=rbind(oj1,oj2)
?rbind
xyplot(logmove~price|store,data=oj3)
xyplot(logmove~price|store,groups=feat,data=oj3)

mhigh=lm(logmove~price,data=oj1)
summary(mhigh)
plot(logmove~price,data=oj1,xlim=c(0,4),ylim=c(0,13))


abline(mhigh)

mlow=lm(logmove~price,data=oj2)
summary(mlow)
plot(logmove~price,data=oj2,xlim=c(0,4),ylim=c(0,13))
abline(mlow)
















