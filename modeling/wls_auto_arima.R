library(forecast)
library(TTR)
library(pracma)
library(dplyr)
library(tseries)
setwd('C:/Users/user/Desktop/NOVUS_Futures/Preprocessing/data')



"""
er 
kt 414
ss 302

wls 
ht 212 
kt 414

"""
pit_hh <- read.csv('./pit/pit_HH.csv')
pit_ht <- read.csv('./pit/pit_HT.csv')
pit_kt <- read.csv('./pit/pit_KT.csv')
pit_lg <- read.csv('./pit/pit_LG.csv')
pit_lt <- read.csv('./pit/pit_LT.csv')
pit_nc <- read.csv('./pit/pit_NC.csv')
pit_ob <- read.csv('./pit/pit_OB.csv')
pit_sk <- read.csv('./pit/pit_SK.csv')
pit_ss <- read.csv('./pit/pit_SS.csv')
pit_wo <- read.csv('./pit/pit_WO.csv')
head(pit_wo)

hit_hh <- read.csv('./hit/hit_HH.csv')
hit_ht <- read.csv('./hit/hit_HT.csv')
hit_kt <- read.csv('./hit/hit_KT.csv')
hit_lg <- read.csv('./hit/hit_LG.csv')
hit_lt <- read.csv('./hit/hit_LT.csv')
hit_nc <- read.csv('./hit/hit_NC.csv')
hit_ob <- read.csv('./hit/hit_OB.csv')
hit_sk <- read.csv('./hit/hit_SK.csv')
hit_ss <- read.csv('./hit/hit_SS.csv')
hit_wo <- read.csv('./hit/hit_WO.csv')
head(hit_wo)


hh_wls <- pit_hh[,4]
ht_wls <- pit_ht[,4]
kt_wls <- pit_kt[,4]
lg_wls <- pit_lg[,4]
lt_wls <- pit_lt[,4]
nc_wls <- pit_nc[,4]
ob_wls <- pit_ob[,4]
sk_wls <- pit_sk[,4]
ss_wls <- pit_ss[,4]
wo_wls <- pit_wo[,4]

hh_er <- pit_hh[,3]
ht_er <- pit_ht[,3]
kt_er <- pit_kt[,3]
lg_er <- pit_lg[,3]
lt_er <- pit_lt[,3]
nc_er <- pit_nc[,3]
ob_er <- pit_ob[,3]
sk_er <- pit_sk[,3]
ss_er <- pit_ss[,3]
wo_er <- pit_wo[,3]

hh_ba <- hit_hh[,3]
ht_ba <- hit_ht[,3]
kt_ba <- hit_kt[,3]
lg_ba <- hit_lg[,3]
lt_ba <- hit_lt[,3]
nc_ba <- hit_nc[,3]
ob_ba <- hit_ob[,3]
sk_ba <- hit_sk[,3]
ss_ba <- hit_ss[,3]
wo_ba <- hit_wo[,3]
head(wo_ba)

for(i in 0:4){
  for(j in 0:4){
    for(k in 0:1)cat(arima(ss_ba,c(i,k,j))$aic,i,k,j,"\n")
  }
}

# """
# adf 검정
# """
# # er_kt 차분1
# adf.test(kt_er,k = trunc((length(kt_er)-1)^(1/3)))
# diff_kter <- diff(kt_er)
# adf.test(diff_kter)
# 
# # er_ss 차분1 
# adf.test(ss_er,k = trunc((length(kt_er)-1)^(1/3)))
# diff_sser <- diff(ss_er)
# adf.test(diff_sser)
# 
# # wls_ht 차분1 
# adf.test(ht_wls,k = trunc((length(ht_wls)-1)^(1/3)))
# diff_sser <- diff(ht_wls)
# adf.test(diff_sser)



# """
# --승률 ARIMA--
# 
# 한화 0,1,0
# 기아 0,1,1 
# KT 0,1,0 
# 엘지 2,0,0 
# 롯데 0,1,0
# NC 0,1,0
# 두산 0,0,1 
# SK 0,1,1 
# 샘숭 2,1,0 
# 키움 0,1,1
# """

# # 한화 3,0,2
# head(pit_hh)
# head(hh_wls)
# auto.arima(hh_wls)
# head(hh_wls)
# 
# # 기아 0,1,0  
# head(ht_wls)
# auto.arima(ht_wls)
# 
# # 크트 0,1,0 
# head(kt_wls)
# auto.arima(kt_wls)
# 
# # 엘지 2,0,0 
# head(lg_wls)
# auto.arima(lg_wls)
# 
# # 롯데 1,0,3
# head(lt_wls)
# auto.arima(lt_wls)
# 
# # 엔씨 0,1,0
# head(nc_wls)
# auto.arima(nc_wls)
# 
# # 두산 4,1,1 
# head(ob_wls)
# auto.arima(ob_wls)
# 
# # 스크 0,1,0 
# head(sk_wls)
# auto.arima(sk_wls)
# 
# # 샘숭 0,1,0 
# head(ss_wls)
# auto.arima(ss_wls)
# 
# # 키움 1,0,0 
# head(wo_wls)
# auto.arima(wo_wls)
# 
# """
# -- 자책점 ARIMA --
# 한화 1,2,1
# 기아 1,2,1
# kt 0,1,0
# lg 1,1,0
# 롯데 1,0,0
# nc 0,2,1
# 두산 2,1,1
# sk 1,0,1 
# 삼성 1,0,0 
# 키움 0,1,1
# 
# """
# # 한화 2,0,1
# hh_er <- pit_hh[,3]
# hh_er
# auto.arima(hh_er)
# 
# # 기아 1,1,2
# ht_er <- pit_ht[,3]
# ht_er
# head(pit_ht)
# pit_ht$ER <- round(movavg(pit_ht$ER,n=18),digits=2)
# ht_er <- pit_ht$ER
# auto.arima(ht_er)
# 
# # kt 0,1,0
# kt_er <- pit_kt[,3]
# head(kt_er)
# auto.arima(kt_er)
# 
# # lg 1,0,2
# lg_er <- pit_lg[,3]
# head(lg_er)
# auto.arima(lg_er)
# 
# # 롯데 1,0,0
# lt_er <- pit_lt[,3]
# head(lt_er)
# auto.arima(lt_er)
# 
# # nc 2,1,0
# nc_er <- pit_nc[,3]
# head(nc_er)
# auto.arima(nc_er)
# 
# # 두산 2,1,1
# ob_er <- pit_ob[,3]
# head(ob_er)
# auto.arima(ob_er)
# 
# # sk 0,1,1 
# sk_er <- pit_sk[,3]
# head(sk_er)
# auto.arima(sk_er)
# 
# # 삼성 1,0,0 
# ss_er <- pit_ss[,3]
# head(ss_er)
# auto.arima(ss_er)
# 
# # 키움 0,1,1
# wo_er <- pit_wo[,3]
# head(wo_er)
# auto.arima(wo_er)
# 
# """
# -- non ma 자책점 ARIMA --
#   한화 1,2,1
# 기아 1,2,1
# kt 0,1,0
# lg 1,1,0
# 롯데 1,0,0
# nc 0,2,1
# 두산 2,1,1
# sk 1,0,1 
# 삼성 1,0,0 
# 키움 0,1,1
# 
# """
# 
# # 한화 2,0,1//// 000
# hh_er <- pit_hh[,3]
# hh_er
# auto.arima(hh_er)
# 
# # 기아 1,1,2//// 112
# ht_er <- pit_ht[,3]
# head(pit_ht)
# auto.arima(ht_er)
# 
# # kt 0,1,0//// 011
# kt_er <- pit_kt[,3]
# head(kt_er)
# auto.arima(kt_er)
# 
# # lg 1,0,2//// 000
# lg_er <- pit_lg[,3]
# head(lg_er)
# auto.arima(lg_er)
# 
# # 롯데 1,0,0//// 000
# lt_er <- pit_lt[,3]
# head(lt_er)
# auto.arima(lt_er)
# 
# # nc 2,1,0//// 000
# nc_er <- pit_nc[,3]
# head(nc_er)
# auto.arima(nc_er)
# 
# # 두산 2,1,1//// 000
# ob_er <- pit_ob[,3]
# head(ob_er)
# auto.arima(ob_er)
# 
# # sk 0,1,1//// 100
# sk_er <- pit_sk[,3]
# head(sk_er)
# auto.arima(sk_er)
# 
# # 삼성 1,0,0//// 001 
# ss_er <- pit_ss[,3]
# head(ss_er)
# auto.arima(ss_er)
# 
# # 키움 0,1,1//// 202
# wo_er <- pit_wo[,3]
# head(wo_er)
# auto.arima(wo_er)
# 
# 
