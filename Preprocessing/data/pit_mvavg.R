library(dplyr)
library(pracma)

pit <- read.csv("2020빅콘테스트_스포츠투아이_제공데이터_팀투수_2020.csv") # 스포츠투아이 제공데이터(PIT)

table(pit$WLS) # 승패 컬럼에 "S"값은(세이브) 존재 안함

#WLS 열의 값들을 패는 0 승은 1 무승부는 NA로 변경함.
pit[pit$WLS=="L","WLS"] <- 0; pit[pit$WLS=="W","WLS"] <- 1; pit[pit$WLS=="D",'WLS'] <- NA  

pit$WLS <- as.numeric(pit$WLS)#값들을 실수형으로 변환


#날짜, 팀이름, 자책점, 승패 열 추출 (승률은 승패(1,0)의 평균값, 평균자책점은 게임당 자책점)
tp <- pit%>%select(GDAY_DS,T_ID,ER,WLS)
tp$GDAY_DS <- as.Date(as.character(tp$GDAY_DS),"%Y%m%d")

#각 팀별로 데이터를 분리

pit_HH<- tp%>%filter(T_ID=="HH")%>%select(GDAY_DS,ER,WLS)
pit_HT <- tp%>%filter(T_ID=="HT")%>%select(GDAY_DS,ER,WLS)
pit_KT <- tp%>%filter(T_ID=="KT")%>%select(GDAY_DS,ER,WLS)
pit_LG <- tp%>%filter(T_ID=="LG")%>%select(GDAY_DS,ER,WLS)
pit_LT <- tp%>%filter(T_ID=="LT")%>%select(GDAY_DS,ER,WLS)
pit_NC <- tp%>%filter(T_ID=="NC")%>%select(GDAY_DS,ER,WLS)
pit_OB <- tp%>%filter(T_ID=="OB")%>%select(GDAY_DS,ER,WLS)
pit_SK <- tp%>%filter(T_ID=="SK")%>%select(GDAY_DS,ER,WLS)
pit_SS <- tp%>%filter(T_ID=="SS")%>%select(GDAY_DS,ER,WLS)
pit_WO <- tp%>%filter(T_ID=="WO")%>%select(GDAY_DS,ER,WLS)


#스포츠 투아이 제공 데이터와 네이버 스포츠 추출 데이터 병합

pit_HH <- rbind(pit_HH,read.csv("pitHH.csv"))
pit_HT <- rbind(pit_HT,read.csv("pitHT.csv"))
pit_KT <- rbind(pit_KT,read.csv("pitKT.csv"))
pit_LG <- rbind(pit_LG,read.csv("pitLG.csv"))
pit_LT <- rbind(pit_LT,read.csv("pitLT.csv"))
pit_NC <- rbind(pit_NC,read.csv("pitNC.csv"))
pit_OB <- rbind(pit_OB,read.csv("pitOB.csv"))
pit_SS <- rbind(pit_SS,read.csv("pitSS.csv"))
pit_SK <- rbind(pit_SK,read.csv("pitSK.csv"))
pit_WO <- rbind(pit_WO,read.csv("pitWO.csv"))

##각팀별 데이터 변환

a<-c()
for (i in 1:length(pit_HH$WLS)){
  if (i<=18) a[i] <- mean(pit_HH[1:i,"WLS"],na.rm=T)
  else a[i] <- mean(pit_HH[(i-17):i,"WLS"],na.rm = T)
}#승률은 18일간의 승,패값의 평균이므로 무승부인 NA값을 제외하고 평균을 구했다. (a값에 승률데이터 대입)
pit_HH$WLS <- round(a,digits=3)#소수점 세세자리로 변환후 팀별 데이터의 승률값에 a값을 넣음
pit_HH$ER <- round(movavg(pit_HH$ER,n=18),digits=3)# movavg 함수를 이용하여 평균자책점(자책점의 평균)의 이동평균을 구하였다.
write.csv(pit_HH,file="pit_HH.csv")#데이터를 파일에 저장함

a <- c()
for (i in 1:length(pit_HT$WLS)){
  if (i<=18) a[i] <- mean(pit_HT[1:i,"WLS"],na.rm=T)
  else a[i] <- mean(pit_HT[(i-17):i,"WLS"],na.rm = T)
}#승률은 18일간의 승,패값의 평균이므로 무승부인 NA값을 제외하고 평균을 구했다. (a값에 승률데이터 대입)
pit_HT$WLS <- round(a,digits=3)
pit_HT$ER <- round(movavg(pit_HT$ER,n=18),digits=3)# movavg 함수를 이용하여 평균자책점의 이동평균을 구하였다.
write.csv(pit_HT,file="pit_HT.csv")#데이터를 파일에 저장함

a <- c()
for (i in 1:length(pit_KT$WLS)){
  if (i<=18) a[i] <- mean(pit_KT[1:i,"WLS"],na.rm=T)
  else a[i] <- mean(pit_KT[(i-17):i,"WLS"],na.rm = T)
}#승률은 18일간의 승,패값의 평균이므로 무승부인 NA값을 제외하고 평균을 구했다. (a값에 승률데이터 대입)
pit_KT$WLS <- round(a,digits=3)
pit_KT$ER <- round(movavg(pit_KT$ER,n=18),digits=3)# movavg 함수를 이용하여 평균자책점의 이동평균을 구하였다.
write.csv(pit_KT,file="pit_KT.csv")#데이터를 파일에 저장함

a <- c()
for (i in 1:length(pit_LG$WLS)){
  if (i<=18) a[i] <- mean(pit_LG[1:i,"WLS"],na.rm=T)
  else a[i] <- mean(pit_LG[(i-17):i,"WLS"],na.rm = T)
}#승률은 18일간의 승,패값의 평균이므로 무승부인 NA값을 제외하고 평균을 구했다. (a값에 승률데이터 대입)
pit_LG$WLS <- round(a,digits=3)
pit_LG$ER <- round(movavg(pit_LG$ER,n=18),digits=3)# movavg 함수를 이용하여 평균자책점의 이동평균을 구하였다.
write.csv(pit_LG,file="pit_LG.csv")#데이터를 파일에 저장함

a <- c()
for (i in 1:length(pit_LT$WLS)){
  if (i<=18) a[i] <- mean(pit_LT[1:i,"WLS"],na.rm=T)
  else a[i] <- mean(pit_LT[(i-17):i,"WLS"],na.rm = T)
}#승률은 18일간의 승,패값의 평균이므로 무승부인 NA값을 제외하고 평균을 구했다. (a값에 승률데이터 대입)
pit_LT$WLS <- round(a,digits=3)
pit_LT$ER <- round(movavg(pit_LT$ER,n=18),digits=3)# movavg 함수를 이용하여 평균자책점의 이동평균을 구하였다.
write.csv(pit_LT,file="pit_LT.csv")#데이터를 파일에 저장함

a <- c()
for (i in 1:length(pit_NC$WLS)){
  if (i<=18) a[i] <- mean(pit_NC[1:i,"WLS"],na.rm=T)
  else a[i] <- mean(pit_NC[(i-17):i,"WLS"],na.rm = T)
}#승률은 18일간의 승,패값의 평균이므로 무승부인 NA값을 제외하고 평균을 구했다. (a값에 승률데이터 대입)
pit_NC$WLS <- round(a,digits=3)
pit_NC$ER <- round(movavg(pit_NC$ER,n=18),digits=3)# movavg 함수를 이용하여 평균자책점의 이동평균을 구하였다.
write.csv(pit_NC,file="pit_NC.csv")#데이터를 파일에 저장함

a <- c()
for (i in 1:length(pit_OB$WLS)){
  if (i<=18) a[i] <- mean(pit_OB[1:i,"WLS"],na.rm=T)
  else a[i] <- mean(pit_OB[(i-17):i,"WLS"],na.rm = T)
}#승률은 18일간의 승,패값의 평균이므로 무승부인 NA값을 제외하고 평균을 구했다. (a값에 승률데이터 대입)
pit_OB$WLS <- round(a,digits=3)
pit_OB$ER <- round(movavg(pit_OB$ER,n=18),digits=3)# movavg 함수를 이용하여 평균자책점의 이동평균을 구하였다.
write.csv(pit_OB,file="pit_OB.csv")#데이터를 파일에 저장함

a <- c()
for (i in 1:length(pit_SK$WLS)){
  if (i<=18) a[i] <- mean(pit_SK[1:i,"WLS"],na.rm=T)
  else a[i] <- mean(pit_SK[(i-17):i,"WLS"],na.rm = T)
}#승률은 18일간의 승,패값의 평균이므로 무승부인 NA값을 제외하고 평균을 구했다. (a값에 승률데이터 대입)
pit_SK$WLS <- round(a,digits=3)
pit_SK$ER <- round(movavg(pit_SK$ER,n=18),digits=3)# movavg 함수를 이용하여 평균자책점의 이동평균을 구하였다.
write.csv(pit_SK,file="pit_SK.csv")#데이터를 파일에 저장함

a <- c()
for (i in 1:length(pit_SS$WLS)){
  if (i<=18) a[i] <- mean(pit_SS[1:i,"WLS"],na.rm=T)
  else a[i] <- mean(pit_SS[(i-17):i,"WLS"],na.rm = T)
}#승률은 18일간의 승,패값의 평균이므로 무승부인 NA값을 제외하고 평균을 구했다. (a값에 승률데이터 대입)
pit_SS$WLS <- round(a,digits=3)
pit_SS$ER <- round(movavg(pit_SS$ER,n=18),digits=3)# movavg 함수를 이용하여 평균자책점의 이동평균을 구하였다.
write.csv(pit_SS,file="pit_SS.csv")#데이터를 파일에 저장함

a <- c()
for (i in 1:length(pit_WO$WLS)){
  if (i<=18) a[i] <- mean(pit_WO[1:i,"WLS"],na.rm=T)
  else a[i] <- mean(pit_WO[(i-17):i,"WLS"],na.rm = T)
}#승률은 18일간의 승,패값의 평균이므로 무승부인 NA값을 제외하고 평균을 구했다. (a값에 승률데이터 대입)
pit_WO$WLS <- round(a,digits=3)
pit_WO$ER <- round(movavg(pit_WO$ER,n=18),digits=3)# movavg 함수를 이용하여 평균자책점의 이동평균을 구하였다.
write.csv(pit_WO,file="pit_WO.csv")#데이터를 파일에 저장함
