from statsmodels.tsa.arima_model import ARIMA
import statsmodels.api as sm
from datetime import datetime
import matplotlib.pyplot as plt
import pandas as pd
import numpy as np

# HIT (BA) 데이터 불러오기
hit_HT = pd.read_csv('./hit/hit_HT.csv')
hit_HH = pd.read_csv('./hit/hit_HH.csv')
hit_KT = pd.read_csv('./hit/hit_KT.csv')
hit_LG = pd.read_csv('./hit/hit_LG.csv')
hit_LT = pd.read_csv('./hit/hit_LT.csv')
hit_NC = pd.read_csv('./hit/hit_NC.csv')
hit_OB = pd.read_csv('./hit/hit_OB.csv')
hit_SK = pd.read_csv('./hit/hit_SK.csv')
hit_SS = pd.read_csv('./hit/hit_SS.csv')
hit_WO = pd.read_csv('./hit/hit_WO.csv')

ba_HT = hit_HT.iloc[:, [1, 2]]
ba_HH = hit_HH.iloc[:, [1, 2]]
ba_KT = hit_KT.iloc[:, [1, 2]]
ba_LG = hit_LG.iloc[:, [1, 2]]
ba_LT = hit_LT.iloc[:, [1, 2]]
ba_NC = hit_NC.iloc[:, [1, 2]]
ba_OB = hit_OB.iloc[:, [1, 2]]
ba_SK = hit_SK.iloc[:, [1, 2]]
ba_SS = hit_SS.iloc[:, [1, 2]]
ba_WO = hit_WO.iloc[:, [1, 2]]

# PIT (ER) 데이터 불러오기
pit_HT = pd.read_csv('./pit/pit_HT.csv')
pit_HH = pd.read_csv('./pit/pit_HH.csv')
pit_KT = pd.read_csv('./pit/pit_KT.csv')
pit_LG = pd.read_csv('./pit/pit_LG.csv')
pit_LT = pd.read_csv('./pit/pit_LT.csv')
pit_NC = pd.read_csv('./pit/pit_NC.csv')
pit_OB = pd.read_csv('./pit/pit_OB.csv')
pit_SK = pd.read_csv('./pit/pit_SK.csv')
pit_SS = pd.read_csv('./pit/pit_SS.csv')
pit_WO = pd.read_csv('./pit/pit_WO.csv')
er_HT = pit_HT.iloc[:, [1, 2]]
er_HH = pit_HH.iloc[:, [1, 2]]
er_KT = pit_KT.iloc[:, [1, 2]]
er_LG = pit_LG.iloc[:, [1, 2]]
er_LT = pit_LT.iloc[:, [1, 2]]
er_NC = pit_NC.iloc[:, [1, 2]]
er_OB = pit_OB.iloc[:, [1, 2]]
er_SK = pit_SK.iloc[:, [1, 2]]
er_SS = pit_SS.iloc[:, [1, 2]]
er_WO = pit_WO.iloc[:, [1, 2]]

# PIT (WLS) 데이터 불러오기
wls_HT = pit_HT.iloc[:, [1, 3]]
wls_HH = pit_HH.iloc[:, [1, 3]]
wls_KT = pit_KT.iloc[:, [1, 3]]
wls_LG = pit_LG.iloc[:, [1, 3]]
wls_LT = pit_LT.iloc[:, [1, 3]]
wls_NC = pit_NC.iloc[:, [1, 3]]
wls_OB = pit_OB.iloc[:, [1, 3]]
wls_SK = pit_SK.iloc[:, [1, 3]]
wls_SS = pit_SS.iloc[:, [1, 3]]
wls_WO = pit_WO.iloc[:, [1, 3]]

# 모델링


def modeling(data, order, steps, trend='c'):  # 데이터, arima 차수, 예측갯수, 추세유무
    data = data.iloc[:, 1]  #
    model = ARIMA(data, order=order)
    model_fit = model.fit(trend=trend, full_output=True, disp=True)
    print("{}\n".format(model_fit.summary()))
    fore = model_fit.forecast(steps=steps)
    f = pd.DataFrame(fore[0])
    f.index = pd.RangeIndex(start=len(data), stop=len(data)+steps, step=1)
    model_fit.plot_predict()
    plt.plot(f)
    print("예측값", f)


# # 잔여경기수
# HH 10
# HT 12
# KT 9
# LG 7
# LT 9
# NC 7
# OB 12
# SK 9
# SS 11
# WO 9
#
# # BA(hit)
# HH 2,0,2<br>
# HT 1,0,2<br>
# KT 2,1,0<br>
# LG 2,0,0<br>
# LT 2,0,4<br>
# NC 1,0,0<br>
# OB 1,0,4<br>
# SK 2,1,0<br>
# SS 0,2,1<br>
# WO 4,0,3<br>
#

# 한화 BA
modeling(ba_HH, (2, 0, 2), 10)

# 기아 BA
modeling(ba_HT, (1, 0, 2), 12, 'c')

# KT BA
modeling(ba_KT, (2, 1, 0), 9, 'nc')

# LG BA
modeling(ba_LG, (2, 0, 0), 7)

# 롯데 BA
modeling(ba_LT, (2, 0, 4), 9)

# NC BA
modeling(ba_NC, (1, 0, 0), 7)

# OB BA
modeling(ba_OB, (1, 0, 4), 12)

# SK BA
modeling(ba_SK, (2, 1, 0), 9, 'nc')

# SS BA
modeling(ba_SS, (0, 2, 1), 11, 'nC')

# WO BA
modeling(ba_WO, (4, 0, 3), 9)


#
# # ER(PIT)
# HH 201 <br>
# HT 112<br>
# KT 010//414<br>
# LG 102<br>
# LT 100<br>
# NC 210<br>
# OB 211<br>
# SK 011<br>
# SS 010//302<br>
# WO 101<br>
#

# HH ER
modeling(er_HH, (2, 0, 1), 10)

# HT ER
modeling(er_HT, (1, 1, 2), 12, 'NC')

# KT ER
modeling(er_KT, (4, 1, 4), 9, 'nc')

# LG ER
modeling(er_LG, (1, 0, 2), 7)

# LT ER
modeling(er_LT, (1, 0, 0), 9)

# NC ER
modeling(er_NC, (2, 1, 0), 7, 'nc')

# OB ER
modeling(er_OB, (2, 1, 1), 12, 'NC')

# SK ER
modeling(er_SK, (0, 1, 1), 9, 'NC')

# SS ER
modeling(er_SS, (3, 0, 2), 11, 'C')

# WO ER
modeling(er_WO, (1, 0, 1), 9)


# # WLS
# HH 302<br>
# HT 010//212<br>
# KT 010//414<br>
# LG 102<br>
# LT 103<br>
# NC 010/110<br>
# OB 411<br>
# SK 010/100<br>
# SS 010/100<br>
# WO 100<br>

# HH WLS
modeling(wls_HH, (3, 0, 2), 10)

# HT WLS
modeling(wls_HT, (2, 1, 2), 12, 'nc')

# KT WLS
modeling(wls_KT, (4, 1, 4), 9, 'nc')

# LG WLS
modeling(wls_LG, (1, 0, 2), 7)

# LT WLS
modeling(wls_LT, (1, 0, 3), 9)

# NC WLS
modeling(wls_NC, (1, 1, 0), 7, 'NC')

# OB WLS
modeling(wls_OB, (4, 1, 1), 12, 'nc')

# SK WLS
modeling(wls_SK, (1, 0, 0), 9)

# SS WLS
modeling(wls_SS, (1, 0, 0), 11, 'NC')

# WO WLS
modeling(wls_WO, (1, 0, 0), 9)
