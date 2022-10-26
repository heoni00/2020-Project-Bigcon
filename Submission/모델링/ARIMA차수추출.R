library(dplyr)
library(pracma)
library(forecast)
library(xts)
library(TTR)
library(tseries)

team_name <- c("HH","HT","KT","LG","LT","NC","OB","SK","SS","WO")

for (i in team_name){
  assign(paste0("wls_",i), read.csv(paste0("pit_",i,".csv")) ) # pit 데이터 불러오기
  date <- as.Date( get (paste0("wls_",i))$GDAY_DS ) # pit 데이터의 날짜를 표준화
  WLS <- get (paste0("wls_",i))$WLS # pit 데이터의 WLS 컬럼 추출
  assign(paste0("wls_",i), ts(WLS,date)) #WLS 컬럼과 날짜를 시계열로 변환후 저장
}


for (i in team_name){
  assign(paste0("pit_",i), read.csv(paste0("pit_",i,".csv")) ) # pit 데이터 불러오기
  date <- as.Date( get (paste0("pit_",i))$GDAY_DS ) # pit 데이터의 날짜를 표준화
  ER <- get (paste0("pit_",i))$ER # pit 데이터의 ER 컬럼 추출
  assign(paste0("pit_",i), ER) #ER 컬럼과 날짜를 시계열로 변환후 저장
}

for (i in team_name){
  assign(paste0("hit_",i), read.csv(paste0("hit",i,".csv")) ) # hit 데이터 불러오기
  date <- as.Date( get (paste0("hit_",i))$GDAY_DS ) # hit 데이터의 날짜를 표준화
  BA <- get (paste0("hit_",i))$BA # hit 데이터의 BA 컬럼 추출
  assign(paste0("hit_",i), ts(BA,date)) #BA 컬럼과 날짜를 시계열로 변환후 저장
}

#오토아리마를 통해 가장 적합한 아리마 모델 차수를 추출하였음

auto.arima(ts(hit_HH))
auto.arima(ts(hit_HT))
auto.arima(ts(hit_KT))
auto.arima(ts(hit_LG))
auto.arima(ts(hit_LT))
auto.arima(ts(hit_NC))
auto.arima(ts(hit_OB))
auto.arima(ts(hit_SK))
auto.arima(ts(hit_SS))
auto.arima(ts(hit_WO))

auto.arima(ts(pit_HH))
auto.arima(ts(pit_HT))
auto.arima(ts(pit_KT))
auto.arima(ts(pit_LG))
auto.arima(ts(pit_LT))
auto.arima(ts(pit_NC))
auto.arima(ts(pit_OB))
auto.arima(ts(pit_SK))
auto.arima(ts(pit_SS))
auto.arima(ts(pit_WO))

auto.arima(ts(pit_HH))
auto.arima(ts(pit_HT))
auto.arima(ts(pit_KT))
auto.arima(ts(pit_LG))
auto.arima(ts(pit_LT))
auto.arima(ts(pit_NC))
auto.arima(ts(pit_OB))
auto.arima(ts(pit_SK))
auto.arima(ts(pit_SS))
auto.arima(ts(pit_WO))

#적합한 아리마 차수 (p, d, q)

#       BA          ER          WLS
# HH  2, 0, 2     2, 0, 1     3, 0, 2
# HT  1, 0, 2     1, 1, 2     0, 1, 0
# KT  2, 1, 0     0, 1, 0     0, 1, 0
# LG  2, 0, 0     1, 0, 2     1, 0, 2
# LT  2, 0, 4     1, 0 ,0     1, 0, 3
# NC  1, 0, 0     2, 1, 0     0, 1, 0
# OB  1, 0, 4     2, 1, 1     4, 1, 1
# SK  2, 1, 0     0, 1, 1     0, 1, 0
# SS  0, 2, 1     0, 1, 0     0, 1, 0
# WO  0, 1, 0     1, 0, 1     1, 0, 0
 


best.arima <- function(x){ 
  # AIC가 가장 작은 계수 찾는 함수 (오토 아리마 계수가 0,1,0 일때)
  d <- data.frame(AIC=seq(1,50),p=seq(1,50),d=seq(1,50),q=seq(1,50))
  a =1
  
  for(j in 0:4){
    for(i in 0:4){
      for(k in 0:1){
        d$AIC[a] <- arima(x,c(i,j,k))$aic; d$p[a] <- i; d$d[a] <-  j; d$q[a] <- k 
        #AIC값과 차수를 데이터 프레임에 저장
        a = a+1
      }
    }
  }
  d<-arrange(d,AIC) # 데이터프레임을 AIC의 오름차순으로 정렬
  print(d)
}

best.arima(hit_HH)


#재조정한 아리마 차수 (p, d, q)

#       BA          ER          WLS
# HH  2, 0, 2     2, 0, 1     3, 0, 2
# HT  1, 0, 2     1, 1, 2     2, 1, 2
# KT  2, 1, 0     4, 1, 4     4, 1, 4
# LG  2, 0, 0     1, 0, 2     1, 0, 2
# LT  2, 0, 4     1, 0 ,0     1, 0, 3
# NC  1, 0, 0     2, 1, 0     1, 1, 0
# OB  1, 0, 4     2, 1, 1     4, 1, 1
# SK  2, 1, 0     0, 1, 1     1, 0, 0
# SS  0, 2, 1     3, 0, 2     1, 0, 0
# WO  4, 0, 3     1, 0, 1     1, 0, 0




