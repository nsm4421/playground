from MyPV import MyPV
import pandas as pd
import numpy as np
import logging
from datetime import datetime


# Set Logger
logger = logging.getLogger()
logger.setLevel(logging.INFO)
fmt = logging.Formatter('%(asctime)s - %(levelname)s - %(message)s')
stream_handler = logging.StreamHandler()
stream_handler.setFormatter(fmt)
logger.addHandler(stream_handler)
file_handler = logging.FileHandler('logging.log')
file_handler.setFormatter(fmt)
logger.addHandler(file_handler)

# Create Instance
excel_file = './INFO.xlsx'
pv = MyPV(excel_file=excel_file)

# Read Sheet
sht_check = pd.read_excel(excel_file, sheet_name="확인", header=1)
sht_check = sht_check[['Key', 'sex', 'x', 'n', 'm', 'AMT', \
    'S', 'alpha1', 'alpha2', 'beta1', 'beta2', 'beta5', 'betaPrime', 'gamma', 'ce',\
        'NP', 'G', 'NP_beta', 'V(0)', 'V(1)', 'V(2)', 'V(3)', \
            'V(4)', 'V(5)', 'V(6)', 'V(7)', 'V(8)', 'V(9)', 'V(10)', 'W(0)', 'W(1)', \
                'W(2)', 'W(3)', 'W(4)', 'W(5)', 'W(6)', 'W(7)', 'W(8)', 'W(9)', 'W(10)']]\
                    .copy(deep = True).fillna(0)

if __name__ =='__main__':
    for t, row in enumerate(sht_check.values):
        isError = False
        key, sex, x, n, m, AMT, S, alpha1, alpha2, beta1, beta2, beta5, betaPrime, gamma, ce,\
            NP, G, NP_beta, V0, V1, V2, V3, V4, V5, V6, V7, V8, V9, V10, \
                W0, W1, W2, W3, W4, W5, W6, W7, W8, W9, W10 = row
        tVx_given = [V0, V1, V2, V3, V4, V5, V6, V7, V8, V9, V10]
        tWx_given = [W0, W1, W2, W3, W4, W5, W6, W7, W8, W9, W10]
        pv.setArgs(key, sex, x, n, m, AMT, S, alpha1, alpha2, beta1, beta2, beta5, betaPrime, gamma, ce)
        result = pv.main()
        my_prenium, my_tVx, my_tWx = result
        my_NP, my_G, my_NP_beta = my_prenium
        if my_NP!=NP:
            logger.error(msg=f"{t+1}번째 경우- 월납순보험료 오류 - 내 값 : {my_NP} / 정답 : {NP}")
            isError = True
        if my_G!=G:
            logger.error(msg=f"{t+1}번째 경우- 월납영업보험료 오류 - 내 값 : {my_G} / 정답 : {G}")
            isError = True
        if my_NP_beta!=NP_beta:
            logger.error(msg=f"{t+1}번째 경우- 월납베타순보험료 오류 - 내 값 : {my_NP_beta} / 정답 : {NP_beta}")
            isError = True
        for s in range(n-1):
            if int(my_tVx[s]) != int(tVx_given[s]):
                logger.error(msg=f"{t+1}번째 경우- 준비금 V({s})오류 - 내 값 : {my_tVx[s]} / 정답 : {tVx_given[s]}")
                isError = True
        for s in range(n-1):
            if int(my_tWx[s]) != int(tWx_given[s]):
                logger.error(msg=f"{t+1}번째 경우- 환급금 V({s})오류 - 내 값 : {my_tWx[s]} / 정답 : {tWx_given[s]}")
                isError = True
        if not isError:
            logger.info(msg=f"{t+1}번째 경우 - OK")