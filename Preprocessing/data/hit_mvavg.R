library(dplyr)
library(pracma)

hit <- read.csv("2020빅콘테스트_스포츠투아이_제공데이터_팀투수_2020.csv") # 스포츠투아이 제공 데이터

th <- hit%>%mutate(BA = (HIT)/AB)%>%select(GDAY_DS,T_ID=VS_T_ID,BA) # 타율 = 안타수 / 타수, 타율,게임날짜, 팀이름 추출
th$GDAY_DS <- as.Date(as.character(th$GDAY_DS),"%Y%m%d")#날짜를 표준화

hit_HH <- th%>%filter(T_ID=="HH")%>%select(GDAY_DS,BA) #각 팀별로 데이터를 분리
hit_HT <- th%>%filter(T_ID=="HT")%>%select(GDAY_DS,BA)
hit_KT <- th%>%filter(T_ID=="KT")%>%select(GDAY_DS,BA)
hit_LG <- th%>%filter(T_ID=="LG")%>%select(GDAY_DS,BA)
hit_LT <- th%>%filter(T_ID=="LT")%>%select(GDAY_DS,BA)
hit_NC <- th%>%filter(T_ID=="NC")%>%select(GDAY_DS,BA)
hit_OB <- th%>%filter(T_ID=="OB")%>%select(GDAY_DS,BA)
hit_SK <- th%>%filter(T_ID=="SK")%>%select(GDAY_DS,BA)
hit_SS <- th%>%filter(T_ID=="SS")%>%select(GDAY_DS,BA)
hit_WO <- th%>%filter(T_ID=="WO")%>%select(GDAY_DS,BA)

#스포츠 투아이 제공 데이터와 네이버 스포츠 추출 데이터 병합

hit_HH <- rbind(hit_HH,read.csv("hitHH.csv"))
hit_HT <- rbind(hit_HT,read.csv("hitHT.csv"))
hit_KT <- rbind(hit_KT,read.csv("hitKT.csv"))
hit_LG <- rbind(hit_LG,read.csv("hitLG.csv"))
hit_LT <- rbind(hit_LT,read.csv("hitLT.csv"))
hit_NC <- rbind(hit_NC,read.csv("hitNC.csv"))
hit_OB <- rbind(hit_OB,read.csv("hitOB.csv"))
hit_SK <- rbind(hit_SK,read.csv("hitSK.csv"))
hit_SS <- rbind(hit_SS,read.csv("hitSS.csv"))
hit_WO <- rbind(hit_WO,read.csv("hitWO.csv"))


#타율 컬럼 이동평균후에 소수점 3째짜리까지 반올림

hit_HH[,2] <- round(movavg(hit_HH[,2],n=18),digits=3 ) 
hit_HT[,2] <- round(movavg(hit_HT[,2],n=18),digits=3 )
hit_KT[,2] <- round(movavg(hit_KT[,2],n=18),digits=3 )
hit_LG[,2] <- round(movavg(hit_LG[,2],n=18),digits=3 )
hit_LT[,2] <- round(movavg(hit_LT[,2],n=18),digits=3 )
hit_NC[,2] <- round(movavg(hit_NC[,2],n=18),digits=3 )
hit_OB[,2] <- round(movavg(hit_OB[,2],n=18),digits=3 )
hit_SK[,2] <- round(movavg(hit_SK[,2],n=18),digits=3 )
hit_SS[,2] <- round(movavg(hit_SS[,2],n=18),digits=3 )
hit_WO[,2] <- round(movavg(hit_WO[,2],n=18),digits=3 )

#엑셀 파일로 저장.

write.csv(hit_HH,file="hiT_HH.csv")
write.csv(hit_HT,file="hit_HT.csv")
write.csv(hit_KT,file="hit_KT.csv")
write.csv(hit_LG,file="hit_LG.csv")
write.csv(hit_LT,file="hit_LT.csv")
write.csv(hit_NC,file="hit_NC.csv")
write.csv(hit_OB,file="hit_OB.csv")
write.csv(hit_SK,file="hit_SK.csv")
write.csv(hit_SS,file="hit_SS.csv")
write.csv(hit_WO,file="hit_WO.csv")

